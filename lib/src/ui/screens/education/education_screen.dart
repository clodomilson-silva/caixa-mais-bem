import 'package:flutter/material.dart';

class EducationScreen extends StatelessWidget {
  final String? moodType;
  final String? moodLabel;

  const EducationScreen({super.key, this.moodType, this.moodLabel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          moodType != null
              ? 'Dicas para quando estiver $moodLabel'
              : 'Conteúdo Educativo',
        ),
        centerTitle: true,
      ),
      body: moodType != null
          ? _buildMoodSpecificContent()
          : _buildGeneralContent(),
    );
  }

  Widget _buildMoodSpecificContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header personalizado para o humor
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(_getMoodIcon(), size: 48, color: _getMoodColor()),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Você está se sentindo $moodLabel',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getMoodDescription(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Dicas específicas
          const Text(
            'Dicas Personalizadas',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          ..._getMoodTips().map((tip) => _buildTipCard(tip)),
        ],
      ),
    );
  }

  Widget _buildGeneralContent() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school, size: 80, color: Colors.purple),
          SizedBox(height: 16),
          Text(
            'Conteúdo Educativo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Selecione como você está se sentindo\nna tela inicial para receber dicas personalizadas!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tip) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(tip['icon'], color: _getMoodColor(), size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tip['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              tip['description'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getMoodIcon() {
    switch (moodType) {
      case 'happy':
        return Icons.sentiment_very_satisfied;
      case 'sad':
        return Icons.sentiment_dissatisfied;
      case 'neutral':
        return Icons.sentiment_neutral;
      case 'calm':
        return Icons.sentiment_satisfied;
      case 'stressed':
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }

  Color _getMoodColor() {
    switch (moodType) {
      case 'happy':
        return Colors.green;
      case 'sad':
        return Colors.blue;
      case 'neutral':
        return Colors.grey;
      case 'calm':
        return Colors.purple;
      case 'stressed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getMoodDescription() {
    switch (moodType) {
      case 'happy':
        return 'Que bom! Vamos manter essa energia positiva.';
      case 'sad':
        return 'Tudo bem sentir-se assim. Vamos cuidar de você.';
      case 'neutral':
        return 'Um dia equilibrado. Que tal algumas dicas?';
      case 'calm':
        return 'Ótimo estado mental! Vamos cultivar essa paz.';
      case 'stressed':
        return 'Respire fundo. Temos dicas para te ajudar.';
      default:
        return 'Como podemos te ajudar hoje?';
    }
  }

  List<Map<String, dynamic>> _getMoodTips() {
    switch (moodType) {
      case 'happy':
        return [
          {
            'icon': Icons.favorite,
            'title': 'Compartilhe sua alegria',
            'description':
                'Que tal ligar para um amigo ou familiar e compartilhar algo bom que aconteceu hoje? A alegria compartilhada se multiplica.',
          },
          {
            'icon': Icons.music_note,
            'title': 'Dance um pouco',
            'description':
                'Coloque uma música que você gosta e dance por alguns minutos. O movimento amplifica sentimentos positivos.',
          },
          {
            'icon': Icons.park,
            'title': 'Aproveite a natureza',
            'description':
                'Se possível, saia para uma caminhada ou apenas observe pela janela. A natureza potencializa nossa felicidade.',
          },
        ];
      case 'sad':
        return [
          {
            'icon': Icons.self_improvement,
            'title': 'Pratique respiração profunda',
            'description':
                'Inspire por 4 segundos, segure por 4, expire por 6. Repita 5 vezes. Isso ajuda a acalmar o sistema nervoso.',
          },
          {
            'icon': Icons.book,
            'title': 'Escreva seus sentimentos',
            'description':
                'Anote o que está sentindo. Às vezes, colocar no papel ajuda a processar e clarear os pensamentos.',
          },
          {
            'icon': Icons.phone,
            'title': 'Conecte-se com alguém',
            'description':
                'Converse com um amigo de confiança ou familiar. Não precisa resolver tudo, apenas compartilhar já ajuda.',
          },
        ];
      case 'neutral':
        return [
          {
            'icon': Icons.lightbulb,
            'title': 'Experimente algo novo',
            'description':
                'Que tal aprender uma palavra nova, escutar uma música diferente ou experimentar um chá novo? Pequenas novidades animam o dia.',
          },
          {
            'icon': Icons.fitness_center,
            'title': 'Movimente-se',
            'description':
                'Faça alguns alongamentos, suba e desça escadas ou dance. O movimento físico melhora o humor naturalmente.',
          },
          {
            'icon': Icons.psychology,
            'title': 'Pratique gratidão',
            'description':
                'Pense em 3 coisas pelas quais você é grato hoje, por menores que sejam. Isso treina o cérebro para o positivo.',
          },
        ];
      case 'calm':
        return [
          {
            'icon': Icons.spa,
            'title': 'Mantenha a serenidade',
            'description':
                'Continue respirando profundamente e mantenha essa sensação de paz. Você está em um ótimo estado mental.',
          },
          {
            'icon': Icons.nature,
            'title': 'Conecte-se com o momento',
            'description':
                'Pratique mindfulness: observe 5 coisas que você vê, 4 que escuta, 3 que sente, 2 que cheira e 1 que prova.',
          },
          {
            'icon': Icons.menu_book,
            'title': 'Leia algo inspirador',
            'description':
                'Um poema, uma citação ou algumas páginas de um livro que você gosta. Alimente sua mente com conteúdo positivo.',
          },
        ];
      case 'stressed':
        return [
          {
            'icon': Icons.air,
            'title': 'Técnica de respiração 4-7-8',
            'description':
                'Inspire por 4 segundos, segure por 7, expire por 8. Repita 4 vezes. Essa técnica ativa o sistema nervoso parassimpático.',
          },
          {
            'icon': Icons.pause_circle,
            'title': 'Faça uma pausa',
            'description':
                'Pare tudo por 5 minutos. Sente-se, feche os olhos e apenas respire. Não pense em tarefas, só respire.',
          },
          {
            'icon': Icons.water_drop,
            'title': 'Hidrate-se',
            'description':
                'Beba um copo de água gelada devagar. A desidratação pode piorar o estresse. Cuide do básico primeiro.',
          },
          {
            'icon': Icons.schedule,
            'title': 'Organize prioridades',
            'description':
                'Escreva 3 tarefas mais importantes do dia. Foque apenas nelas. O resto pode esperar.',
          },
        ];
      default:
        return [];
    }
  }
}
