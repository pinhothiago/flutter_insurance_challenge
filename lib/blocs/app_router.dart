import 'package:flutter/material.dart';
import 'package:flutter_insurance_challenge/auth_wrapper.dart';
import 'package:flutter_insurance_challenge/features/home/home_screen.dart';
import 'package:flutter_insurance_challenge/register_screen.dart';
import 'package:flutter_insurance_challenge/screens/login/login.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const AuthWrapper());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Rota ${settings.name} não encontrada')),
          ),
        );
    }
  }
}
