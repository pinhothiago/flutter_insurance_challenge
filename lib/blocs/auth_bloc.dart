import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_insurance_challenge/blocs/auth_event.dart';
import 'package:flutter_insurance_challenge/blocs/auth_state.dart';
import 'package:flutter_insurance_challenge/features/auth/domain/entities/user.dart';
import 'package:flutter_insurance_challenge/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_insurance_challenge/features/auth/domain/usecases/cache_user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final CacheUser cacheUser;

  AuthBloc({required this.authRepository, required this.cacheUser})
    : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogOut);
    on<CheckAuthStatus>((event, emit) async {
      emit(AuthLoading());
      try {
        final cachedUser = await authRepository.getCachedUser();
        if (cachedUser != null) {
          emit(AuthAuthenticated(cachedUser));
        } else {
          emit(AuthInitial());
        }
      } catch (e) {
        emit(AuthInitial());
      }
    });

    on<RegisterRequested>(_register);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await authRepository.login(event.cpf, event.password);

      if (event.rememberMe) {
        await cacheUser(user);
      }

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogOut(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await authRepository.logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError('Logout failed: ${e.toString()}'));
    }
  }

  Future<void> _register(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      User user = await authRepository.register(event.cpf, event.password);
      await cacheUser(user);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError('Logout failed: ${e.toString()}'));
    }
  }
}
