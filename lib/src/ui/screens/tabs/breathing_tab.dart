import 'package:flutter/material.dart';
import 'package:caixa_mais_bem/src/widgets/rounded_card.dart';
import 'package:caixa_mais_bem/src/widgets/primary_button.dart';

class BreathingTab extends StatelessWidget {
  const BreathingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Respiração'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            RoundedCard(
              child: Column(
                children: [
                  const Icon(Icons.self_improvement, size: 120),
                  const SizedBox(height: 12),
                  Text(
                    'Técnica 4-4-4',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text('Inspire 4s • Segure 4s • Expire 4s'),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    label: 'Iniciar guia',
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Guia de respiração (em breve)'),
                      ),
                    ),
                    expanded: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Text(
                  'Exercícios de respiração guiada aparecerão aqui.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
