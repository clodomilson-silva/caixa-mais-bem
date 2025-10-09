import 'package:flutter/material.dart';
import '../../components/exercise_card.dart';

class ExercisesTab extends StatelessWidget {
  const ExercisesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(
      5,
      (i) => {
        'title': 'Alongamento rápido ${i + 1}',
        'subtitle': 'Duração: 2 minutos',
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercícios'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ExerciseCard(
            title: item['title']!,
            subtitle: item['subtitle']!,
            onPlay: () {
              // TODO: implementar player / tela de vídeo
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reproduzir vídeo (em breve)')),
              );
            },
          );
        },
      ),
    );
  }
}
