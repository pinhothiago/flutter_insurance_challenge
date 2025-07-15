import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.cpf,
  });

  factory UserModel.fromFirebase(firebase.User user) {
    return UserModel(
      id: user.uid,
      name: user.displayName ?? 'Usuário',
      email: user.email ?? '',
      cpf: user.phoneNumber,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      cpf: json['cpf'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      cpf: user.cpf,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'cpf': cpf};
  }
}
