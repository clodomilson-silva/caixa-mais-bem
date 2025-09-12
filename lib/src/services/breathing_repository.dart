import '../models/breathing_technique.dart';

class BreathingRepository {
  static List<BreathingTechnique> getAllTechniques() {
    return [
      _respiracao4_7_8(),
      _respiracaoQuadrada(),
      _respiracaoAbdominal(),
      _respiracaoRapidaEnergia(),
      _respiracaoProgressiva(),
      _respiracaoAntiEstresse(),
      _respiracaoFocalizacao(),
      _respiracaoSono(),
      _respiracaoMicroPausa(),
    ];
  }

  static List<BreathingTechnique> getTechniquesByCategory(String category) {
    return getAllTechniques()
        .where((technique) => technique.category == category)
        .toList();
  }

  static List<BreathingTechnique> getTechniquesByDifficulty(String difficulty) {
    return getAllTechniques()
        .where((technique) => technique.difficulty == difficulty)
        .toList();
  }

  static List<BreathingTechnique> getQuickTechniques() {
    return getAllTechniques()
        .where((technique) => technique.durationMinutes <= 5)
        .toList();
  }

  // Técnica 4-7-8 - Excelente para relaxamento
  static BreathingTechnique _respiracao4_7_8() {
    return const BreathingTechnique(
      id: '1',
      name: 'Respiração 4-7-8',
      description:
          'Técnica poderosa para relaxamento rápido e redução do estresse. Ideal para fazer durante pausas no trabalho.',
      instructions:
          'Uma das técnicas mais eficazes para acalmar o sistema nervoso rapidamente.',
      durationMinutes: 3,
      benefits: [
        'Reduz ansiedade instantaneamente',
        'Diminui pressão arterial',
        'Melhora qualidade do sono',
        'Acalma mente agitada',
        'Alivia tensão muscular',
      ],
      category: 'Anti-Estresse',
      difficulty: 'Iniciante',
      videoUrl: 'https://www.youtube.com/watch?v=YRPh_GaiL8s',
      steps: [
        BreathingStep(
          instruction: 'Inspire pelo nariz contando até 4',
          durationSeconds: 4,
          type: 'inspirar',
        ),
        BreathingStep(
          instruction: 'Segure a respiração contando até 7',
          durationSeconds: 7,
          type: 'segurar',
        ),
        BreathingStep(
          instruction: 'Expire pela boca contando até 8',
          durationSeconds: 8,
          type: 'expirar',
        ),
        BreathingStep(
          instruction: 'Pause brevemente antes do próximo ciclo',
          durationSeconds: 2,
          type: 'pausa',
        ),
      ],
    );
  }

  // Respiração Quadrada - Para focalização
  static BreathingTechnique _respiracaoQuadrada() {
    return const BreathingTechnique(
      id: '2',
      name: 'Respiração Quadrada (Box Breathing)',
      description:
          'Técnica usada por militares e atletas para melhorar foco e concentração. Perfeita para momentos de alta demanda no trabalho.',
      instructions:
          'Imagine desenhar um quadrado com sua respiração, mantendo tempos iguais.',
      durationMinutes: 5,
      benefits: [
        'Melhora concentração',
        'Reduz estresse mental',
        'Estabiliza ritmo cardíaco',
        'Aumenta clareza mental',
        'Controla ansiedade',
      ],
      category: 'Focalização',
      difficulty: 'Intermediário',
      videoUrl: 'https://www.youtube.com/watch?v=tEmt1Znux58',
      steps: [
        BreathingStep(
          instruction: 'Inspire contando até 4',
          durationSeconds: 4,
          type: 'inspirar',
        ),
        BreathingStep(
          instruction: 'Segure o ar contando até 4',
          durationSeconds: 4,
          type: 'segurar',
        ),
        BreathingStep(
          instruction: 'Expire contando até 4',
          durationSeconds: 4,
          type: 'expirar',
        ),
        BreathingStep(
          instruction: 'Mantenha pulmões vazios contando até 4',
          durationSeconds: 4,
          type: 'pausa',
        ),
      ],
    );
  }

