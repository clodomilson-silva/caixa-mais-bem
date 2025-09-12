class BreathingTechnique {
  final String id;
  final String name;
  final String description;
  final String instructions;
  final int durationMinutes;
  final List<String> benefits;
  final String category;
  final String difficulty; // 'Iniciante', 'Intermediário', 'Avançado'
  final List<BreathingStep> steps;
  final String? audioUrl; // Para futuras implementações com áudio
  final String? videoUrl; // Link externo para vídeo demonstrativo

  const BreathingTechnique({
    required this.id,
    required this.name,
    required this.description,
    required this.instructions,
    required this.durationMinutes,
    required this.benefits,
    required this.category,
    required this.difficulty,
    required this.steps,
    this.audioUrl,
    this.videoUrl,
  });
}

class BreathingStep {
  final String instruction;
  final int durationSeconds;
  final String type; // 'inspirar', 'segurar', 'expirar', 'pausa'

  const BreathingStep({
    required this.instruction,
    required this.durationSeconds,
    required this.type,
  });
}

enum BreathingCategory {
  relaxamento('Relaxamento'),
  energizante('Energizante'),
  focalizacao('Focalização'),
  antiEstresse('Anti-Estresse'),
  sono('Para Dormir'),
  ansiedade('Ansiedade');

  const BreathingCategory(this.displayName);
  final String displayName;
}

enum BreathingDifficulty {
  iniciante('Iniciante', 1),
  intermediario('Intermediário', 2),
  avancado('Avançado', 3);

  const BreathingDifficulty(this.displayName, this.level);
  final String displayName;
  final int level;
}
