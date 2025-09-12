class MoodEntry {
  final String id;
  final DateTime timestamp;
  final int moodLevel; // 1-10
  final List<String> emotions;
  final String? notes;
  final String? trigger;
  final WorkContext? workContext;
  final String entryType; // 'quick', 'detailed', 'check-in'

  const MoodEntry({
    required this.id,
    required this.timestamp,
    required this.moodLevel,
    required this.emotions,
    this.notes,
    this.trigger,
    this.workContext,
    this.entryType = 'quick',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'moodLevel': moodLevel,
      'emotions': emotions,
      'notes': notes,
      'trigger': trigger,
      'workContext': workContext?.toJson(),
      'entryType': entryType,
    };
  }

  factory MoodEntry.fromJson(Map<String, dynamic> json) {
    return MoodEntry(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      moodLevel: json['moodLevel'],
      emotions: List<String>.from(json['emotions']),
      notes: json['notes'],
      trigger: json['trigger'],
      workContext: json['workContext'] != null
          ? WorkContext.fromJson(json['workContext'])
          : null,
      entryType: json['entryType'] ?? 'quick',
    );
  }
}

class WorkContext {
  final String shift; // 'morning', 'afternoon', 'evening'
  final String customerVolume; // 'low', 'medium', 'high'
  final List<String> specialSituations;
  final String? workLocation;

  const WorkContext({
    required this.shift,
    required this.customerVolume,
    required this.specialSituations,
    this.workLocation,
  });

  Map<String, dynamic> toJson() {
    return {
      'shift': shift,
      'customerVolume': customerVolume,
      'specialSituations': specialSituations,
      'workLocation': workLocation,
    };
  }

  factory WorkContext.fromJson(Map<String, dynamic> json) {
    return WorkContext(
      shift: json['shift'],
      customerVolume: json['customerVolume'],
      specialSituations: List<String>.from(json['specialSituations']),
      workLocation: json['workLocation'],
    );
  }
}

class WeeklyReflection {
  final String id;
  final DateTime weekStartDate;
  final Map<String, String> reflectionAnswers;
  final List<String> insights;
  final List<String> goals;

  const WeeklyReflection({
    required this.id,
    required this.weekStartDate,
    required this.reflectionAnswers,
    required this.insights,
    required this.goals,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weekStartDate': weekStartDate.toIso8601String(),
      'reflectionAnswers': reflectionAnswers,
      'insights': insights,
      'goals': goals,
    };
  }

  factory WeeklyReflection.fromJson(Map<String, dynamic> json) {
    return WeeklyReflection(
      id: json['id'],
      weekStartDate: DateTime.parse(json['weekStartDate']),
      reflectionAnswers: Map<String, String>.from(json['reflectionAnswers']),
      insights: List<String>.from(json['insights']),
      goals: List<String>.from(json['goals']),
    );
  }
}

enum MoodEmotions {
  alegria('Alegria', '😊', 'positive'),
  calma('Calma', '😌', 'positive'),
  motivacao('Motivação', '💪', 'positive'),
  gratidao('Gratidão', '🙏', 'positive'),
  confianca('Confiança', '😎', 'positive'),
  ansiedade('Ansiedade', '😰', 'negative'),
  irritacao('Irritação', '😤', 'negative'),
  fadiga('Fadiga', '😴', 'negative'),
  estresse('Estresse', '😵', 'negative'),
  tristeza('Tristeza', '😢', 'negative'),
  frustracao('Frustração', '😠', 'negative'),
  preocupacao('Preocupação', '😟', 'negative'),
  neutralidade('Neutro', '😐', 'neutral'),
  confusao('Confusão', '🤔', 'neutral');

  const MoodEmotions(this.displayName, this.emoji, this.category);
  final String displayName;
  final String emoji;
  final String category;
}

enum WorkTriggers {
  clienteDificil(
    'Cliente Difícil',
    '😤',
    'Interação com clientes problemáticos',
  ),
  filaGrande('Fila Grande', '👥', 'Pressão por alta demanda'),
  pressaoTempo('Pressão de Tempo', '⏰', 'Necessidade de trabalhar rapidamente'),
  problemaTecnico(
    'Problema Técnico',
    '💻',
    'Falhas no sistema ou equipamentos',
  ),
  supervisao('Supervisão', '👔', 'Pressão da gerência ou supervisores'),
  colegaEstressado('Colega Estressado', '😓', 'Ambiente tenso com colegas'),
  metasAltas('Metas Altas', '🎯', 'Pressão para atingir objetivos'),
  clienteSatisfeito('Cliente Satisfeito', '😊', 'Reconhecimento positivo'),
  trabalhoEmEquipe('Trabalho em Equipe', '🤝', 'Boa colaboração'),
  pausaEfetiva('Pausa Efetiva', '☕', 'Descanso adequado'),
  reconhecimento('Reconhecimento', '🏆', 'Elogio ou feedback positivo');

  const WorkTriggers(this.displayName, this.emoji, this.description);
  final String displayName;
  final String emoji;
  final String description;
}

enum WorkShift {
  manha('Manhã', '🌅', 'morning'),
  tarde('Tarde', '☀️', 'afternoon'),
  noite('Noite', '🌙', 'evening');

  const WorkShift(this.displayName, this.emoji, this.value);
  final String displayName;
  final String emoji;
  final String value;
}

enum CustomerVolume {
  baixo('Baixo', '👤', 'low'),
  medio('Médio', '👥', 'medium'),
  alto('Alto', '👥👥', 'high');

  const CustomerVolume(this.displayName, this.emoji, this.value);
  final String displayName;
  final String emoji;
  final String value;
}