  // Respiração Abdominal - Base fundamental
  static BreathingTechnique _respiracaoAbdominal() {
    return const BreathingTechnique(
      id: '3',
      name: 'Respiração Abdominal Profunda',
      description:
          'Respiração natural e profunda usando o diafragma. Fundamental para operadores que ficam muitas horas sentados.',
      instructions:
          'Coloque uma mão no peito e outra na barriga. A mão da barriga deve se mover mais.',
      durationMinutes: 7,
      benefits: [
        'Melhora oxigenação',
        'Relaxa músculos tensos',
        'Reduz dores nas costas',
        'Aumenta energia',
        'Melhora postura',
      ],
      category: 'Relaxamento',
      difficulty: 'Iniciante',
      videoUrl: 'https://www.youtube.com/watch?v=DbDoBzGY3vo',
      steps: [
        BreathingStep(
          instruction: 'Inspire lentamente pelo nariz, expandindo a barriga',
          durationSeconds: 6,
          type: 'inspirar',
        ),
        BreathingStep(
          instruction: 'Pause levemente no topo da inspiração',
          durationSeconds: 2,
          type: 'segurar',
        ),
        BreathingStep(
          instruction: 'Expire devagar pela boca, contraindo a barriga',
          durationSeconds: 8,
          type: 'expirar',
        ),
        BreathingStep(
          instruction: 'Pause naturalmente antes da próxima inspiração',
          durationSeconds: 2,
          type: 'pausa',
        ),
      ],
    );
  }

  // Respiração Energizante
  static BreathingTechnique _respiracaoRapidaEnergia() {
    return const BreathingTechnique(
      id: '4',
      name: 'Respiração Energizante',
      description:
          'Técnica revigorante para combater sonolência e fadiga durante o expediente. Ideal para o período pós-almoço.',
      instructions:
          'Respiração mais rápida e energética para ativar o sistema nervoso.',
      durationMinutes: 2,
      benefits: [
        'Aumenta energia rapidamente',
        'Combate sonolência',
        'Melhora alerta mental',
        'Ativa circulação',
        'Reduz fadiga',
      ],
      category: 'Energizante',
      difficulty: 'Intermediário',
      videoUrl: 'https://www.youtube.com/watch?v=pBkOBCNLnZk',
      steps: [
        BreathingStep(
          instruction: 'Inspire vigorosamente pelo nariz',
          durationSeconds: 2,
          type: 'inspirar',
        ),
        BreathingStep(
          instruction: 'Expire com força pela boca',
          durationSeconds: 2,
          type: 'expirar',
        ),
        BreathingStep(
          instruction: 'Continue o ritmo acelerado',
          durationSeconds: 1,
          type: 'pausa',
        ),
      ],
    );
  }

  // Respiração Progressiva
  static BreathingTechnique _respiracaoProgressiva() {
    return const BreathingTechnique(
      id: '5',
      name: 'Respiração Progressiva',
      description:
          'Técnica que combina respiração com relaxamento muscular progressivo. Ideal para final de expediente.',
      instructions:
          'Coordene a respiração com tensão e relaxamento dos músculos.',
      durationMinutes: 10,
      benefits: [
        'Relaxamento profundo',
        'Alivia tensões musculares',
        'Reduz dores corporais',
        'Melhora qualidade do sono',
        'Diminui estresse acumulado',
      ],
      category: 'Relaxamento',
      difficulty: 'Avançado',
      videoUrl: 'https://www.youtube.com/watch?v=86HUcX8ZtAk',
      steps: [
        BreathingStep(
          instruction: 'Inspire tensionando os músculos dos pés',
          durationSeconds: 5,
          type: 'inspirar',
        ),
        BreathingStep(
          instruction: 'Segure tensionando por alguns segundos',
          durationSeconds: 3,
          type: 'segurar',
        ),
        BreathingStep(
          instruction: 'Expire relaxando completamente os músculos',
          durationSeconds: 7,
          type: 'expirar',
        ),
        BreathingStep(
          instruction: 'Pause sentindo o relaxamento',
          durationSeconds: 3,
          type: 'pausa',
        ),
      ],
    );
  }

  // Anti-Estresse Express
  static BreathingTechnique _respiracaoAntiEstresse() {
    return const BreathingTechnique(
      id: '6',
      name: 'Anti-Estresse Express',
      description:
          'Técnica rápida para momentos de alto estresse, como filas grandes ou situações difíceis com clientes.',
      instructions:
          'Respiração de emergência para controlar estresse agudo rapidamente.',
      durationMinutes: 2,
      benefits: [
        'Controle imediato do estresse',
        'Reduz tensão instantânea',
        'Melhora autocontrole',
        'Clareia pensamentos',
        'Previne irritabilidade',
      ],
      category: 'Anti-Estresse',
      difficulty: 'Iniciante',
      videoUrl: 'https://www.youtube.com/watch?v=Ixjn0zFoYFQ',
      steps: [
        BreathingStep(
          instruction: 'Inspire profundo pelo nariz em 3 segundos',
          durationSeconds: 3,
          type: 'inspirar',
        ),
        BreathingStep(
          instruction: 'Segure focando em acalmar',
          durationSeconds: 3,
          type: 'segurar',
        ),
        BreathingStep(
          instruction: 'Expire lentamente liberando tensão',
          durationSeconds: 6,
          type: 'expirar',
        ),
        BreathingStep(
          instruction: 'Repita mentalizando calma',
          durationSeconds: 1,
          type: 'pausa',
        ),
      ],
    );
  }

