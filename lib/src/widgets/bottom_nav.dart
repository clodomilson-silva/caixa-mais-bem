import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.accessibility_new), label: 'Exercícios'),
        BottomNavigationBarItem(icon: Icon(Icons.self_improvement), label: 'Respirar'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Diário'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Pausas'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Conteúdo'),
      ],
    );
  }
}
