import 'package:flutter/foundation.dart';
import 'firebase_service.dart';
import 'mock_firebase_service.dart';

/// Service manager que decide automaticamente qual Firebase service usar
/// baseado na disponibilidade e compatibilidade da plataforma
class AppFirebaseService {
  static bool _useMock = false;

  /// Inicializa o serviço apropriado
  static Future<void> ensureInitialized() async {
    try {
      await FirebaseService.ensureInitialized();
      _useMock = false;
      if (kDebugMode) {
        print('✅ Usando Firebase real');
      }
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Firebase indisponível, usando Mock: $e');
        await MockFirebaseService.ensureInitialized();
        _useMock = true;
      } else {
        rethrow;
      }
    }
  }

  /// Verifica se deve usar Mock devido a API key inválida
  static bool _shouldUseMockForAuth(dynamic error) {
    final errorString = error.toString().toLowerCase();
    return errorString.contains('api-key-not-valid') ||
        errorString.contains('invalid-api-key') ||
        errorString.contains('api_key_invalid');
  }

  /// Getter para saber qual serviço está sendo usado
  static bool get isUsingMock => _useMock;
  static bool get isUsingReal => !_useMock;

  // Auth methods
  static Future<String?> signInAnonymously() async {
    if (_useMock) {
      return await MockFirebaseService.signInAnonymously();
    } else {
      final user = await FirebaseService.signInAnonymously();
      return user?.uid;
    }
  }

  static Future<void> signOut() async {
    if (_useMock) {
      await MockFirebaseService.signOut();
    } else {
      await FirebaseService.signOut();
    }
  }

  /// Login com email e senha
  static Future<String?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    if (_useMock) {
      return await MockFirebaseService.signInWithEmailAndPassword(
        email,
        password,
      );
    } else {
      try {
        final user = await FirebaseService.signInWithEmailAndPassword(
          email,
          password,
        );
        return user?.uid;
      } catch (e) {
        if (_shouldUseMockForAuth(e)) {
          if (kDebugMode) {
            print('🔄 API key inválida, usando Mock para login: $email');
          }
          return await MockFirebaseService.signInWithEmailAndPassword(
            email,
            password,
          );
        }
        rethrow;
      }
    }
  }

  /// Cadastro com email e senha
  static Future<String?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    if (_useMock) {
      return await MockFirebaseService.createUserWithEmailAndPassword(
        email,
        password,
      );
    } else {
      try {
        final user = await FirebaseService.createUserWithEmailAndPassword(
          email,
          password,
        );
        return user?.uid;
      } catch (e) {
        if (_shouldUseMockForAuth(e)) {
          if (kDebugMode) {
            print('🔄 API key inválida, usando Mock para registro: $email');
          }
          return await MockFirebaseService.createUserWithEmailAndPassword(
            email,
            password,
          );
        }
        rethrow;
      }
    }
  }

  static String? get currentUser {
    if (_useMock) {
      return MockFirebaseService.currentUser;
    } else {
      return FirebaseService.currentUser?.uid;
    }
  }

  static bool get isLoggedIn {
    if (_useMock) {
      return MockFirebaseService.isLoggedIn;
    } else {
      return FirebaseService.isLoggedIn;
    }
  }

  // Firestore methods
  static Future<void> saveData(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    if (_useMock) {
      await MockFirebaseService.saveData(collection, docId, data);
    } else {
      await FirebaseService.saveData(collection, docId, data);
    }
  }

  static Future<Map<String, dynamic>?> getData(
    String collection,
    String docId,
  ) async {
    if (_useMock) {
      return await MockFirebaseService.getData(collection, docId);
    } else {
      final doc = await FirebaseService.getData(collection, docId);
      return doc?.data() as Map<String, dynamic>?;
    }
  }

  static Future<void> createUserDocument(
    String uid,
    Map<String, dynamic> data,
  ) async {
    if (_useMock) {
      await MockFirebaseService.createUserDocument(uid, data);
    } else {
      await FirebaseService.createUserDocument(uid, data);
    }
  }

  static Future<Map<String, dynamic>?> getUserDocument(String uid) async {
    if (_useMock) {
      return await MockFirebaseService.getUserDocument(uid);
    } else {
      final doc = await FirebaseService.getUserDocument(uid);
      return doc?.data() as Map<String, dynamic>?;
    }
  }

  // Storage methods
  static Future<String?> uploadFile(String path, List<int> bytes) async {
    if (_useMock) {
      return await MockFirebaseService.uploadFile(path, bytes);
    } else {
      return await FirebaseService.uploadFile(path, bytes);
    }
  }

  static Future<void> deleteFile(String path) async {
    if (_useMock) {
      await MockFirebaseService.deleteFile(path);
    } else {
      await FirebaseService.deleteFile(path);
    }
  }

  // Status methods
  static bool get isInitialized {
    if (_useMock) {
      return MockFirebaseService.isInitialized;
    } else {
      return FirebaseService.isInitialized;
    }
  }

  /// Para debug - mostra informações do serviço atual
  static void printServiceInfo() {
    if (kDebugMode) {
      print('🔧 AppFirebaseService Info:');
      print('   - Usando: ${_useMock ? "Mock" : "Firebase Real"}');
      print('   - Inicializado: $isInitialized');
      print('   - Logado: $isLoggedIn');
      print('   - User ID: $currentUser');
    }
  }
}
