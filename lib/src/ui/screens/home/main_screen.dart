import 'package:flutter/material.dart';
import '../exercises/exercises_screen.dart';
import '../breathing/breathing_screen.dart';
import '../diary/diary_screen.dart';
import '../education/education_screen.dart';
import '../settings/profile_screen.dart';
import '../settings/notifications_screen.dart';
import '../settings/support_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeTab(),
    const ExercisesScreen(showAppBar: false),
    const BreathingScreen(showAppBar: false),
    const DiaryScreen(showAppBar: false),
    const EducationScreen(showAppBar: false),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Títulos das tabs para o AppBar
    final List<String> titles = [
      'Caixa Mais Bem',
      'Exercícios e Dicas',
      'Respiração & Relaxamento',
      'Diário Emocional',
      'Vídeos Educativos',
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove ícone de volta
        title: Text(titles[_selectedIndex]),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
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
              _showSettingsMenu(context);
            },
          ),
        ],
      ),
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

  void _showSettingsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Configurações',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildMenuOption(
                context,
                icon: Icons.person,
                title: 'Perfil',
                subtitle: 'Gerenciar informações pessoais',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
              _buildMenuOption(
                context,
                icon: Icons.notifications,
                title: 'Notificações',
                subtitle: 'Configurar alertas e lembretes',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsScreen(),
                    ),
                  );
                },
              ),
              _buildMenuOption(
                context,
                icon: Icons.support_agent,
                title: 'Suporte',
                subtitle: 'Ajuda e contato',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SupportScreen(),
                    ),
                  );
                },
              ),
              _buildMenuOption(
                context,
                icon: Icons.exit_to_app,
                title: 'Sair',
                subtitle: 'Fazer logout da conta',
                onTap: () {
                  Navigator.pop(context);
                  _showLogoutDialog(context);
                },
                isDestructive: true,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDestructive
              ? Colors.red.withOpacity(0.1)
              : Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isDestructive ? Colors.red : Theme.of(context).primaryColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey[400],
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Saída'),
          content: const Text('Tem certeza que deseja sair da sua conta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Sair', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
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

  // Definir os diferentes humores com nova paleta de cores
  final List<Map<String, dynamic>> _moods = [
    {
      'icon': Icons.sentiment_very_satisfied,
      'label': 'Alegre',
      'color': Color(0xFF66BB6A), // Verde natural - energia positiva
      'moodType': 'happy',
    },
    {
      'icon': Icons.sentiment_dissatisfied,
      'label': 'Triste',
      'color': Color(0xFF42A5F5), // Azul suave - tranquilidade
      'moodType': 'sad',
    },
    {
      'icon': Icons.sentiment_neutral,
      'label': 'Neutro',
      'color': Color(0xFF9E9E9E), // Cinza equilibrado
      'moodType': 'neutral',
    },
    {
      'icon': Icons.sentiment_satisfied,
      'label': 'Calmo',
      'color': Color(0xFF26A69A), // Teal principal - serenidade
      'moodType': 'calm',
    },
    {
      'icon': Icons.sentiment_very_dissatisfied,
      'label': 'Stress',
      'color': Color(0xFFFF7043), // Coral - atenção sem agressividade
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
                  color: const Color(0xFF66BB6A), // Verde natural - energia
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
                  color: const Color(0xFF26A69A), // Teal - tranquilidade
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
                  color: const Color(0xFF42A5F5), // Azul - reflexão
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
                  color: const Color(0xFF7986CB), // Índigo - conhecimento
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
