import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_insurance_challenge/blocs/auth_bloc.dart';
import 'package:flutter_insurance_challenge/core/network/network_info.dart';
import 'package:flutter_insurance_challenge/features/auth/data/datasources/auth_local_data_source_impl.dart';
import 'package:flutter_insurance_challenge/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_insurance_challenge/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_insurance_challenge/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:flutter_insurance_challenge/features/auth/domain/usecases/cache_user.dart';
import 'package:flutter_insurance_challenge/features/auth/domain/usecases/login_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPrefs);
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: getIt(), firestore: getIt()),
  );

  getIt.registerLazySingleton(() => GoogleSignIn());

  getIt.registerLazySingleton(() => const FlutterSecureStorage());

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(Connectivity()),
  );

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(secureStorage: getIt()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
      firebaseAuth: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => LoginUser(getIt()));
  getIt.registerLazySingleton(() => CacheUser(getIt()));

  getIt.registerLazySingleton(
    () => AuthBloc(
      authRepository: getIt(),
      cacheUser: getIt(),
      googleSignInUser: getIt(),
    ),
  );
}
