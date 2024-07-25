import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_project/core/enum/update_user_enum.dart';
import 'package:education_project/core/errors/exceptions.dart';
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
  Future<LocalUser> signIn({required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<LocalUserModel> signUp({
    required String email,
    required String fullName,
    required String password,
  }) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
