import 'package:flutter/material.dart';
import '../ui/screens/welcome_screen.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/register_screen.dart';
import '../ui/screens/home/main_screen.dart';
import '../ui/screens/exercises/exercises_screen.dart';
import '../ui/screens/breathing/breathing_screen.dart';
import '../ui/screens/diary/diary_screen.dart';
import '../ui/screens/education/education_screen.dart';

/// Classe responsável pelo gerenciamento de rotas do aplicativo
class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String exercises = '/exercises';
  static const String breathing = '/breathing';
  static const String diary = '/diary';
  static const String education = '/education';

  /// Mapa de rotas disponíveis no aplicativo
  static Map<String, WidgetBuilder> routes = {
    welcome: (context) => const WelcomeScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    main: (context) => const MainScreen(),
    exercises: (context) => const ExercisesScreen(),
    breathing: (context) => const BreathingScreen(),
    diary: (context) => const DiaryScreen(),
    education: (context) => const EducationScreen(),
  };

  /// Método para navegação programática
  static void navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  /// Método para navegação com substituição de tela
  static void navigateToReplacement(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  /// Método para navegação limpando o stack
  static void navigateToAndClearStack(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  /// Método para voltar à tela anterior
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
