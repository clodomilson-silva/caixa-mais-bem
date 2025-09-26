import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Configurações gerais
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  // Tipos de notificações
  bool _moodReminders = true;
  bool _exerciseReminders = true;
  bool _breathingReminders = true;
  bool _breakReminders = true;
  bool _weeklyReflection = true;

  // Horários
  TimeOfDay _morningTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _afternoonTime = const TimeOfDay(hour: 14, minute: 30);
  TimeOfDay _eveningTime = const TimeOfDay(hour: 18, minute: 0);

  // Frequência
  String _frequency = 'Diário';
  final List<String> _frequencyOptions = [
    'Desligado',
    'Diário',
    '2x por dia',
    '3x por dia',
    'Personalizado',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Notificações',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Configurações gerais
            _buildGeneralSettings(),

            // Tipos de notificações
            _buildNotificationTypes(),

            // Horários
            if (_notificationsEnabled) _buildScheduleSettings(),

            // Frequência
            if (_notificationsEnabled) _buildFrequencySettings(),

            // Teste
            if (_notificationsEnabled) _buildTestSection(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.serenity],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(
              _notificationsEnabled
                  ? Icons.notifications_active
                  : Icons.notifications_off,
              size: 48,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              _notificationsEnabled
                  ? 'Notificações Ativas'
                  : 'Notificações Desativadas',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Configure quando e como receber lembretes',
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return Container(
      margin: const EdgeInsets.all(16),
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
              Icon(Icons.settings_outlined, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'Configurações Gerais',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSwitchTile(
            'Ativar Notificações',
            'Receber todos os tipos de lembretes',
            _notificationsEnabled,
            (value) => setState(() => _notificationsEnabled = value),
            Icons.notifications,
            AppColors.primary,
          ),
          if (_notificationsEnabled) ...[
            const SizedBox(height: 16),
            _buildSwitchTile(
              'Som',
              'Reproduzir som nas notificações',
              _soundEnabled,
              (value) => setState(() => _soundEnabled = value),
              Icons.volume_up,
              AppColors.vitality,
            ),
            const SizedBox(height: 16),
            _buildSwitchTile(
              'Vibração',
              'Vibrar quando receber notificação',
              _vibrationEnabled,
              (value) => setState(() => _vibrationEnabled = value),
              Icons.vibration,
              AppColors.energy,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNotificationTypes() {
    if (!_notificationsEnabled) return const SizedBox();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
              Icon(Icons.category_outlined, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'Tipos de Lembretes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSwitchTile(
            'Check-in de Humor',
            'Lembre-me de registrar como estou me sentindo',
            _moodReminders,
            (value) => setState(() => _moodReminders = value),
            Icons.mood,
            AppColors.complement,
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            'Exercícios no Trabalho',
            'Hora de fazer uma pausa para exercitar-se',
            _exerciseReminders,
            (value) => setState(() => _exerciseReminders = value),
            Icons.fitness_center,
            AppColors.energy,
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            'Técnicas de Respiração',
            'Momento para uma respiração consciente',
            _breathingReminders,
            (value) => setState(() => _breathingReminders = value),
            Icons.air,
            AppColors.serenity,
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            'Pausas Regulares',
            'Lembretes para descansar a mente',
            _breakReminders,
            (value) => setState(() => _breakReminders = value),
            Icons.pause_circle,
            AppColors.balance,
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            'Reflexão Semanal',
            'Convite para reflexão sobre a semana',
            _weeklyReflection,
            (value) => setState(() => _weeklyReflection = value),
            Icons.self_improvement,
            AppColors.mindfulness,
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSettings() {
    return Container(
      margin: const EdgeInsets.all(16),
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
                'Horários',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildTimePicker(
            'Manhã',
            'Primeiro lembrete do dia',
            _morningTime,
            Icons.wb_sunny,
            AppColors.warning,
            (time) => setState(() => _morningTime = time),
          ),
          const SizedBox(height: 16),
          _buildTimePicker(
            'Tarde',
            'Pausa para o meio do dia',
            _afternoonTime,
            Icons.wb_sunny_outlined,
            AppColors.vitality,
            (time) => setState(() => _afternoonTime = time),
          ),
          const SizedBox(height: 16),
          _buildTimePicker(
            'Final do Dia',
            'Reflexão antes de sair',
            _eveningTime,
            Icons.nights_stay,
            AppColors.mindfulness,
            (time) => setState(() => _eveningTime = time),
          ),
        ],
      ),
    );
  }

  Widget _buildFrequencySettings() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
              Icon(Icons.repeat, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'Frequência',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _frequency,
                isExpanded: true,
                items: _frequencyOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => _frequency = newValue);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _getFrequencyDescription(),
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildTestSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _sendTestNotification,
          icon: const Icon(Icons.send),
          label: const Text('Enviar Notificação de Teste'),
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
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 12),
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
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildTimePicker(
    String title,
    String subtitle,
    TimeOfDay time,
    IconData icon,
    Color color,
    Function(TimeOfDay) onChanged,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 12),
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
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => _selectTime(context, time, onChanged),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              time.format(context),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getFrequencyDescription() {
    switch (_frequency) {
      case 'Desligado':
        return 'Nenhum lembrete será enviado';
      case 'Diário':
        return 'Um lembrete por dia no horário da manhã';
      case '2x por dia':
        return 'Lembretes de manhã e tarde';
      case '3x por dia':
        return 'Lembretes de manhã, tarde e final do dia';
      case 'Personalizado':
        return 'Use os horários configurados acima';
      default:
        return '';
    }
  }

  Future<void> _selectTime(
    BuildContext context,
    TimeOfDay currentTime,
    Function(TimeOfDay) onChanged,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onChanged(picked);
    }
  }

  void _sendTestNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notificação de teste enviada!'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
