import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel> getCachedUser();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await secureStorage.write(
        key: 'USER_DATA',
        value: jsonEncode(user.toJson()),
      );
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<UserModel> getCachedUser() async {
    try {
      final jsonString = await secureStorage.read(key: 'USER_DATA');
      log("jsonString: $jsonString");

      if (jsonString == null) throw CacheException();

      final decoded = jsonDecode(jsonString);
      log("Decoded JSON: $decoded");

      return UserModel.fromJson(decoded);
    } catch (e, stack) {
      log("Erro ao recuperar usuário do cache: $e");
      log("Stacktrace: $stack");
      throw CacheException();
    }
  }

  @override
  Future<void> clearCache() async {
    await secureStorage.delete(key: 'USER_DATA');
  }
}
