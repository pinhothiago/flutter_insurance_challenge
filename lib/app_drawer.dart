import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_insurance_challenge/blocs/auth_bloc.dart';
import 'package:flutter_insurance_challenge/blocs/auth_event.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.name ?? 'Usuário'),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                user?.name.isNotEmpty ?? false
                    ? user!.name[0].toUpperCase()
                    : '?',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          ..._buildDrawerItems(context),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDrawerItems(BuildContext context) {
    return [
      _drawerItem(context, Icons.home, 'Home / Seguros', () {}),
      _drawerItem(context, Icons.assignment, 'Minhas Contratações', () {}),
      _drawerItem(context, Icons.warning, 'Meus Sinistros', () {}),
      _drawerItem(context, Icons.family_restroom, 'Minha Família', () {}),
      _drawerItem(context, Icons.house, 'Meus Bens', () {}),
      _drawerItem(context, Icons.payment, 'Pagamentos', () {}),
      _drawerItem(context, Icons.security, 'Coberturas', () {}),
      _drawerItem(context, Icons.qr_code, 'Validar Boleto', () {}),
      _drawerItem(context, Icons.phone, 'Telefones Importantes', () {}),
      _drawerItem(context, Icons.settings, 'Configurações', () {}),
    ];
  }

  Widget _drawerItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }

  void _logout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutRequested());
    Navigator.of(context).pushReplacementNamed('/login');
  }
}
