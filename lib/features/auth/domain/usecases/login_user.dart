import '../../../../core/errors/exceptions.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<User> call({
    required String cpf,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      final user = await repository.login(cpf, password);

      if (rememberMe) {
        await repository.cacheUser(user);
      }

      return user;
    } on ServerException catch (e) {
      throw AuthException('Login failed: ${e.message}');
    } on CacheException catch (e) {
      throw AuthException('Failed to save session: ${e.message}');
    }
  }
}
