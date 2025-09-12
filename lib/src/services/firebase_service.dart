import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../firebase_options.dart';

/// Serviço Firebase principal para gerenciar autenticação, Firestore e Storage
/// Compatível com Web e Mobile
class FirebaseService {
  static FirebaseApp? _app;
  static FirebaseAuth? _auth;
  static FirebaseFirestore? _firestore;
  static FirebaseStorage? _storage;
  static bool _initialized = false;

  /// Inicialização do Firebase (chame em main)
  static Future<void> ensureInitialized() async {
    if (_initialized) return;

    try {
      if (_app == null) {
        _app = await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

        _auth = FirebaseAuth.instanceFor(app: _app!);
        _firestore = FirebaseFirestore.instanceFor(app: _app!);
        _storage = FirebaseStorage.instanceFor(app: _app!);

        _initialized = true;
        print(
          '✅ Firebase inicializado com sucesso na plataforma: ${kIsWeb ? "Web" : "Mobile"}',
        );
      }
    } catch (e) {
      print('❌ Erro ao inicializar Firebase: $e');
      if (kDebugMode) {
        print(
          '💡 Dica: Certifique-se de que os arquivos de configuração do Firebase estão corretos',
        );
        print('⚠️ Continuando sem Firebase em modo debug');
        _initialized =
            true; // Marca como inicializado para evitar tentativas repetidas
        return;
      }
      rethrow;
    }
  }

  // Getters estáticos para acesso às instâncias
  static FirebaseAuth? get auth => _auth;
  static FirebaseFirestore? get firestore => _firestore;
  static FirebaseStorage? get storage => _storage;
  static User? get currentUser => _auth?.currentUser;
  static Stream<User?>? get authStateChanges => _auth?.authStateChanges();
  static bool get isLoggedIn => currentUser != null;

  /// Autenticação Anônima
  static Future<User?> signInAnonymously() async {
    try {
      final result = await _auth!.signInAnonymously();
      return result.user;
    } catch (e) {
      print(' Erro ao fazer login anônimo: ');
      return null;
    }
  }

  /// Logout
  static Future<void> signOut() async {
    try {
      await _auth?.signOut();
      print(' Logout realizado com sucesso');
    } catch (e) {
      print(' Erro ao fazer logout: ');
    }
  }

  /// Criar documento de usuário no Firestore
  static Future<void> createUserDocument(
    String uid,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore?.collection('users').doc(uid).set(data);
      print(' Documento de usuário criado: ');
    } catch (e) {
      print(' Erro ao criar documento de usuário: ');
    }
  }

  /// Obter dados do usuário
  static Future<DocumentSnapshot?> getUserDocument(String uid) async {
    try {
      return await _firestore?.collection('users').doc(uid).get();
    } catch (e) {
      print(' Erro ao obter documento de usuário: ');
      return null;
    }
  }

  /// Salvar dados no Firestore
  static Future<void> saveData(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore?.collection(collection).doc(docId).set(data);
      print(' Dados salvos em /');
    } catch (e) {
      print(' Erro ao salvar dados: ');
    }
  }

  /// Obter dados do Firestore
  static Future<DocumentSnapshot?> getData(
    String collection,
    String docId,
  ) async {
    try {
      return await _firestore?.collection(collection).doc(docId).get();
    } catch (e) {
      print(' Erro ao obter dados: ');
      return null;
    }
  }

  /// Stream de dados do Firestore
  static Stream<DocumentSnapshot>? getDataStream(
    String collection,
    String docId,
  ) {
    try {
      return _firestore?.collection(collection).doc(docId).snapshots();
    } catch (e) {
      print(' Erro ao criar stream de dados: ');
      return null;
    }
  }

  /// Upload de arquivo para Firebase Storage
  /// Compatível com Web e Mobile
  static Future<String?> uploadFile(String path, List<int> bytes) async {
    if (_storage == null) {
      print('⚠️ Firebase Storage não está inicializado');
      return null;
    }

    try {
      final ref = _storage!.ref().child(path);
      final uploadTask = ref.putData(Uint8List.fromList(bytes));
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      print('✅ Upload realizado: $path');
      return downloadUrl;
    } catch (e) {
      print('❌ Erro ao fazer upload: $e');
      if (kIsWeb) {
        print('💡 Nota: Upload em web pode ter limitações adicionais');
      }
      return null;
    }
  }

  /// Deletar arquivo do Firebase Storage
  static Future<void> deleteFile(String path) async {
    if (_storage == null) {
      print('⚠️ Firebase Storage não está inicializado');
      return;
    }

    try {
      await _storage!.ref().child(path).delete();
      print('✅ Arquivo deletado: $path');
    } catch (e) {
      print('❌ Erro ao deletar arquivo: $e');
    }
  }

  /// Verificar se o Firebase está inicializado
  static bool get isInitialized => _initialized && _app != null;

  /// Verificar se está conectado (para uso futuro)
  static bool get isConnected => isInitialized;
}
