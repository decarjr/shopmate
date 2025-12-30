import 'package:flutter/material.dart';

import '../../../../core/constants/app_routes.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  void _finish(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.listsHome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo ao ShopMate!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Complete as etapas básicas para começar a usar o app.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            const ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Informe seu nome'),
              subtitle: Text('Usado para personalizar a experiência.'),
            ),
            const ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text('Defina seu país e moeda'),
              subtitle: Text('Importante para orçamento e preços.'),
            ),
            const ListTile(
              leading: Icon(Icons.palette_outlined),
              title: Text('Escolha o tema'),
              subtitle: Text('Claro ou escuro, você decide.'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _finish(context),
                child: const Text('Começar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
