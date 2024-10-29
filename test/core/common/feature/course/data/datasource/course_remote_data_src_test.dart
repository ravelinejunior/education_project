import 'package:education_project/core/common/feature/course/data/datasource/course_remote_data_src.dart';
import 'package:education_project/core/common/feature/course/data/model/course_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  late CourseRemoteDataSrc courseRemoteDataSrc;
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseStorage mockFirebaseStorage;

  setUp(() async {
    fakeFirebaseFirestore = FakeFirebaseFirestore();

    final user = MockUser(
      uid: 'uid123!##1234',
      email: 'test123@gmail.com',
      displayName: 'test123',
    );

    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    mockFirebaseAuth = MockFirebaseAuth(mockUser: user);
    await mockFirebaseAuth.signInWithCredential(credential);

    mockFirebaseStorage = MockFirebaseStorage();
    courseRemoteDataSrc = CourseRemoteDataSrcImpl(
      auth: mockFirebaseAuth,
      firestore: fakeFirebaseFirestore,
      storage: mockFirebaseStorage,
    );
  });

  group(
    'addCourse',
    () {
      test(
        'should add course to firestore ti the firestore collection',
        () async {
          // Arrange
          final tCourse = CourseModel.empty();

          // Act
          await courseRemoteDataSrc.addCourse(tCourse);

          // Assert
          final firestoreData =
              await fakeFirebaseFirestore.collection('Courses').get();
          expect(firestoreData.docs.length, 1);

          final courseRef = firestoreData.docs.first;
          expect(courseRef.data()['id'], courseRef.id);

          final groupData =
              await fakeFirebaseFirestore.collection('Groups').get();
          expect(groupData.docs.length, 1);

          final groupRef = groupData.docs.first;
          expect(groupRef.data()['id'], groupRef.id);
          expect(groupRef.data()['courseId'], courseRef.id);
          expect(courseRef.data()['groupId'], groupRef.id);
        },
      );
    },
  );
}
