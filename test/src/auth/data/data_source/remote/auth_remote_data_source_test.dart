import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_project/core/errors/exceptions.dart';
import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/src/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:education_project/src/auth/data/model/user_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

const tFullname = 'Franklin test';
const tEmail = 'n0p6b@example.com';
const tPassword = '123456';
final tFirebaseAuthException = FirebaseAuthException(
  code: 'user-not-found',
  message: 'There is no user record corresponding to this identifier.',
);

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  /*  User? _user;
  @override
  User? get currentUser => null;

  set currentUser(User? user) {
    if (_user != user) {
      _user = user;
    }
  } */
}

class MockUser extends Mock implements User {
  String _uid = '!@3456';

  @override
  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }
}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential([User? user]) : _user = user;
  User? _user;

  @override
  User? get user => _user;

  set user(User? value) {
    if (_user != value) {
      _user = value;
    }
  }
}

void main() {
  late FirebaseAuth authClient;
  late FirebaseStorage storageClient;
  late FirebaseFirestore firestoreClient;
  late AuthRemoteDataSource authRemoteDataSource;
  late UserCredential userCredential;
  late DocumentReference<DataMap> documentReference;
  late MockUser mockUser;

  final tUser = LocalUserModel.empty();

  setUpAll(() async {
    authClient = MockFirebaseAuth();
    storageClient = MockFirebaseStorage();
    firestoreClient = FakeFirebaseFirestore();
    documentReference = await firestoreClient.collection('Users').add(
          tUser.toMap(),
        );
    mockUser = MockUser()..uid = documentReference.id;

    userCredential = MockUserCredential(mockUser);
    authRemoteDataSource = AuthRemoteDataSourceImpl(
      firebaseAuth: authClient,
      firebaseFirestore: firestoreClient,
      firebaseStorage: storageClient,
    );

    when(() => authClient.currentUser).thenReturn(mockUser);
  });

  group('forgotPassword', () {
    test('should call forgotPassword from [AuthRepository]', () async {
      when(
        () => authClient.sendPasswordResetEmail(email: any(named: 'email')),
      ).thenAnswer((_) async => Future.value);

      final call = authRemoteDataSource.forgotPassword(tEmail);
      expect(call, completes);

      verify(() => authClient.sendPasswordResetEmail(email: tEmail)).called(1);
      verifyNoMoreInteractions(authClient);
    });

    test(
      'should throw [ServerException] when [FirebaseAuthException] is throwm',
      () async {
        // arrange
        when(
          () => authClient.sendPasswordResetEmail(email: any(named: 'email')),
        ).thenThrow(
          tFirebaseAuthException,
        );
        // act
        final call = authRemoteDataSource.forgotPassword;

        // assert
        expect(() => call(tEmail), throwsA(isA<ServerException>()));
        verify(() => authClient.sendPasswordResetEmail(email: tEmail))
            .called(1);
        verifyNoMoreInteractions(authClient);
      },
    );
  });
}
