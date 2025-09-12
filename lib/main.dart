import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'src/app.dart';
import 'src/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase com as versões atualizadas
  await FirebaseService.ensureInitialized();

  if (kDebugMode) {
    print(
      '🔥 Firebase Status: ${FirebaseService.isInitialized ? "Inicializado" : "Não inicializado"}',
    );
  }

  runApp(
    // Device Preview apenas para web em desenvolvimento
    kIsWeb && !kReleaseMode
        ? DevicePreview(
            enabled: true,
            builder: (context) => const CaixaMaisBemApp(),
            devices: [
              Devices.ios.iPhone13,
              Devices.android.samsungGalaxyS20,
              Devices.ios.iPad,
            ],
          )
        : const CaixaMaisBemApp(),
  );
}
