import 'package:flutter/material.dart';
import 'package:caixa_mais_bem/src/widgets/rounded_card.dart';

class AlertsTab extends StatefulWidget {
  const AlertsTab({super.key});

  @override
  State<AlertsTab> createState() => _AlertsTabState();
}

class _AlertsTabState extends State<AlertsTab> {
  bool _pauseReminders = false;
  bool _exerciseReminders = false;
  bool _breathingReminders = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alertas e Lembretes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            RoundedCard(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Lembretes de pausa'),
                    subtitle: const Text('Notificações a cada 30 minutos'),
                    value: _pauseReminders,
                    onChanged: (value) {
                      setState(() => _pauseReminders = value);
                      // TODO: configurar notificações
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Lembretes de exercícios'),
                    subtitle: const Text('Alongamentos durante o dia'),
                    value: _exerciseReminders,
                    onChanged: (value) {
                      setState(() => _exerciseReminders = value);
                      // TODO: configurar notificações
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Lembretes de respiração'),
                    subtitle: const Text('Exercícios de respiração'),
                    value: _breathingReminders,
                    onChanged: (value) {
                      setState(() => _breathingReminders = value);
                      // TODO: configurar notificações
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            RoundedCard(
              child: ListTile(
                leading: const Icon(Icons.schedule),
                title: const Text('Configurar horários'),
                subtitle: const Text('Personalizar horários dos lembretes'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // TODO: abrir tela de configuração de horários
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Configuração de horários em breve'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
