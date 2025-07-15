import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class CacheUser {
  final AuthRepository repository;

  CacheUser(this.repository);

  Future<void> call(User user) async {
    if (user.isEmpty) {
      throw ArgumentError('Cannot cache empty user');
    }
    await repository.cacheUser(user);
  }
}
