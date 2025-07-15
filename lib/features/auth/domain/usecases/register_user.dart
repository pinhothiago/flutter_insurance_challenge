import 'package:flutter_insurance_challenge/features/auth/domain/entities/user.dart';
import 'package:flutter_insurance_challenge/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<User> call({
    required String cpf,
    required String password,
    required String name,
  }) async {
    return await repository.register(cpf, password);
  }
}
