import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/exercise.dart';
import '../../../services/exercise_repository.dart';
import '../../../core/constants.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  String selectedCategory = 'Todos';
  List<Exercise> exercises = [];
  List<String> categories = ['Todos'];

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  void _loadExercises() {
    exercises = ExerciseRepository.getAllExercises();
    categories.addAll(ExerciseRepository.getAllCategories());
    setState(() {});
  }

  List<Exercise> get filteredExercises {
    if (selectedCategory == 'Todos') {
      return exercises;
    }
    return ExerciseRepository.getExercisesByCategory(selectedCategory);
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o link')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercícios e Dicas'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: Column(
        children: [
          // Filtro por categoria
          Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  final isSelected = category == selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      backgroundColor: AppColors.surfaceLight,
                      selectedColor: AppColors.serenity,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Lista de exercícios
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredExercises.length + 1, // +1 para links externos
              itemBuilder: (context, index) {
                if (index == filteredExercises.length) {
                  return _buildExternalLinksSection();
                }

                final exercise = filteredExercises[index];
                return _buildExerciseCard(exercise);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        exercise.description,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                _getCategoryIcon(exercise.category),
              ],
            ),
            const SizedBox(height: 12),

            // Informações básicas
            Row(
              children: [
                _buildInfoChip(exercise.duration, Icons.timer, Colors.green),
                const SizedBox(width: 8),
                _buildInfoChip(
                  exercise.difficulty,
                  Icons.trending_up,
                  Colors.orange,
                ),
                const SizedBox(width: 8),
                _buildInfoChip(exercise.category, Icons.category, Colors.blue),
              ],
            ),
            const SizedBox(height: 12),

            // Instruções
            const Text(
              'Como fazer:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ...exercise.instructions.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${entry.key + 1}. ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[700],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 12),

            // Benefícios
            if (exercise.benefits.isNotEmpty) ...[
              const Text(
                'Benefícios:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: exercise.benefits.map((benefit) {
                  return Chip(
                    label: Text(benefit, style: const TextStyle(fontSize: 12)),
                    backgroundColor: Colors.green[50],
                    side: BorderSide(color: Colors.green[200]!),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
            ],

            // Links externos
            if (exercise.externalVideoUrl != null ||
                exercise.externalArticleUrl != null) ...[
              const Divider(),
              const Text(
                'Links úteis:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (exercise.externalVideoUrl != null)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _launchUrl(exercise.externalVideoUrl!),
                        icon: const Icon(Icons.play_circle_outline),
                        label: const Text('Ver Vídeo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.complement.withOpacity(
                            0.1,
                          ),
                          foregroundColor: AppColors.complement,
                        ),
                      ),
                    ),
                  if (exercise.externalVideoUrl != null &&
                      exercise.externalArticleUrl != null)
                    const SizedBox(width: 8),
                  if (exercise.externalArticleUrl != null)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            _launchUrl(exercise.externalArticleUrl!),
                        icon: const Icon(Icons.article_outlined),
                        label: const Text('Ler Mais'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[50],
                          foregroundColor: Colors.blue[700],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildExternalLinksSection() {
    return Card(
      margin: const EdgeInsets.only(top: 16, bottom: 32),
      elevation: 3,
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.link, color: Colors.blue[700]),
                const SizedBox(width: 8),
                Text(
                  'Links Recomendados',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Conteúdos externos com mais exercícios e dicas:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            ...ExerciseRepository.getPopularExternalLinks().asMap().entries.map(
              (entry) {
                final titles = [
                  'Exercícios para Operadores de Caixa - YouTube',
                  'Fisioterapia para Todos - Exercícios no Trabalho',
                  'Ergonomia Brasil - Exercícios Laborais',
                  'Minha Vida - Exercícios para Escritório',
                  'UOL VivaBem - Alongamentos no Trabalho',
                ];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () => _launchUrl(entry.value),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.open_in_new,
                            color: Colors.blue[600],
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              titles[entry.key],
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCategoryIcon(String category) {
    IconData icon;
    Color color;

    switch (category) {
      case 'Alongamento':
        icon = Icons.accessibility_new;
        color = Colors.green;
        break;
      case 'Fortalecimento':
        icon = Icons.fitness_center;
        color = Colors.orange;
        break;
      case 'Postura':
        icon = Icons.straighten;
        color = Colors.blue;
        break;
      case 'Respiração':
        icon = Icons.air;
        color = Colors.purple;
        break;
      default:
        icon = Icons.sports;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}
