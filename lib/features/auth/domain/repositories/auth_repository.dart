import 'package:flutter_insurance_challenge/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String cpf, String password);
  Future<User> register(String cpf, String password);
  Future<void> cacheUser(User user);
  Future<User?> getCachedUser();
  Future<void> logout();
}
