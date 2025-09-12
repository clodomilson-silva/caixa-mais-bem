import 'package:flutter/material.dart';
import 'package:caixa_mais_bem/src/widgets/rounded_card.dart';

class ContentTab extends StatelessWidget {
  const ContentTab({super.key});

  @override
  Widget build(BuildContext context) {
    final contents = [
      {'title': 'Ergonomia no caixa', 'subtitle': 'Dicas rápidas para postura'},
      {'title': 'Alimentação e energia', 'subtitle': 'Lanches rápidos e saudáveis'}
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Conteúdo educativo')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: contents.length,
        itemBuilder: (context, index) {
          final item = contents[index];
          return RoundedCard(
            child: ListTile(
              title: Text(item['title']!),
              subtitle: Text(item['subtitle']!),
              trailing: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () {
                // TODO: abrir página de conteúdo
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Abrir conteúdo (em breve)')));
              }),
            ),
          );
        },
      ),
    );
  }
}
