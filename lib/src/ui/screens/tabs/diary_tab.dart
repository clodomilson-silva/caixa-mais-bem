import 'package:flutter/material.dart';
import 'package:caixa_mais_bem/src/widgets/rounded_card.dart';

class DiaryTab extends StatelessWidget {
  const DiaryTab({super.key});

  void _showRegisterDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Registrar sentimento'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Como você se sente?'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: salvar no Firestore
              Navigator.of(context).pop();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Registrado')));
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diário emocional'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            RoundedCard(
              child: ListTile(
                leading: const Icon(Icons.emoji_emotions_outlined),
                title: const Text('Como você se sente agora?'),
                trailing: ElevatedButton(
                  onPressed: () => _showRegisterDialog(context),
                  child: const Text('Registrar'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Center(
                child: Text(
                  'Histórico (em breve)',
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
