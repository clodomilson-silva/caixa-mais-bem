import 'package:flutter/material.dart';
import '../exercises/exercises_screen.dart';
import '../breathing/breathing_screen.dart';
import '../diary/diary_screen.dart';
import '../education/education_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeTab(),
    const ExercisesScreen(),
    const BreathingScreen(),
    const DiaryScreen(),
    const EducationScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Exercícios',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.air), label: 'Respiração'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Diário'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Educação'),
        ],
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int? _selectedMood; // Para rastrear o humor selecionado

  // Definir os diferentes humores
  final List<Map<String, dynamic>> _moods = [
    {
      'icon': Icons.sentiment_very_satisfied,
      'label': 'Alegre',
      'color': Colors.green,
      'moodType': 'happy',
    },
    {
      'icon': Icons.sentiment_dissatisfied,
      'label': 'Triste',
      'color': Colors.blue,
      'moodType': 'sad',
    },
    {
      'icon': Icons.sentiment_neutral,
      'label': 'Neutro',
      'color': Colors.grey,
      'moodType': 'neutral',
    },
    {
      'icon': Icons.sentiment_satisfied,
      'label': 'Calmo',
      'color': Colors.purple,
      'moodType': 'calm',
    },
    {
      'icon': Icons.sentiment_very_dissatisfied,
      'label': 'Estressado',
      'color': Colors.red,
      'moodType': 'stressed',
    },
  ];

  void _onMoodSelected(int moodIndex) {
    setState(() {
      _selectedMood = moodIndex;
    });

    // Navegar para a tela de educação com dicas específicas
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EducationScreen(
          moodType: _moods[moodIndex]['moodType'],
          moodLabel: _moods[moodIndex]['label'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caixa Mais Bem'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implementar notificações
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implementar configurações
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saudação
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Olá! Como você está se sentindo hoje?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Vamos cuidar do seu bem-estar juntos!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < _moods.length; i++)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: GestureDetector(
                                onTap: () => _onMoodSelected(i),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _selectedMood == i
                                            ? _moods[i]['color'].withOpacity(
                                                0.2,
                                              )
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: _selectedMood == i
                                              ? _moods[i]['color']
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        _moods[i]['icon'],
                                        size: 32,
                                        color: _moods[i]['color'],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _moods[i]['label'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _selectedMood == i
                                            ? _moods[i]['color']
                                            : Colors.grey[600],
                                        fontWeight: _selectedMood == i
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Ações rápidas
            const Text(
              'Ações Rápidas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _QuickActionCard(
                  icon: Icons.fitness_center,
                  title: 'Exercícios',
                  subtitle: 'Alongue-se agora',
                  color: const Color(0xFFFFB300), // Amarelo dourado
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExercisesScreen(),
                      ),
                    );
                  },
                ),
                _QuickActionCard(
                  icon: Icons.air,
                  title: 'Respiração',
                  subtitle: 'Relaxe 5 minutos',
                  color: const Color(0xFFFFE082), // Amarelo suave
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BreathingScreen(),
                      ),
                    );
                  },
                ),
                _QuickActionCard(
                  icon: Icons.book,
                  title: 'Diário',
                  subtitle: 'Como foi seu dia?',
                  color: const Color(0xFFFF8F00), // Laranja quente
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DiaryScreen(),
                      ),
                    );
                  },
                ),
                _QuickActionCard(
                  icon: Icons.school,
                  title: 'Educação',
                  subtitle: 'Aprenda mais',
                  color: const Color(0xFFFFAB00), // Âmbar
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EducationScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Estatísticas rápidas
            const Text(
              'Seu Progresso',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatsCard(
                    title: 'Exercícios',
                    value: '5',
                    subtitle: 'esta semana',
                    icon: Icons.fitness_center,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatsCard(
                    title: 'Meditação',
                    value: '15 min',
                    subtitle: 'hoje',
                    icon: Icons.air,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;

  const _StatsCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
