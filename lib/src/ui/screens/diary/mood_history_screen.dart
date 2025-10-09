import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../models/mood_entry.dart';
import '../../../services/mood_repository.dart';
import '../../../core/constants.dart';

class MoodHistoryScreen extends StatefulWidget {
  const MoodHistoryScreen({super.key});

  @override
  State<MoodHistoryScreen> createState() => _MoodHistoryScreenState();
}

class _MoodHistoryScreenState extends State<MoodHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<MoodEntry> _allEntries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final entries = await MoodRepository.getAllMoodEntries();
      entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      setState(() {
        _allEntries = entries;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Histórico de Humor',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Gráfico'),
            Tab(text: 'Lista'),
            Tab(text: 'Padrões'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildChartTab(),
                _buildListTab(),
                _buildPatternsTab(),
              ],
            ),
    );
  }

  Widget _buildChartTab() {
    if (_allEntries.isEmpty) {
      return _buildEmptyState('Nenhum registro encontrado');
    }

    final last30Days = _allEntries.where((entry) {
      final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
      return entry.timestamp.isAfter(thirtyDaysAgo);
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gráfico de linha dos últimos 30 dias
          _buildMoodChart(last30Days),

          const SizedBox(height: 24),

          // Estatísticas rápidas
          _buildQuickStats(),

          const SizedBox(height: 24),

          // Distribuição de emoções
          _buildEmotionsChart(),
        ],
      ),
    );
  }

  Widget _buildMoodChart(List<MoodEntry> entries) {
    if (entries.isEmpty) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: Text('Sem dados dos últimos 30 dias')),
      );
    }

    // Agrupar por dia
    final Map<String, List<MoodEntry>> entriesByDay = {};
    for (final entry in entries) {
      final dayKey = '${entry.timestamp.day}/${entry.timestamp.month}';
      entriesByDay[dayKey] ??= [];
      entriesByDay[dayKey]!.add(entry);
    }

    // Calcular média por dia
    final spots = <FlSpot>[];
    int index = 0;
    for (final dayEntries in entriesByDay.values) {
      final average =
          dayEntries.map((e) => e.moodLevel).reduce((a, b) => a + b) /
          dayEntries.length;
      spots.add(FlSpot(index.toDouble(), average));
      index++;
    }

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Evolução do Humor (30 dias)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2E2E),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                  bottomTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minY: 1,
                maxY: 10,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: const Color(0xFF2196F3),
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF2196F3).withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    if (_allEntries.isEmpty) return const SizedBox();

    final last7Days = _allEntries.where((entry) {
      final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
      return entry.timestamp.isAfter(sevenDaysAgo);
    }).toList();

    final last30Days = _allEntries.where((entry) {
      final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
      return entry.timestamp.isAfter(thirtyDaysAgo);
    }).toList();

    final weekAverage = last7Days.isEmpty
        ? 0.0
        : last7Days.map((e) => e.moodLevel).reduce((a, b) => a + b) /
              last7Days.length;

    final monthAverage = last30Days.isEmpty
        ? 0.0
        : last30Days.map((e) => e.moodLevel).reduce((a, b) => a + b) /
              last30Days.length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Esta Semana',
            weekAverage.toStringAsFixed(1),
            Icons.calendar_today,
            const Color(0xFF4CAF50),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Este Mês',
            monthAverage.toStringAsFixed(1),
            Icons.calendar_month,
            const Color(0xFF2196F3),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Total',
            '${_allEntries.length}',
            Icons.bar_chart,
            const Color(0xFFFF7043),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionsChart() {
    // Contar emoções mais frequentes
    final emotionCounts = <String, int>{};
    for (final entry in _allEntries) {
      for (final emotion in entry.emotions) {
        emotionCounts[emotion] = (emotionCounts[emotion] ?? 0) + 1;
      }
    }

    final sortedEmotions = emotionCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Emoções Mais Frequentes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2E2E),
            ),
          ),
          const SizedBox(height: 16),
          ...sortedEmotions.take(5).map((emotion) {
            final percentage = (emotion.value / _allEntries.length * 100)
                .round();
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text(emotion.key)),
                  Expanded(
                    flex: 5,
                    child: LinearProgressIndicator(
                      value: emotion.value / sortedEmotions.first.value,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF2196F3),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$percentage%',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildListTab() {
    if (_allEntries.isEmpty) {
      return _buildEmptyState('Nenhum registro encontrado');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _allEntries.length,
      itemBuilder: (context, index) {
        final entry = _allEntries[index];
        return _buildEntryCard(entry);
      },
    );
  }

  Widget _buildEntryCard(MoodEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getMoodColor(entry.moodLevel),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '${entry.moodLevel}',
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
                      _formatDateTime(entry.timestamp),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.emotions.join(', '),
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (entry.trigger != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Gatilho: ${entry.trigger}',
                style: const TextStyle(fontSize: 12, color: Color(0xFFE65100)),
              ),
            ),
          ],
          if (entry.notes != null && entry.notes!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                entry.notes!,
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

  Widget _buildPatternsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPatternsByDayOfWeek(),
          const SizedBox(height: 24),
          _buildPatternsByTimeOfDay(),
          const SizedBox(height: 24),
          _buildTriggersAnalysis(),
        ],
      ),
    );
  }

  Widget _buildPatternsByDayOfWeek() {
    final dayAverages = <int, List<int>>{};

    for (final entry in _allEntries) {
      final dayOfWeek = entry.timestamp.weekday;
      dayAverages[dayOfWeek] ??= [];
      dayAverages[dayOfWeek]!.add(entry.moodLevel);
    }

    final dayNames = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Padrões por Dia da Semana',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2E2E),
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(7, (index) {
            final dayIndex = index + 1;
            final moods = dayAverages[dayIndex] ?? [];
            final average = moods.isEmpty
                ? 0.0
                : moods.reduce((a, b) => a + b) / moods.length;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      dayNames[index],
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: average / 10,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getMoodColor(average.round()),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    average.toStringAsFixed(1),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPatternsByTimeOfDay() {
    final timeRanges = {
      'Manhã (6-12h)': <int>[],
      'Tarde (12-18h)': <int>[],
      'Noite (18-24h)': <int>[],
      'Madrugada (0-6h)': <int>[],
    };

    for (final entry in _allEntries) {
      final hour = entry.timestamp.hour;
      if (hour >= 6 && hour < 12) {
        timeRanges['Manhã (6-12h)']!.add(entry.moodLevel);
      } else if (hour >= 12 && hour < 18) {
        timeRanges['Tarde (12-18h)']!.add(entry.moodLevel);
      } else if (hour >= 18 && hour < 24) {
        timeRanges['Noite (18-24h)']!.add(entry.moodLevel);
      } else {
        timeRanges['Madrugada (0-6h)']!.add(entry.moodLevel);
      }
    }

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Padrões por Período do Dia',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2E2E),
            ),
          ),
          const SizedBox(height: 16),
          ...timeRanges.entries.map((range) {
            final average = range.value.isEmpty
                ? 0.0
                : range.value.reduce((a, b) => a + b) / range.value.length;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      range.key,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: LinearProgressIndicator(
                      value: average / 10,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getMoodColor(average.round()),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    average.toStringAsFixed(1),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTriggersAnalysis() {
    final triggerCounts = <String, int>{};
    for (final entry in _allEntries) {
      if (entry.trigger != null) {
        triggerCounts[entry.trigger!] =
            (triggerCounts[entry.trigger!] ?? 0) + 1;
      }
    }

    if (triggerCounts.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text('Nenhum gatilho registrado ainda'),
      );
    }

    final sortedTriggers = triggerCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gatilhos Mais Frequentes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2E2E),
            ),
          ),
          const SizedBox(height: 16),
          ...sortedTriggers.take(5).map((trigger) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(flex: 4, child: Text(trigger.key)),
                  Expanded(
                    flex: 3,
                    child: LinearProgressIndicator(
                      value: trigger.value / sortedTriggers.first.value,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFFF7043),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${trigger.value}x',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mood_bad, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          const Text(
            'Comece registrando suas emoções',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Color _getMoodColor(int mood) {
    if (mood <= 3) return const Color(0xFFE53935);
    if (mood <= 5) return const Color(0xFFFF9800);
    if (mood <= 7) return const Color(0xFF4CAF50);
    return const Color(0xFF2E7D32);
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime).inDays;

    if (difference == 0) {
      return 'Hoje, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference == 1) {
      return 'Ontem, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
