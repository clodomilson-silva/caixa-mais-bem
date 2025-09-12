import 'package:flutter/material.dart';
import '../../../models/mood_entry.dart';
import '../../../services/mood_repository.dart';
import '../../../core/constants.dart';
import 'quick_mood_entry_screen.dart';
import 'mood_history_screen_simple.dart' as history;
import 'mood_insights_screen.dart';
import 'weekly_reflection_screen.dart';
import '../breathing/breathing_screen.dart';
import '../exercises/exercises_screen.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  bool _hasEntryToday = false;
  int _currentStreak = 0;
  MoodEntry? _lastEntry;
  Map<String, dynamic> _stats = {};
  List<String> _insights = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final hasEntry = await MoodRepository.hasEntryToday();
      final streak = await MoodRepository.getCurrentStreak();
      final lastEntry = await MoodRepository.getLastEntry();
      final stats = await MoodRepository.getGeneralStats();
      final insights = await MoodRepository.generateInsights();

      setState(() {
        _hasEntryToday = hasEntry;
        _currentStreak = streak;
        _lastEntry = lastEntry;
        _stats = stats;
        _insights = insights;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Diário Emocional',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFF7043),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () => _showInfoDialog(),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Header com gradiente
                    _buildHeader(),

                    // Check-in rápido ou status de hoje
                    _buildTodaySection(),

                    // Estatísticas
                    _buildStatsSection(),

                    // Insights
                    if (_insights.isNotEmpty) _buildInsightsSection(),

                    // Ações principais
                    _buildActionsSection(),

                    // Última entrada
                    if (_lastEntry != null) _buildLastEntrySection(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFF7043), Color(0xFFFF8A65)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.favorite, size: 48, color: Colors.white),
            const SizedBox(height: 12),
            const Text(
              'Como você está se sentindo?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _hasEntryToday
                  ? 'Você já registrou suas emoções hoje! 🎉'
                  : 'Vamos registrar suas emoções de hoje',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaySection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _hasEntryToday
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFFF7043),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _hasEntryToday ? Icons.check : Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _hasEntryToday
                          ? 'Registro de Hoje'
                          : 'Check-in Emocional',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E2E2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _hasEntryToday
                          ? 'Obrigado por compartilhar suas emoções!'
                          : 'Como está seu dia até agora?',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _navigateToQuickEntry(),
              style: ElevatedButton.styleFrom(
                backgroundColor: _hasEntryToday
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFFF7043),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _hasEntryToday ? 'Adicionar Outro Registro' : 'Registrar Agora',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Sequência',
              '$_currentStreak dias',
              Icons.local_fire_department,
              AppColors.energy,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Registros',
              '${_stats['totalEntries'] ?? 0}',
              Icons.book,
              AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Humor Médio',
              '${(_stats['averageMood'] ?? 0.0).toStringAsFixed(1)}/10',
              Icons.mood,
              AppColors.serenity,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, color.withOpacity(0.02)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.15), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.psychology, color: Color(0xFF9C27B0), size: 24),
              SizedBox(width: 8),
              Text(
                'Insights Pessoais',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E2E2E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...(_insights
              .take(2)
              .map(
                (insight) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xFF9C27B0),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          insight,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList()),
          if (_insights.length > 2)
            TextButton(
              onPressed: () => _navigateToInsights(),
              child: const Text('Ver todos os insights'),
            ),
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.spa, color: AppColors.primary, size: 24),
              const SizedBox(width: 8),
              const Text(
                'Ações de Bem-estar',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Primeira linha - Ações principais de bem-estar
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  'Respiração',
                  'Técnicas de relaxamento',
                  Icons.air,
                  AppColors.serenity,
                  () => _navigateToBreathing(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionCard(
                  'Exercícios',
                  'Atividades físicas',
                  Icons.fitness_center,
                  AppColors.energy,
                  () => _navigateToExercises(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Segunda linha - Análise e histórico
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  'Histórico',
                  'Ver registros anteriores',
                  Icons.timeline,
                  AppColors.balance,
                  () => _navigateToHistory(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionCard(
                  'Insights',
                  'Análise do seu humor',
                  Icons.psychology,
                  AppColors.vitality,
                  () => _navigateToInsights(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Terceira linha - Reflexão e configurações
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  'Reflexão',
                  'Perguntas semanais',
                  Icons.self_improvement,
                  AppColors.peace,
                  () => _navigateToWeeklyReflection(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionCard(
                  'Alertas',
                  'Configurar pausas',
                  Icons.notifications_active,
                  AppColors.mindfulness,
                  () => _navigateToAlerts(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('DEBUG: Botão "$title" clicado');
          onTap();
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2), width: 1),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLastEntrySection() {
    if (_lastEntry == null) return const SizedBox();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Último Registro',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2E2E),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getMoodColor(_lastEntry!.moodLevel),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '${_lastEntry!.moodLevel}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _lastEntry!.emotions.join(', '),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(_lastEntry!.timestamp),
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_lastEntry!.notes != null && _lastEntry!.notes!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _lastEntry!.notes!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getMoodColor(int mood) {
    if (mood <= 3) return AppColors.error;
    if (mood <= 5) return AppColors.warning;
    if (mood <= 7) return AppColors.primary;
    return AppColors.vitality;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) return 'Hoje';
    if (difference == 1) return 'Ontem';
    return '${date.day}/${date.month}/${date.year}';
  }

  void _navigateToQuickEntry() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuickMoodEntryScreen()),
    );

    if (result == true) {
      _loadData();
    }
  }

  void _navigateToHistory() {
    print('DEBUG: Navegando para History...');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const history.MoodHistoryScreen(),
      ),
    );
  }

  void _navigateToInsights() {
    print('DEBUG: Navegando para Insights...');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MoodInsightsScreen()),
    );
  }

  void _navigateToWeeklyReflection() {
    print('DEBUG: Navegando para Weekly Reflection...');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WeeklyReflectionScreen()),
    );
  }

  void _navigateToBreathing() {
    print('DEBUG: Navegando para Breathing...');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BreathingScreen()),
    );
  }

  void _navigateToExercises() {
    print('DEBUG: Navegando para Exercises...');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExercisesScreen()),
    );
  }

  void _navigateToAlerts() {
    print('DEBUG: Navegando para Alerts...');
    // TODO: Implementar tela de alertas
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Funcionalidade de alertas em desenvolvimento'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info, color: Color(0xFFFF7043)),
            SizedBox(width: 8),
            Text('Sobre o Diário Emocional'),
          ],
        ),
        content: const Text(
          'O Diário Emocional te ajuda a:\n\n'
          '• Registrar suas emoções diariamente\n'
          '• Identificar padrões e gatilhos\n'
          '• Desenvolver autoconhecimento\n'
          '• Acompanhar seu progresso emocional\n'
          '• Receber insights personalizados\n\n'
          'Seus dados são mantidos privados e seguros no seu dispositivo.',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendi'),
          ),
        ],
      ),
    );
  }
}
