import 'package:equatable/equatable.dart';
import 'package:flutter_insurance_challenge/features/auth/domain/entities/user.dart';

abstract class AuthState extends Equatable {
  final User? user;

  const AuthState({this.user});

  @override
  List<Object?> get props => [user];
}

class AuthInitial extends AuthState {
  const AuthInitial() : super(user: null);
}

class AuthLoading extends AuthState {
  const AuthLoading() : super(user: null);
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(User user) : super(user: user);
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message) : super(user: null);

  @override
  List<Object?> get props => [message, user];
}
