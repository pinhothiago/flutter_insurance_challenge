import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_insurance_challenge/blocs/auth_bloc.dart';
import 'package:flutter_insurance_challenge/blocs/auth_event.dart';
import 'package:flutter_insurance_challenge/blocs/auth_state.dart';
import 'package:flutter_insurance_challenge/core/utils/input_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bem-vindo!',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            TextFormField(
              controller: _cpfController,
              decoration: InputDecoration(
                labelText: 'CPF',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
              validator: InputValidator.validatePassword,
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) => setState(() => _rememberMe = value!),
                ),
                const Text('Lembrar sempre'),
              ],
            ),

            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthAuthenticated) {
                  Navigator.of(context).pushReplacementNamed('/home');
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Entrar'),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(child: Divider(thickness: 1)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('ou entre com'),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialIcon(FontAwesomeIcons.google, Colors.redAccent),
                const SizedBox(width: 20),
                _socialIcon(FontAwesomeIcons.facebookF, Colors.blueAccent),
                const SizedBox(width: 20),
                _socialIcon(FontAwesomeIcons.twitter, Colors.lightBlue),
              ],
            ),

            const SizedBox(height: 32),

            TextButton(
              child: const Text('Não tem conta? Registre-se'),
              onPressed: () {
                Navigator.of(context).pushNamed('/register');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.1),
      ),
      child: IconButton(
        icon: FaIcon(icon, color: color),
        onPressed: () {},
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          _cpfController.text,
          _passwordController.text,
          _rememberMe,
        ),
      );
    }
  }
}
