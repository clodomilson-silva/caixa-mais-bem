import 'package:flutter/material.dart';

class WeeklyReflectionScreen extends StatefulWidget {
  const WeeklyReflectionScreen({super.key});

  @override
  State<WeeklyReflectionScreen> createState() => _WeeklyReflectionScreenState();
}

class _WeeklyReflectionScreenState extends State<WeeklyReflectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reflexão Semanal'),
        backgroundColor: const Color(0xFF9C27B0),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.quiz, size: 64, color: Colors.purple),
            SizedBox(height: 16),
            Text('Reflexões em desenvolvimento'),
            Text('Em breve perguntas reflexivas semanais'),
          ],
        ),
      ),
    );
  }
}
