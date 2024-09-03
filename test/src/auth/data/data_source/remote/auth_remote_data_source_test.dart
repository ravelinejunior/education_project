import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_project/core/errors/exceptions.dart';
import 'package:education_project/core/utils/constants.dart';
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
    documentReference = firestoreClient.collection('Users').doc();
    await documentReference.set(
      tUser.copyWith(uid: documentReference.id).toMap(),
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
      'should throw [ServerException] when [FirebaseAuthException] is thrown',
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

  group('signIn', () {
    test('should call signIn from [AuthRepository]', () async {
      // Arrange
      when(
        () => authClient.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => userCredential);

      // Act
      final result =
          await authRemoteDataSource.signIn(email: tEmail, password: tPassword);

      // Assert
      expect(result.uid, userCredential.user?.uid);
      expect(result.points, 0);

      verify(
        () => authClient.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });

    test(
      'should throw [ServerException] when user is null after signing in',
      () async {
        // Arrange
        final emptyUserCredential = MockUserCredential();
        when(
          () => authClient.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => emptyUserCredential);

        // Act
        final result = authRemoteDataSource.signIn;

        // Assert
        expect(
          () => result(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => authClient.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(authClient);
      },
    );

    test(
      'should throw [ServerException] when [FirebaseAuthException] is thrown',
      () async {
        // Arrange
        when(
          () => authClient.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);

        // Act
        final call = authRemoteDataSource.signIn;

        // Assert
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => authClient.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(authClient);
      },
    );
  });

  group('signUp', () {
    test('should call signUp from [AuthRepository]', () async {
      // Arrange
      when(
        () => authClient.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => userCredential);

      when(() => userCredential.user?.updateDisplayName(any()))
          .thenAnswer((_) async {
        return Future.value();
      });

      when(() => userCredential.user?.updatePhotoURL(any()))
          .thenAnswer((_) async {
        return Future.value();
      });

      // Act
      final call = authRemoteDataSource.signUp(
        email: tEmail,
        password: tPassword,
        fullName: tFullname,
      );

      // Assert
      expect(call, completes);

      verify(
        () => authClient.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);

      await untilCalled(() => userCredential.user?.updateDisplayName(any()));
      await untilCalled(() => userCredential.user?.updatePhotoURL(any()));

      verify(
        () => userCredential.user?.updateDisplayName(tFullname),
      ).called(1);

      verify(
        () => userCredential.user?.updatePhotoURL(kDefaultAvatar),
      ).called(1);

      verifyNoMoreInteractions(authClient);
    });

    test(
      'should throw [ServerException] when [FirebaseAuthException] is thrown',
      () async {
        // Arrange
        when(
          () => authClient.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);
        // Act
        final call = authRemoteDataSource.signUp;

        // Assert
        expect(
          () => call(email: tEmail, password: tPassword, fullName: tFullname),
          throwsA(isA<ServerException>()),
        );

        verify(
          () => authClient.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(authClient);
      },
    );
  });
}
