import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginRequested extends AuthEvent {
  final String cpf;
  final String password;
  final bool rememberMe;

  const LoginRequested(this.cpf, this.password, this.rememberMe);

  @override
  List<Object> get props => [cpf, password, rememberMe];
}

class LogoutRequested extends AuthEvent {
  @override
  List<Object> get props => [];
}

class RegisterRequested extends AuthEvent {
  final String cpf;
  final String password;

  const RegisterRequested({required this.cpf, required this.password});

  @override
  List<Object> get props => [cpf, password];
}

class CheckAuthStatus extends AuthEvent {
  @override
  List<Object> get props => [];
}

class GoogleLoginRequested extends AuthEvent {
  @override
  List<Object> get props => [];
}
