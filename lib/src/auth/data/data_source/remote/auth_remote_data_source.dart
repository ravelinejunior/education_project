import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_project/core/enum/update_user_enum.dart';
import 'package:education_project/core/errors/exceptions.dart';
import 'package:education_project/core/utils/constants.dart';
import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/src/auth/data/model/user_model.dart';
import 'package:education_project/src/auth/domain/entity/local_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

abstract class AuthRemoteDataSource {
  Future<void> forgotPassword(String email);

  Future<LocalUser> signIn({required String email, required String password});

  Future<void> signOut();

  Future<LocalUserModel> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore,
        _firebaseStorage = firebaseStorage;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'A Firebase Auth Error Occured',
        statusCode: int.tryParse(e.code) ?? 505,
      );
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      throw ServerException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  Future<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = authResult.user;
      if (user == null) {
        throw const ServerException(
          message: 'User not found',
          statusCode: 505,
        );
      }

      var userData = await _getUserData(user.uid);
      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      } else {
        //Upload User
        await setUserFirebase(
          user: user,
          fallbackEmail: email,
        );

        userData = await _getUserData(user.uid);
        return LocalUserModel.fromMap(userData.data()!);
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'A Firebase Auth Error Occured',
        statusCode: int.tryParse(e.code) ?? 505,
      );
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      throw ServerException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<LocalUserModel> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = authResult.user;
      if (user == null) {
        throw const ServerException(
          message: 'User was not created',
          statusCode: 505,
        );
      }

      await user.updateDisplayName(fullName);
      await user.updatePhotoURL(kDefaultAvatar);

      await setUserFirebase(
        user: user,
        fallbackEmail: email,
        userName: fullName,
      );

      final userData = await _getUserData(user.uid);
      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'A Firebase Auth Error Occured',
        statusCode: int.tryParse(e.code) ?? 505,
      );
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      throw ServerException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserAction.bio:
          await _updateUserData({'bio': userData});

        case UpdateUserAction.displayName:
          await _firebaseAuth.currentUser!.updateDisplayName(
            userData as String,
          );
          await _updateUserData({'fullName': userData});

        case UpdateUserAction.email:
          // ignore: deprecated_member_use
          await _firebaseAuth.currentUser!.updateEmail(
            userData as String,
          );
          await _updateUserData({'email': userData});
        case UpdateUserAction.profileImage:
          final reference = _firebaseStorage.ref().child('Profile_Image').child(
                _firebaseAuth.currentUser!.uid,
              );

          await reference.putFile(userData as File);
          final url = await reference.getDownloadURL();
          await _firebaseAuth.currentUser?.updatePhotoURL(url);

          await _updateUserData({'profileImageUrl': url});

        case UpdateUserAction.password:
          if (_firebaseAuth.currentUser?.email == null) {
            throw const ServerException(
              message: 'User does not exists',
              statusCode: 505,
            );
          }

          final newData = jsonDecode(userData as String) as DataMap;

          await _firebaseAuth.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _firebaseAuth.currentUser!.email!,
              password: newData['oldPassword'] as String,
            ),
          );

          await _firebaseAuth.currentUser?.updatePassword(
            newData['newPassword'] as String,
          );
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'A Firebase Auth Error Occured',
        statusCode: int.tryParse(e.code) ?? 505,
      );
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      throw ServerException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _firebaseFirestore.collection('Users').doc(uid).get();
  }

  Future<void> setUserFirebase({
    required User user,
    required String fallbackEmail,
    String? userName,
  }) async {
    await _firebaseFirestore.collection('Users').doc(user.uid).set(
          LocalUserModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            fullName: userName ?? user.displayName ?? '',
            points: 0,
            bio: '',
            profileImageUrl: user.photoURL ?? '',
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap data) async {
    await _firebaseFirestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser?.uid)
        .update(data);
  }
}
