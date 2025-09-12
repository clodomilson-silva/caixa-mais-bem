import 'package:flutter/material.dart';
import 'package:caixa_mais_bem/src/widgets/rounded_card.dart';

class ExerciseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPlay;

  const ExerciseCard({super.key, required this.title, required this.subtitle, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Row(
        children: [
          const CircleAvatar(radius: 26, child: Icon(Icons.play_arrow)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ]),
          ),
          ElevatedButton(onPressed: onPlay, child: const Text('Assistir')),
        ],
      ),
    );
  }
}
