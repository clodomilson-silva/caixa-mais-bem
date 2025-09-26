import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _messageController = TextEditingController();
  final _emailController = TextEditingController(text: 'usuario@caixabank.com');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Suporte & Ajuda',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'FAQ'),
            Tab(text: 'Contato'),
            Tab(text: 'Sobre'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildFaqTab(), _buildContactTab(), _buildAboutTab()],
      ),
    );
  }

  Widget _buildFaqTab() {
    final faqs = [
      {
        'question': 'Como registrar meu humor diariamente?',
        'answer':
            'Vá até a aba "Diário" e toque em "Registrar Agora". Selecione seu nível de humor e adicione observações se desejar.',
      },
      {
        'question': 'Posso desativar as notificações?',
        'answer':
            'Sim! Acesse Configurações > Notificações e desative os tipos de lembretes que não deseja receber.',
      },
      {
        'question': 'Como fazer exercícios no trabalho?',
        'answer':
            'Na aba "Exercícios", você encontra atividades adaptadas para o ambiente de trabalho, com vídeos explicativos.',
      },
      {
        'question': 'Os dados do meu humor são privados?',
        'answer':
            'Sim! Seus dados são totalmente privados. Apenas você tem acesso às suas informações pessoais de humor.',
      },
      {
        'question': 'Como funciona a análise de padrões?',
        'answer':
            'O app analisa seus registros de humor ao longo do tempo para identificar tendências e oferecer insights personalizados.',
      },
      {
        'question': 'Posso usar o app offline?',
        'answer':
            'A maioria das funcionalidades funciona offline. Apenas vídeos e conteúdo educativo precisam de conexão com internet.',
      },
      {
        'question': 'Como exportar meus dados?',
        'answer':
            'No seu perfil, há a opção "Exportar Meus Dados". Você receberá um arquivo com todos os seus registros.',
      },
      {
        'question': 'O que fazer se esquecer de registrar meu humor?',
        'answer':
            'Não se preocupe! Você pode registrar seu humor de dias anteriores acessando o histórico.',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        final faq = faqs[index];
        return _buildFaqItem(faq['question']!, faq['answer']!);
      },
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        backgroundColor: AppColors.surface,
        collapsedBackgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.primary.withOpacity(0.1)),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.primary.withOpacity(0.1)),
        ),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.help_outline, color: AppColors.primary, size: 20),
        ),
        title: Text(
          question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Formulário de contato
          _buildContactForm(),

          const SizedBox(height: 24),

          // Outras formas de contato
          _buildContactOptions(),

          const SizedBox(height: 24),

          // Horários de atendimento
          _buildSupportHours(),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.email_outlined, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'Entre em Contato',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Seu email',
              prefixIcon: Icon(Icons.alternate_email, color: AppColors.primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _messageController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Sua mensagem',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Icon(Icons.message, color: AppColors.primary),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              hintText: 'Descreva sua dúvida, sugestão ou problema...',
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send),
              label: const Text('Enviar Mensagem'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOptions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.support_agent, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'Outras Opções',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildContactOption(
            'WhatsApp Business',
            '+55 11 9999-9999',
            Icons.chat,
            AppColors.success,
            () => _launchWhatsApp(),
          ),
          const SizedBox(height: 16),
          _buildContactOption(
            'Email Direto',
            'suporte.bemestar@caixabank.com',
            Icons.email,
            AppColors.vitality,
            () => _launchEmail(),
          ),
          const SizedBox(height: 16),
          _buildContactOption(
            'Telefone',
            '0800 123 4567',
            Icons.phone,
            AppColors.complement,
            () => _launchPhone(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportHours() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'Horário de Atendimento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildScheduleItem('Segunda a Sexta', '8h às 18h'),
          _buildScheduleItem('Sábado', '8h às 12h'),
          _buildScheduleItem('Domingo e Feriados', 'Fechado'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: AppColors.info),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Mensagens enviadas fora do horário serão respondidas no próximo dia útil.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            hours,
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Informações do app
          _buildAppInfo(),

          const SizedBox(height: 24),

          // Recursos do app
          _buildFeatures(),

          const SizedBox(height: 24),

          // Links legais
          _buildLegalLinks(),

          const SizedBox(height: 24),

          // Créditos
          _buildCredits(),
        ],
      ),
    );
  }

  Widget _buildAppInfo() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.favorite, size: 48, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          const Text(
            'Caixa Mais Bem',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Versão 1.0.0',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          Text(
            'Aplicativo dedicado ao bem-estar e saúde mental dos colaboradores, oferecendo ferramentas para monitoramento de humor, exercícios, técnicas de respiração e muito mais.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures() {
    final features = [
      {
        'icon': Icons.mood,
        'title': 'Diário Emocional',
        'desc': 'Registre e acompanhe seu humor',
      },
      {
        'icon': Icons.fitness_center,
        'title': 'Exercícios',
        'desc': 'Atividades para o trabalho',
      },
      {
        'icon': Icons.air,
        'title': 'Respiração',
        'desc': 'Técnicas de relaxamento',
      },
      {
        'icon': Icons.school,
        'title': 'Educação',
        'desc': 'Conteúdo sobre bem-estar',
      },
      {
        'icon': Icons.analytics,
        'title': 'Análises',
        'desc': 'Insights sobre seu progresso',
      },
      {
        'icon': Icons.notifications,
        'title': 'Lembretes',
        'desc': 'Notificações personalizadas',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'Recursos Principais',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary.withOpacity(0.1),
                      AppColors.serenity.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      feature['icon'] as IconData,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      feature['title'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      feature['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLegalLinks() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.gavel, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'Informações Legais',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildLegalLink('Termos de Uso', () => _showLegalDocument('terms')),
          _buildLegalLink(
            'Política de Privacidade',
            () => _showLegalDocument('privacy'),
          ),
          _buildLegalLink(
            'Licenças de Terceiros',
            () => _showLegalDocument('licenses'),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalLink(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCredits() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.code, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'Desenvolvido com ❤️',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Equipe de TI - Caixa Bank\n© 2025 - Todos os direitos reservados',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Por favor, digite sua mensagem'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    // TODO: Implementar envio real de mensagem
    _messageController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Mensagem enviada com sucesso!'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _launchWhatsApp() async {
    const url = 'https://wa.me/5511999999999';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  void _launchEmail() async {
    const url =
        'mailto:suporte.bemestar@caixabank.com?subject=Suporte Caixa Mais Bem';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _launchPhone() async {
    const url = 'tel:08001234567';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _showLegalDocument(String type) {
    String title = '';
    String content = '';

    switch (type) {
      case 'terms':
        title = 'Termos de Uso';
        content = 'Aqui estariam os termos de uso do aplicativo...';
        break;
      case 'privacy':
        title = 'Política de Privacidade';
        content = 'Aqui estaria a política de privacidade do aplicativo...';
        break;
      case 'licenses':
        title = 'Licenças de Terceiros';
        content = 'Aqui estariam as licenças dos componentes de terceiros...';
        break;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(content)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
