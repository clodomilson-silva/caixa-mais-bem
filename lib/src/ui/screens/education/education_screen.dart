import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationScreen extends StatelessWidget {
  final String? moodType;
  final String? moodLabel;
  final bool showAppBar;

  const EducationScreen({
    super.key, 
    this.moodType, 
    this.moodLabel,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar(
        title: Text(
          moodType != null
              ? 'Dicas para quando estiver $moodLabel'
              : 'Vídeos Educativos',
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF26A69A), // Teal principal
        foregroundColor: Colors.white,
      ) : null,
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
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            color: Colors.grey[50],
            child: TabBar(
              tabs: const [
                Tab(icon: Icon(Icons.favorite), text: 'Bem-Estar'),
                Tab(icon: Icon(Icons.fitness_center), text: 'Exercícios'),
                Tab(icon: Icon(Icons.restaurant), text: 'Alimentação'),
                Tab(icon: Icon(Icons.psychology), text: 'Mental'),
              ],
              labelColor: Color(0xFF26A69A), // Teal principal
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: Color(0xFF26A69A), // Teal principal
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildWellBeingVideos(),
                _buildExerciseVideos(),
                _buildNutritionVideos(),
                _buildMentalHealthVideos(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Métodos para construir as seções de vídeos educativos com thumbnails reais
  Widget _buildWellBeingVideos() {
    final videos = [
      {
        'title': 'Bem-Estar e Qualidade de Vida',
        'description':
            'Dicas fundamentais para melhorar seu bem-estar e viver com mais qualidade de vida',
        'duration': '10:30',
        'category': 'Bem-Estar',
        'url': 'https://www.youtube.com/watch?v=a3-OvmUY-Hc',
        'thumbnail': 'https://img.youtube.com/vi/a3-OvmUY-Hc/hqdefault.jpg',
      },
      {
        'title': 'Saúde Mental - Cuidados Essenciais',
        'description':
            'Como cuidar da sua saúde mental e manter o equilíbrio emocional no dia a dia',
        'duration': '12:15',
        'category': 'Bem-Estar',
        'url': 'https://www.youtube.com/watch?v=UwyE_XIQ7DA',
        'thumbnail': 'https://img.youtube.com/vi/UwyE_XIQ7DA/hqdefault.jpg',
      },
      {
        'title': 'Pessoa Saudável - Hábitos de Vida',
        'description':
            'Práticas essenciais para manter-se saudável física e mentalmente',
        'duration': '8:45',
        'category': 'Bem-Estar',
        'url': 'https://www.youtube.com/watch?v=9q7WaQqtWK4',
        'thumbnail': 'https://img.youtube.com/vi/9q7WaQqtWK4/hqdefault.jpg',
      },
    ];

    return _buildVideoList(
      videos,
      Icons.favorite,
      Color(0xFF80CBC4),
    ); // Verde-água suave
  }

  Widget _buildExerciseVideos() {
    final videos = [
      {
        'title': 'Exercícios Práticos e Eficazes',
        'description':
            'Sequência de exercícios simples para fazer em casa ou no trabalho e manter-se ativo',
        'duration': '9:20',
        'category': 'Exercícios',
        'url': 'https://www.youtube.com/watch?v=QkMJSaZH4QA',
        'thumbnail': 'https://img.youtube.com/vi/QkMJSaZH4QA/hqdefault.jpg',
      },
      {
        'title': 'Atividade Física no Dia a Dia',
        'description':
            'Como incorporar movimento e exercícios na sua rotina diária de forma prática',
        'duration': '11:35',
        'category': 'Exercícios',
        'url': 'https://www.youtube.com/watch?v=csvMY_TOBOs',
        'thumbnail': 'https://img.youtube.com/vi/csvMY_TOBOs/hqdefault.jpg',
      },
      {
        'title': 'Alongamento e Mobilidade',
        'description':
            'Exercícios de alongamento para melhorar flexibilidade e aliviar tensões corporais',
        'duration': '7:45',
        'category': 'Exercícios',
        'url': 'https://www.youtube.com/watch?v=SgzczMDvMJk',
        'thumbnail': 'https://img.youtube.com/vi/SgzczMDvMJk/hqdefault.jpg',
      },
    ];

    return _buildVideoList(
      videos,
      Icons.fitness_center,
      Color(0xFF66BB6A),
    ); // Verde natural
  }

  Widget _buildNutritionVideos() {
    final videos = [
      {
        'title': 'Nutrição e Alimentação Saudável',
        'description':
            'Guia completo sobre nutrição balanceada e como fazer escolhas alimentares inteligentes',
        'duration': '13:22',
        'category': 'Alimentação',
        'url': 'https://www.youtube.com/watch?v=wk3kF0ToAbk',
        'thumbnail': 'https://img.youtube.com/vi/wk3kF0ToAbk/hqdefault.jpg',
      },
      {
        'title': 'Dicas de Alimentação Equilibrada',
        'description':
            'Como manter uma dieta equilibrada e nutritiva mesmo com a rotina corrida',
        'duration': '8:55',
        'category': 'Alimentação',
        'url': 'https://www.youtube.com/watch?v=X71YbXctXeM',
        'thumbnail': 'https://img.youtube.com/vi/X71YbXctXeM/hqdefault.jpg',
      },
      {
        'title': 'Hábitos Alimentares Saudáveis',
        'description':
            'Estabeleça hábitos alimentares que promovem saúde, energia e bem-estar',
        'duration': '10:18',
        'category': 'Alimentação',
        'url': 'https://www.youtube.com/watch?v=cOCimtPfP5Q',
        'thumbnail': 'https://img.youtube.com/vi/cOCimtPfP5Q/hqdefault.jpg',
      },
    ];

    return _buildVideoList(
      videos,
      Icons.restaurant,
      Color(0xFFFFB74D),
    ); // Laranja suave
  }

  Widget _buildMentalHealthVideos() {
    final videos = [
      {
        'title': 'Saúde Mental e Bem-Estar',
        'description':
            'Estratégias fundamentais para cuidar da saúde mental e manter equilíbrio emocional',
        'duration': '14:30',
        'category': 'Saúde Mental',
        'url': 'https://www.youtube.com/watch?v=CrwRwgNJIMU',
        'thumbnail': 'https://img.youtube.com/vi/CrwRwgNJIMU/hqdefault.jpg',
      },
      {
        'title': 'Técnicas de Relaxamento Mental',
        'description':
            'Aprenda técnicas eficazes para relaxar a mente e reduzir ansiedade e estresse',
        'duration': '11:42',
        'category': 'Saúde Mental',
        'url': 'https://www.youtube.com/watch?v=2g1_FIGjuvc',
        'thumbnail': 'https://img.youtube.com/vi/2g1_FIGjuvc/hqdefault.jpg',
      },
      {
        'title': 'Mindfulness e Saúde Mental',
        'description':
            'Técnicas de mindfulness e atenção plena para fortalecer a saúde mental e reduzir estresse',
        'duration': '12:15',
        'category': 'Saúde Mental',
        'url': 'https://www.youtube.com/watch?v=kuA2l7tXtE4',
        'thumbnail': 'https://img.youtube.com/vi/kuA2l7tXtE4/hqdefault.jpg',
      },
    ];

    return _buildVideoList(
      videos,
      Icons.psychology,
      Color(0xFF7986CB),
    ); // Índigo suave
  }

  Widget _buildVideoList(
    List<Map<String, String>> videos,
    IconData icon,
    Color color,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return _buildVideoCard(video, icon, color);
      },
    );
  }

  Widget _buildVideoCard(
    Map<String, String> video,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Builder(
        builder: (context) => InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            final videoUrl = video['url'];
            if (videoUrl != null) {
              try {
                final uri = Uri.parse(videoUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Não foi possível abrir o vídeo'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao abrir vídeo: ${video['title']}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail do vídeo com imagem real do YouTube
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  image: video['thumbnail'] != null
                      ? DecorationImage(
                          image: NetworkImage(video['thumbnail']!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: video['thumbnail'] == null
                      ? color.withOpacity(0.7)
                      : null,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Overlay escuro para melhorar contraste
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    // Ícone de play
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        Icons.play_arrow,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    // Badge com duração
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          video['duration']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Informações do vídeo
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        video['category']!,
                        style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      video['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      video['description']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.play_arrow, size: 16, color: color),
                        const SizedBox(width: 4),
                        Text(
                          'Assistir vídeo',
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          video['duration']!,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tip) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getMoodColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(tip['icon'], color: _getMoodColor()),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tip['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tip['description'],
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
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
        return Icons.sentiment_very_dissatisfied;
      case 'neutral':
        return Icons.sentiment_neutral;
      case 'calm':
        return Icons.self_improvement;
      case 'stressed':
        return Icons.psychology;
      default:
        return Icons.help_outline;
    }
  }

  Color _getMoodColor() {
    switch (moodType) {
      case 'happy':
        return Colors.yellow[600]!;
      case 'sad':
        return Colors.blue[600]!;
      case 'neutral':
        return Colors.grey[600]!;
      case 'calm':
        return Colors.green[600]!;
      case 'stressed':
        return Colors.red[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  String _getMoodDescription() {
    switch (moodType) {
      case 'happy':
        return 'Que bom! Vamos manter essa energia positiva.';
      case 'sad':
        return 'Entendemos. Aqui estão algumas dicas para te ajudar.';
      case 'neutral':
        return 'Vamos encontrar maneiras de elevar seu bem-estar.';
      case 'calm':
        return 'Perfeito! Vamos manter essa tranquilidade.';
      case 'stressed':
        return 'Vamos trabalhar juntos para reduzir esse estresse.';
      default:
        return '';
    }
  }

  List<Map<String, dynamic>> _getMoodTips() {
    switch (moodType) {
      case 'happy':
        return [
          {
            'icon': Icons.share,
            'title': 'Compartilhe a alegria',
            'description':
                'Conte para alguém sobre o que está te deixando feliz. Compartilhar momentos bons multiplica a felicidade.',
          },
          {
            'icon': Icons.star,
            'title': 'Anote este momento',
            'description':
                'Escreva sobre o que está te fazendo sentir bem hoje. Isso te ajudará a lembrar nos dias difíceis.',
          },
          {
            'icon': Icons.favorite,
            'title': 'Pratique gratidão',
            'description':
                'Liste 3 coisas pelas quais você é grato hoje. A gratidão amplifica sentimentos positivos.',
          },
        ];
      case 'sad':
        return [
          {
            'icon': Icons.phone,
            'title': 'Conecte-se com alguém',
            'description':
                'Ligue ou mande mensagem para um amigo próximo. Não precisamos passar por momentos difíceis sozinhos.',
          },
          {
            'icon': Icons.nature_people,
            'title': 'Saia para o ar livre',
            'description':
                'Uma caminhada de 10 minutos ao ar livre pode melhorar significativamente seu humor.',
          },
          {
            'icon': Icons.self_improvement,
            'title': 'Respire conscientemente',
            'description':
                'Faça 5 respirações profundas e lentas. Inspire por 4 segundos, segure por 4, expire por 6.',
          },
        ];
      case 'neutral':
        return [
          {
            'icon': Icons.directions_walk,
            'title': 'Mova-se um pouco',
            'description':
                'Faça alguns alongamentos ou uma caminhada curta. O movimento pode despertar energia positiva.',
          },
          {
            'icon': Icons.music_note,
            'title': 'Ouça uma música',
            'description':
                'Coloque uma música que você gosta. A música tem poder de transformar nosso estado emocional.',
          },
          {
            'icon': Icons.local_cafe,
            'title': 'Faça uma pausa',
            'description':
                'Tome um chá ou café. Use esse momento para se reconectar com você mesmo.',
          },
        ];
      case 'calm':
        return [
          {
            'icon': Icons.spa,
            'title': 'Mantenha a serenidade',
            'description':
                'Continue praticando respiração profunda. Você está em um ótimo estado mental.',
          },
          {
            'icon': Icons.book,
            'title': 'Momento de reflexão',
            'description':
                'Aproveite essa calma para ler algumas páginas de um livro ou escrever em um diário.',
          },
          {
            'icon': Icons.nature,
            'title': 'Conecte-se com a natureza',
            'description':
                'Se possível, passe alguns minutos observando a natureza ao seu redor.',
          },
        ];
      case 'stressed':
        return [
          {
            'icon': Icons.pause_circle,
            'title': 'Pare e respire',
            'description':
                'Pare o que está fazendo por 2 minutos. Respire fundo e lembre-se: isso também vai passar.',
          },
          {
            'icon': Icons.list_alt,
            'title': 'Organize as prioridades',
            'description':
                'Escreva as 3 tarefas mais importantes. Foque apenas nelas e deixe o resto para depois.',
          },
          {
            'icon': Icons.local_drink,
            'title': 'Hidrate-se',
            'description':
                'Beba um copo de água gelada. A desidratação pode aumentar a sensação de estresse.',
          },
        ];
      default:
        return [];
    }
  }
}
