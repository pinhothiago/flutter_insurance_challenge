import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_insurance_challenge/core/errors/exceptions.dart';
import 'package:flutter_insurance_challenge/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String cpf, String password);
  Future<void> logout();
  Future<UserModel> register({required String cpf, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> login(String cpf, String password) async {
    try {
      final email = _formatCpfToEmail(cpf);
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebase(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: _mapFirebaseError(e));
    }
  }

  @override
  Future<UserModel> register({
    required String cpf,
    required String password,
  }) async {
    try {
      final email = _formatCpfToEmail(cpf);

      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserModel.fromFirebase(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: _mapFirebaseError(e));
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      log("Logout executed...");
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: _mapFirebaseError(e));
    }
  }

  String _formatCpfToEmail(String cpf) {
    final cleanedCpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    return '$cleanedCpf@segurosapp.com';
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'CPF já cadastrado';
      case 'weak-password':
        return 'Senha muito fraca (mínimo 6 caracteres)';
      case 'user-not-found':
        return 'CPF não cadastrado';
      case 'wrong-password':
        return 'Senha incorreta';
      default:
        return e.message ?? 'Erro na autenticação';
    }
  }
}
