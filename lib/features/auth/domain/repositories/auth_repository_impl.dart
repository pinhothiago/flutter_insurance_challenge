import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_insurance_challenge/core/errors/exceptions.dart';
import 'package:flutter_insurance_challenge/core/network/network_info.dart';
import 'package:flutter_insurance_challenge/features/auth/data/datasources/auth_local_data_source_impl.dart';
import 'package:flutter_insurance_challenge/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_insurance_challenge/features/auth/data/models/user_model.dart';
import 'package:flutter_insurance_challenge/features/auth/domain/entities/user.dart';
import 'package:flutter_insurance_challenge/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final fb_auth.FirebaseAuth firebaseAuth;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.firebaseAuth,
    required this.networkInfo,
  });

  @override
  Future<User> login(String cpf, String password) async {
    if (!await networkInfo.isConnected) {
      throw NetworkException();
    }

    try {
      final user = await remoteDataSource.login(cpf, password);
      await localDataSource.cacheUser(user);
      return user;
    } on ServerException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<User> register(String cpf, String password) async {
    if (!await networkInfo.isConnected) {
      throw NetworkException();
    }

    try {
      final user = await remoteDataSource.register(
        cpf: cpf,
        password: password,
      );
      await localDataSource.cacheUser(user);
      return user;
    } on ServerException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<User?> getCachedUser() async {
    try {
      return await localDataSource.getCachedUser();
    } on CacheException {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearCache();
    } on ServerException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<void> cacheUser(User user) async {
    try {
      await localDataSource.cacheUser(UserModel.fromEntity(user));
    } on CacheException catch (e) {
      throw AuthException('Falha ao salvar dados locais: ${e.message}');
    }
  }
}