  // Respiração para Foco
  static BreathingTechnique _respiracaoFocalizacao() {
    return const BreathingTechnique(
      id: '7',
      name: 'Respiração para Foco Mental',
      description:
          'Técnica para melhorar concentração e precisão no atendimento e manuseio do dinheiro.',
      instructions:
          'Respiração consciente com contagem para aprimorar foco e atenção.',
      durationMinutes: 4,
      benefits: [
        'Melhora concentração',
        'Aumenta precisão',
        'Reduz erros',
        'Clareza mental',
        'Atenção sustentada',
      ],
      category: 'Focalização',
      difficulty: 'Intermediário',
      videoUrl: 'https://www.youtube.com/watch?v=wfDTp2GogaQ',
      steps: [
        BreathingStep(
          instruction: 'Inspire contando mentalmente até 5',
          durationSeconds: 5,
          type: 'inspirar',
        ),
        BreathingStep(
          instruction: 'Segure focando no número 5',
          durationSeconds: 5,
          type: 'segurar',
        ),
        BreathingStep(
          instruction: 'Expire contando regressivamente 5-4-3-2-1',
          durationSeconds: 5,
          type: 'expirar',
        ),
        BreathingStep(
          instruction: 'Pause mantendo mente clara',
          durationSeconds: 2,
          type: 'pausa',
        ),
      ],
    );
  }

  // Respiração para Dormir
  static BreathingTechnique _respiracaoSono() {
    return const BreathingTechnique(
      id: '8',
      name: 'Respiração para Melhor Sono',
      description:
          'Técnica para desacelerar após um dia intenso de trabalho e preparar o corpo para o descanso.',
      instructions:
          'Respiração lenta e profunda para ativar o sistema nervoso parassimpático.',
      durationMinutes: 8,
      benefits: [
        'Melhora qualidade do sono',
        'Reduz pensamentos acelerados',
        'Relaxa corpo e mente',
        'Diminui ansiedade noturna',
        'Facilita adormecer',
      ],
      category: 'Para Dormir',
      difficulty: 'Iniciante',
      videoUrl: 'https://www.youtube.com/watch?v=2RJ0Sq5wLMo',
      steps: [
        BreathingStep(
          instruction: 'Inspire muito lentamente pelo nariz',
          durationSeconds: 8,
          type: 'inspirar',
        ),
        BreathingStep(
          instruction: 'Segure suavemente a respiração',
          durationSeconds: 4,
          type: 'segurar',
        ),
        BreathingStep(
          instruction: 'Expire muito devagar pela boca',
          durationSeconds: 12,
          type: 'expirar',
        ),
        BreathingStep(
          instruction: 'Pause naturalmente sentindo relaxamento',
          durationSeconds: 4,
          type: 'pausa',
        ),
      ],
    );
  }

  // Micro-Pausa Respiratória
  static BreathingTechnique _respiracaoMicroPausa() {
    return const BreathingTechnique(
      id: '9',
      name: 'Micro-Pausa Respiratória',
      description:
          'Respiração ultra-rápida para fazer entre clientes ou durante momentos livres. Restaura energia rapidamente.',
      instructions:
          'Técnica discreta que pode ser feita sentado no caixa sem ninguém perceber.',
      durationMinutes: 1,
      benefits: [
        'Renovação rápida',
        'Pode ser feita discretamente',
        'Restaura energia',
        'Melhora postura',
        'Refresca mente',
      ],
      category: 'Energizante',
      difficulty: 'Iniciante',
      videoUrl: 'https://www.youtube.com/watch?v=u7QTKkIl69c',
      steps: [
        BreathingStep(
          instruction: 'Inspire profundo expandindo o peito',
          durationSeconds: 3,
          type: 'inspirar',
        ),
        BreathingStep(
          instruction: 'Expire completamente relaxando ombros',
          durationSeconds: 4,
          type: 'expirar',
        ),
        BreathingStep(
          instruction: 'Repita mais 2-3 vezes rapidamente',
          durationSeconds: 1,
          type: 'pausa',
        ),
      ],
    );
  }
}
