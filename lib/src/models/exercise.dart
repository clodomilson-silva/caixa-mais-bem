/// Modelo para representar um exercício ou dica de atividade física
class Exercise {
  final String id;
  final String title;
  final String description;
  final String category;
  final String duration;
  final String difficulty;
  final List<String> instructions;
  final String? imageUrl;
  final String? externalVideoUrl;
  final String? externalArticleUrl;
  final List<String> benefits;
  final List<String> targetAreas;

  const Exercise({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.duration,
    required this.difficulty,
    required this.instructions,
    this.imageUrl,
    this.externalVideoUrl,
    this.externalArticleUrl,
    required this.benefits,
    required this.targetAreas,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      duration: json['duration'] as String,
      difficulty: json['difficulty'] as String,
      instructions: List<String>.from(json['instructions'] as List),
      imageUrl: json['imageUrl'] as String?,
      externalVideoUrl: json['externalVideoUrl'] as String?,
      externalArticleUrl: json['externalArticleUrl'] as String?,
      benefits: List<String>.from(json['benefits'] as List),
      targetAreas: List<String>.from(json['targetAreas'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'duration': duration,
      'difficulty': difficulty,
      'instructions': instructions,
      'imageUrl': imageUrl,
      'externalVideoUrl': externalVideoUrl,
      'externalArticleUrl': externalArticleUrl,
      'benefits': benefits,
      'targetAreas': targetAreas,
    };
  }
}

/// Categorias de exercícios disponíveis
enum ExerciseCategory {
  stretching('Alongamento'),
  strengthening('Fortalecimento'),
  posture('Postura'),
  relaxation('Relaxamento'),
  breathing('Respiração');

  const ExerciseCategory(this.displayName);
  final String displayName;
}

/// Níveis de dificuldade
enum DifficultyLevel {
  beginner('Iniciante'),
  intermediate('Intermediário'),
  advanced('Avançado');

  const DifficultyLevel(this.displayName);
  final String displayName;
}
