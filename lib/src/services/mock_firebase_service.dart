import 'package:flutter/foundation.dart';

/// Serviço de fallback quando Firebase não está disponível
/// Usado principalmente em desenvolvimento ou quando há problemas de compatibilidade
class MockFirebaseService {
  static bool _initialized = false;
  static final Map<String, Map<String, dynamic>> _mockData = {};
  static final List<String> _mockUsers = [];

  static Future<void> ensureInitialized() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _initialized = true;
    if (kDebugMode) {
      print('🔧 MockFirebaseService inicializado (modo desenvolvimento)');
    }
  }

  static bool get isInitialized => _initialized;

  // Mock Auth
  static Future<String?> signInAnonymously() async {
    if (!_initialized) return null;

    final userId = 'mock_user_${DateTime.now().millisecondsSinceEpoch}';
    _mockUsers.add(userId);

    if (kDebugMode) {
      print('🔧 Mock login anônimo: $userId');
    }
    return userId;
  }

  static Future<void> signOut() async {
    if (kDebugMode) {
      print('🔧 Mock logout');
    }
  }

  static String? get currentUser =>
      _mockUsers.isNotEmpty ? _mockUsers.last : null;

  static bool get isLoggedIn => currentUser != null;

  // Mock Firestore
  static Future<void> saveData(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    if (!_initialized) return;

    _mockData['$collection/$docId'] = {
      ...data,
      'timestamp': DateTime.now().toIso8601String(),
    };

    if (kDebugMode) {
      print('🔧 Mock save: $collection/$docId -> $data');
    }
  }

  static Future<Map<String, dynamic>?> getData(
    String collection,
    String docId,
  ) async {
    if (!_initialized) return null;

    final data = _mockData['$collection/$docId'];
    if (kDebugMode && data != null) {
      print('🔧 Mock get: $collection/$docId -> $data');
    }
    return data;
  }

  static Future<void> createUserDocument(
    String uid,
    Map<String, dynamic> data,
  ) async {
    await saveData('users', uid, data);
  }

  static Future<Map<String, dynamic>?> getUserDocument(String uid) async {
    return await getData('users', uid);
  }

  // Mock Storage
  static Future<String?> uploadFile(String path, List<int> bytes) async {
    if (!_initialized) return null;

    // Simula upload retornando uma URL mock
    final mockUrl = 'mock://storage/$path?size=${bytes.length}';

    if (kDebugMode) {
      print('🔧 Mock upload: $path (${bytes.length} bytes) -> $mockUrl');
    }
    return mockUrl;
  }

  static Future<void> deleteFile(String path) async {
    if (kDebugMode) {
      print('🔧 Mock delete: $path');
    }
  }

  // Utilitários
  static void clearMockData() {
    _mockData.clear();
    _mockUsers.clear();
    if (kDebugMode) {
      print('🔧 Mock data cleared');
    }
  }

  static Map<String, dynamic> getMockDataSnapshot() {
    return Map.from(_mockData);
  }
}
