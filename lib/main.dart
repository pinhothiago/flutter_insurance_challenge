import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_insurance_challenge/blocs/app_router.dart';
import 'package:flutter_insurance_challenge/blocs/auth_bloc.dart';
import 'package:flutter_insurance_challenge/blocs/auth_event.dart';
import 'package:flutter_insurance_challenge/core/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeApp();

  runApp(const InsuranceApp());
}

Future<void> _initializeApp() async {
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBjNpJ6j2qnGcz2yiPLeUa10l8kNqwdc8Q",
        appId: "1:755680987008:android:3b5e490588c86ccc64e365",
        messagingSenderId: "755680987008",
        projectId: "flutter-insurance-challenge",
      ),
    );

    await initDependencies();
  } catch (e) {
    log('Erro na inicialização: $e');
    runApp(const ErrorApp());
    rethrow;
  }
}

class InsuranceApp extends StatelessWidget {
  const InsuranceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()..add(CheckAuthStatus())),
      ],
      child: MaterialApp(
        title: 'Seguros App',
        debugShowCheckedModeBanner: false,
        theme: _buildAppTheme(),
        onGenerateRoute: AppRouter().generateRoute,
        initialRoute: '/',
      ),
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 20),
              Text(
                'Erro na inicialização',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              const Text('Por favor, reinicie o aplicativo'),
            ],
          ),
        ),
      ),
    );
  }
}
