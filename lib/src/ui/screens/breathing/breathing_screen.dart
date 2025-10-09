import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/breathing_technique.dart';
import '../../../services/breathing_repository.dart';
import '../../../core/constants.dart';
import 'breathing_session_screen.dart';

class BreathingScreen extends StatefulWidget {
  final bool showAppBar;

  const BreathingScreen({super.key, this.showAppBar = true});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  List<BreathingTechnique> _techniques = [];
  List<BreathingTechnique> _filteredTechniques = [];
  String _selectedCategory = 'Todos';
  String _selectedDifficulty = 'Todos';

  final List<String> _categories = [
    'Todos',
    'Anti-Estresse',
    'Relaxamento',
    'Focalização',
    'Energizante',
    'Para Dormir',
  ];

  final List<String> _difficulties = [
    'Todos',
    'Iniciante',
    'Intermediário',
    'Avançado',
  ];

  @override
  void initState() {
    super.initState();
    _loadTechniques();
  }

  void _loadTechniques() {
    _techniques = BreathingRepository.getAllTechniques();
    _applyFilters();
  }

  void _applyFilters() {
    _filteredTechniques = _techniques.where((technique) {
      final categoryMatch =
          _selectedCategory == 'Todos' ||
          technique.category == _selectedCategory;
      final difficultyMatch =
          _selectedDifficulty == 'Todos' ||
          technique.difficulty == _selectedDifficulty;
      return categoryMatch && difficultyMatch;
    }).toList();
    setState(() {});
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Não foi possível abrir o link'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _startBreathingSession(BreathingTechnique technique) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BreathingSessionScreen(technique: technique),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: widget.showAppBar
          ? AppBar(
              title: const Text(
                'Respiração & Relaxamento',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppColors.primary,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
            )
          : null,
      body: Column(
        children: [
          // Header com gradiente
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.primary, AppColors.serenity],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Icon(Icons.air, size: 48, color: Colors.white),
                  const SizedBox(height: 12),
                  const Text(
                    'Técnicas de Respiração',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Reduza o estresse e melhore seu bem-estar',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Filtros
          Container(
            color: AppColors.surfaceLight,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filtrar por:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 12),

                // Filtro por categoria
                Wrap(
                  spacing: 8,
                  children: _categories.map((category) {
                    final isSelected = _selectedCategory == category;
                    return FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                          _applyFilters();
                        });
                      },
                      backgroundColor: AppColors.surfaceLight,
                      selectedColor: AppColors.serenity,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[700],
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 8),

                // Filtro por dificuldade
                Wrap(
                  spacing: 8,
                  children: _difficulties.map((difficulty) {
                    final isSelected = _selectedDifficulty == difficulty;
                    return FilterChip(
                      label: Text(difficulty),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedDifficulty = difficulty;
                          _applyFilters();
                        });
                      },
                      backgroundColor: AppColors.surfaceLight,
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[700],
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Lista de técnicas
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredTechniques.length,
              itemBuilder: (context, index) {
                final technique = _filteredTechniques[index];
                return _buildTechniqueCard(technique);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechniqueCard(BreathingTechnique technique) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header do card
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(technique.category),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getCategoryIcon(technique.category),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        technique.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${technique.durationMinutes} min',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor(technique.difficulty),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              technique.difficulty,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Descrição
            Text(
              technique.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),

            const SizedBox(height: 12),

            // Benefícios
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: technique.benefits.take(3).map((benefit) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.serenity.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.serenity.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    benefit,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Botões de ação
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _startBreathingSession(technique),
                    icon: const Icon(Icons.play_arrow, size: 18),
                    label: const Text('Iniciar Sessão'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                if (technique.videoUrl != null) ...[
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () => _launchURL(technique.videoUrl!),
                    icon: const Icon(Icons.video_library, size: 18),
                    label: const Text('Vídeo'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.complement,
                      side: BorderSide(color: AppColors.complement),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Anti-Estresse':
        return AppColors.complement;
      case 'Relaxamento':
        return AppColors.serenity;
      case 'Focalização':
        return AppColors.primary;
      case 'Energizante':
        return AppColors.energy;
      case 'Para Dormir':
        return AppColors.mindfulness;
      default:
        return AppColors.primary;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Anti-Estresse':
        return Icons.healing;
      case 'Relaxamento':
        return Icons.spa;
      case 'Focalização':
        return Icons.center_focus_strong;
      case 'Energizante':
        return Icons.bolt;
      case 'Para Dormir':
        return Icons.bedtime;
      default:
        return Icons.air;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Iniciante':
        return AppColors.success;
      case 'Intermediário':
        return AppColors.warning;
      case 'Avançado':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }
}
