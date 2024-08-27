import 'package:education_project/src/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  late FakeFirebaseFirestore cloudStoreClient;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseStorage mockFirebaseFirestore;
  late AuthRemoteDataSource authRemoteDataSource;

  const tPassword = 'Password';
  const tEmail = 'QpNQ8@example.com';
  const tFullName = 'John Doe';

  setUp(() async {
    cloudStoreClient = FakeFirebaseFirestore();
    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount?.authentication;
    final authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Mock User
    final mockUser = MockUser(
      uid: '123',
      displayName: 'John Doe',
      email: 'QpNQ8@example.com',
      photoURL: 'https://example.com/profile.jpg',
    );
    mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser);
    final authResult =
        await mockFirebaseAuth.signInWithCredential(authCredential);
    final user = authResult.user;
    mockFirebaseFirestore = MockFirebaseStorage();

    authRemoteDataSource = AuthRemoteDataSourceImpl(
      firebaseAuth: mockFirebaseAuth,
      firebaseFirestore: cloudStoreClient,
      firebaseStorage: mockFirebaseFirestore,
    );
  });

  test('[signUp] from remote data source', () async {
    // arrange

    // act
    await authRemoteDataSource.signUp(
      email: tEmail,
      fullName: tFullName,
      password: tPassword,
    );

    //Expect that the user was created on firestore and authclient

    // assert
    expect(mockFirebaseAuth.currentUser, isNotNull);
    expect(mockFirebaseAuth.currentUser?.displayName, tFullName);
    expect(mockFirebaseAuth.currentUser?.email, tEmail);
  });
}
