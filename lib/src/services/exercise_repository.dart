import '../models/exercise.dart';

/// Repositório com exercícios específicos para operadores de caixa
class ExerciseRepository {
  static List<Exercise> getAllExercises() {
    return [
      // ALONGAMENTOS PARA PESCOÇO E OMBROS
      Exercise(
        id: 'neck_stretch_1',
        title: 'Alongamento de Pescoço Lateral',
        description:
            'Alívio da tensão no pescoço causada por olhar para baixo constantemente',
        category: 'Alongamento',
        duration: '2 minutos',
        difficulty: 'Iniciante',
        instructions: [
          'Sente-se ou fique em pé com a coluna reta',
          'Incline a cabeça para o lado direito, aproximando a orelha do ombro',
          'Mantenha por 15-20 segundos',
          'Repita para o lado esquerdo',
          'Faça 3 repetições para cada lado',
        ],
        benefits: [
          'Reduz tensão no pescoço',
          'Melhora a flexibilidade cervical',
          'Alivia dores de cabeça tensionais',
        ],
        targetAreas: ['Pescoço', 'Músculos cervicais', 'Trapézio superior'],
        externalVideoUrl:
            'https://www.youtube.com/watch?v=neck-stretch-exercises',
      ),

      Exercise(
        id: 'shoulder_roll',
        title: 'Rotação de Ombros',
        description:
            'Exercício simples para liberar tensão nos ombros durante o trabalho',
        category: 'Alongamento',
        duration: '1 minuto',
        difficulty: 'Iniciante',
        instructions: [
          'Fique em pé com os braços ao lado do corpo',
          'Levante os ombros em direção às orelhas',
          'Role os ombros para trás fazendo círculos grandes',
          'Faça 10 rotações para trás',
          'Faça 10 rotações para frente',
        ],
        benefits: [
          'Alivia tensão nos ombros',
          'Melhora circulação sanguínea',
          'Reduz rigidez muscular',
        ],
        targetAreas: ['Ombros', 'Trapézio', 'Deltoides'],
        externalVideoUrl:
            'https://www.youtube.com/watch?v=shoulder-exercises-office',
      ),

      // EXERCÍCIOS PARA COLUNA E POSTURA
      Exercise(
        id: 'back_extension',
        title: 'Extensão de Coluna',
        description:
            'Contrabalança a postura curvada típica do trabalho no caixa',
        category: 'Postura',
        duration: '3 minutos',
        difficulty: 'Iniciante',
        instructions: [
          'Fique em pé com as mãos na cintura',
          'Arqueie suavemente as costas para trás',
          'Olhe ligeiramente para cima',
          'Mantenha por 5-10 segundos',
          'Retorne à posição inicial e repita 5 vezes',
        ],
        benefits: [
          'Corrige postura curvada',
          'Fortalece músculos das costas',
          'Reduz dor lombar',
        ],
        targetAreas: ['Coluna vertebral', 'Músculos eretores', 'Core'],
        externalVideoUrl:
            'https://www.youtube.com/watch?v=back-extension-exercises',
        externalArticleUrl:
            'https://www.fisioterapiaparatodos.com/exercicios-postura-trabalho',
      ),

      Exercise(
        id: 'cat_cow_standing',
        title: 'Gato-Vaca em Pé',
        description:
            'Mobilização da coluna para operadores que ficam muito tempo na mesma posição',
        category: 'Postura',
        duration: '2 minutos',
        difficulty: 'Iniciante',
        instructions: [
          'Fique em pé com os pés afastados na largura dos ombros',
          'Coloque as mãos nos joelhos ligeiramente dobrados',
          'Arqueie as costas como um gato (flexão)',
          'Em seguida, arqueie para baixo como uma vaca (extensão)',
          'Repita o movimento lentamente 10 vezes',
        ],
        benefits: [
          'Mobiliza toda a coluna',
          'Alivia rigidez vertebral',
          'Melhora flexibilidade',
        ],
        targetAreas: ['Coluna vertebral', 'Core', 'Músculos paravertebrais'],
        externalVideoUrl:
            'https://www.youtube.com/watch?v=cat-cow-standing-variation',
      ),

      // EXERCÍCIOS PARA PERNAS E PÉS
      Exercise(
        id: 'calf_raises',
        title: 'Elevação de Panturrilhas',
        description:
            'Fortalece as pernas e melhora circulação para quem fica muito tempo em pé',
        category: 'Fortalecimento',
        duration: '2 minutos',
        difficulty: 'Iniciante',
        instructions: [
          'Fique em pé com os pés paralelos',
          'Levante-se na ponta dos pés lentamente',
          'Mantenha por 2 segundos',
          'Desça lentamente até o chão',
          'Faça 15-20 repetições',
        ],
        benefits: [
          'Fortalece panturrilhas',
          'Melhora circulação venosa',
          'Reduz inchaço nos pés',
        ],
        targetAreas: ['Panturrilhas', 'Músculos gastrocnêmio', 'Sóleo'],
        externalVideoUrl:
            'https://www.youtube.com/watch?v=calf-raises-exercise',
      ),

      Exercise(
        id: 'ankle_circles',
        title: 'Círculos com o Tornozelo',
        description: 'Exercício discreto que pode ser feito durante o trabalho',
        category: 'Alongamento',
        duration: '1 minuto',
        difficulty: 'Iniciante',
        instructions: [
          'Sentado ou em pé, levante um pé ligeiramente',
          'Faça círculos com o tornozelo no sentido horário',
          'Faça 10 círculos e inverta o sentido',
          'Repita com o outro pé',
          'Pode ser feito discretamente durante o trabalho',
        ],
        benefits: [
          'Melhora circulação nos pés',
          'Reduz rigidez do tornozelo',
          'Previne inchaço',
        ],
        targetAreas: ['Tornozelos', 'Pés', 'Panturrilhas'],
        externalVideoUrl:
            'https://www.youtube.com/watch?v=ankle-mobility-exercises',
      ),

      // EXERCÍCIOS PARA PUNHOS E MÃOS
      Exercise(
        id: 'wrist_stretch',
        title: 'Alongamento de Punhos',
        description:
            'Essencial para quem usa muito teclado e manipula dinheiro',
        category: 'Alongamento',
        duration: '2 minutos',
        difficulty: 'Iniciante',
        instructions: [
          'Estenda o braço direito à frente',
          'Com a mão esquerda, puxe os dedos da mão direita para baixo',
          'Mantenha por 15 segundos',
          'Agora puxe os dedos para cima',
          'Mantenha por 15 segundos e troque de mão',
        ],
        benefits: [
          'Previne síndrome do túnel do carpo',
          'Alivia tensão nos punhos',
          'Melhora flexibilidade das mãos',
        ],
        targetAreas: ['Punhos', 'Antebraços', 'Dedos'],
        externalVideoUrl:
            'https://www.youtube.com/watch?v=wrist-stretches-office-workers',
        externalArticleUrl:
            'https://www.minhavida.com.br/saude/materias/exercicios-punho-ler',
      ),

      Exercise(
        id: 'finger_exercises',
        title: 'Exercícios para Dedos',
        description: 'Mantém flexibilidade e força nos dedos',
        category: 'Fortalecimento',
        duration: '2 minutos',
        difficulty: 'Iniciante',
        instructions: [
          'Abra e feche as mãos fazendo punhos',
          'Toque cada dedo no polegar sequencialmente',
          'Estique os dedos ao máximo e relaxe',
          'Faça movimentos de "piano" no ar',
          'Repita cada movimento 10 vezes',
        ],
        benefits: [
          'Mantém destreza manual',
          'Previne rigidez articular',
          'Fortalece músculos intrínsecos',
        ],
        targetAreas: ['Dedos', 'Mãos', 'Articulações interfalangianas'],
        externalVideoUrl:
            'https://www.youtube.com/watch?v=finger-exercises-dexterity',
      ),

      // EXERCÍCIOS DE RESPIRAÇÃO E RELAXAMENTO
      Exercise(
        id: 'deep_breathing',
        title: 'Respiração Profunda',
        description: 'Técnica para reduzir estresse durante o atendimento',
        category: 'Respiração',
        duration: '3 minutos',
        difficulty: 'Iniciante',
        instructions: [
          'Sente-se confortavelmente ou fique em pé',
          'Inspire lentamente pelo nariz por 4 segundos',
          'Segure a respiração por 4 segundos',
          'Expire lentamente pela boca por 6 segundos',
          'Repita por 5-10 ciclos',
        ],
        benefits: [
          'Reduz ansiedade e estresse',
          'Melhora oxigenação',
          'Promove relaxamento',
        ],
        targetAreas: ['Sistema respiratório', 'Sistema nervoso', 'Mente'],
        externalVideoUrl:
            'https://www.youtube.com/watch?v=breathing-exercises-stress-relief',
        externalArticleUrl:
            'https://www.psicologiasdobrasil.com.br/respiracao-consciente-estresse',
      ),

      // EXERCÍCIO COMPLETO
      Exercise(
        id: 'micro_break_routine',
        title: 'Rotina de Micro-Pausa',
        description:
            'Sequência completa de 5 minutos para fazer a cada 2 horas',
        category: 'Postura',
        duration: '5 minutos',
        difficulty: 'Iniciante',
        instructions: [
          '1 min: Rotação de ombros e pescoço',
          '1 min: Extensão de coluna e alongamento lateral',
          '1 min: Elevação de panturrilhas e círculos de tornozelo',
          '1 min: Alongamento de punhos e exercícios de dedos',
          '1 min: Respiração profunda e relaxamento',
        ],
        benefits: [
          'Rotina completa de alívio',
          'Previne múltiplas lesões',
          'Melhora bem-estar geral',
        ],
        targetAreas: ['Corpo inteiro', 'Postura', 'Circulação'],
        externalVideoUrl:
            'https://www.youtube.com/watch?v=office-worker-exercise-routine',
        externalArticleUrl:
            'https://www.ergonomia.com.br/pausas-ativas-trabalho',
      ),
    ];
  }

  static List<Exercise> getExercisesByCategory(String category) {
    return getAllExercises()
        .where((exercise) => exercise.category == category)
        .toList();
  }

  static List<Exercise> getQuickExercises() {
    return getAllExercises()
        .where(
          (exercise) =>
              exercise.duration.contains('1 minuto') ||
              exercise.duration.contains('2 minutos'),
        )
        .toList();
  }

  static List<String> getAllCategories() {
    return getAllExercises().map((e) => e.category).toSet().toList();
  }

  static List<String> getPopularExternalLinks() {
    return [
      'https://www.youtube.com/results?search_query=exercicios+operador+caixa',
      'https://www.fisioterapiaparatodos.com/exercicios-trabalho',
      'https://www.ergonomia.com.br/exercicios-laborais',
      'https://www.minhavida.com.br/fitness/galerias/exercicios-escritorio',
      'https://www.uol.com.br/vivabem/noticias/redacao/alongamentos-trabalho.htm',
    ];
  }
}
