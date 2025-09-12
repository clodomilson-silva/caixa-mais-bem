import 'package:flutter/material.dart';

class MoodInsightsScreen extends StatefulWidget {
  const MoodInsightsScreen({super.key});

  @override
  State<MoodInsightsScreen> createState() => _MoodInsightsScreenState();
}

class _MoodInsightsScreenState extends State<MoodInsightsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights Pessoais'),
        backgroundColor: const Color(0xFF9C27B0),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.psychology, size: 64, color: Colors.purple),
            SizedBox(height: 16),
            Text('Insights em desenvolvimento'),
            Text('Em breve você receberá análises personalizadas'),
          ],
        ),
      ),
    );
  }
}
