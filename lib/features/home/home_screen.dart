import 'package:flutter/material.dart';
import 'package:flutter_insurance_challenge/app_drawer.dart';
import 'package:flutter_insurance_challenge/blocs/insurance_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Seguros'), centerTitle: true),
      drawer: const AppDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Cotar e Contratar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInsuranceGrid(),
          const SizedBox(height: 24),
          _buildFamilySection(),
          const SizedBox(height: 24),
          _buildContractedSection(),
        ],
      ),
    );
  }

  Widget _buildInsuranceGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: const [
        InsuranceCard(type: 'Automóvel', icon: Icons.directions_car),
        InsuranceCard(type: 'Residência', icon: Icons.home),
        InsuranceCard(type: 'Vida', icon: Icons.favorite),
        InsuranceCard(
          type: 'Acidentes Pessoais',
          icon: Icons.health_and_safety,
        ),
      ],
    );
  }

  Widget _buildFamilySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Minha Família',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Adicionar membro'),
        ),
      ],
    );
  }

  Widget _buildContractedSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contratados',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Center(
              child: Text(
                'Nenhum seguro contratado no momento',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
