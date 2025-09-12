import 'package:flutter/material.dart';
import 'package:caixa_mais_bem/src/widgets/bottom_nav.dart';
import 'tabs/exercises_tab.dart';
import 'tabs/breathing_tab.dart';
import 'tabs/diary_tab.dart';
import 'tabs/alerts_tab.dart';
import 'tabs/content_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  final _pages = [const ExercisesTab(), const BreathingTab(), const DiaryTab(), const AlertsTab(), const ContentTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_current]),
      bottomNavigationBar: AppBottomNav(currentIndex: _current, onTap: (i) => setState(() => _current = i)),
    );
  }
}
