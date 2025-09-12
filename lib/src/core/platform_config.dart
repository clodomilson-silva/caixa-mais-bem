import 'package:flutter/foundation.dart';

/// Configurações específicas por plataforma
class PlatformConfig {
  // URLs e configurações específicas
  static const String webUrl = 'https://caixa-mais-bem.web.app';
  static const String androidPackage = 'com.example.caixa_mais_bem';
  static const String iosBundle = 'com.example.caixaMaisBem';

  // Configurações de UI por plataforma
  static bool get showAppBar => !kIsWeb;
  static bool get useBottomNavigation =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
  static bool get useSideNavigation =>
      kIsWeb ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux;

  // Configurações de notificação
  static bool get supportsNotifications => !kIsWeb;

  // Configurações de storage
  static bool get supportsFileSystem => !kIsWeb;

  // Obter nome da plataforma
  static String get platformName {
    if (kIsWeb) return 'Web';
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'Android';
      case TargetPlatform.iOS:
        return 'iOS';
      case TargetPlatform.windows:
        return 'Windows';
      case TargetPlatform.macOS:
        return 'macOS';
      case TargetPlatform.linux:
        return 'Linux';
      default:
        return 'Unknown';
    }
  }
}
