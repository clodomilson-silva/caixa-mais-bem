import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Widget _buildHeroCard(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 420,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.purplePrimary, AppColors.purpleLight],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite, size: 88, color: Colors.white),
          const SizedBox(height: 18),
          Text(
            'Caixa Mais Bem',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Text(
              'Promovendo saúde física e mental para operadores de caixa.\n\nExercícios rápidos, técnicas de respiração, diário emocional e muito mais.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: CustomButton(
              text: 'Começar Jornada',
              onPressed: () => Navigator.pushNamed(context, '/login'),
              backgroundColor: Colors.white,
              textColor: AppColors.purplePrimary,
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/main'),
            child: const Text(
              'Explorar sem conta',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Caixa Mais Bem',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.purplePrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(child: Center(child: _buildHeroCard(context))),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
