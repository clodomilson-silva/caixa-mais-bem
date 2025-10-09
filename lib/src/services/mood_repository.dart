import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mood_entry.dart';
import 'app_firebase_service.dart';

class MoodRepository {
  static const String _moodEntriesKey = 'mood_entries';
  static const String _weeklyReflectionsKey = 'weekly_reflections';
  static const String _streakKey = 'mood_streak';
  static const String _lastEntryDateKey = 'last_entry_date';

  /// Obter ID do usuário atual (com fallback para SharedPreferences local)
  static String _getCurrentUserId() {
    final userId = AppFirebaseService.currentUser;
    return userId ?? 'local_user'; // Fallback para usuário local
  }

  /// Obter chave específica do usuário
  static String _getUserSpecificKey(String baseKey) {
    return '${_getCurrentUserId()}_$baseKey';
  }

  // Salvar entrada de humor
  static Future<void> saveMoodEntry(MoodEntry entry) async {
    final userId = _getCurrentUserId();
    
    if (userId != 'local_user') {
      // Salvar no Firebase com isolamento por usuário
      await _saveMoodEntryToFirebase(userId, entry);
    } else {
      // Fallback para SharedPreferences com chave do usuário
      await _saveMoodEntryLocally(entry);
    }

    // Atualizar streak
    await _updateStreak();
  }

  /// Salvar no Firebase
  static Future<void> _saveMoodEntryToFirebase(String userId, MoodEntry entry) async {
    try {
      final entryId = 'mood_${DateTime.now().millisecondsSinceEpoch}';
      await AppFirebaseService.saveData(
        'users/$userId/mood_entries',
        entryId,
        entry.toJson(),
      );
    } catch (e) {
      // Se falhar no Firebase, usar SharedPreferences como backup
      await _saveMoodEntryLocally(entry);
    }
  }

  /// Salvar localmente (com user-specific key)
  static Future<void> _saveMoodEntryLocally(MoodEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = await getAllMoodEntries();
    entries.add(entry);

    final entriesJson = entries.map((e) => e.toJson()).toList();
    final userKey = _getUserSpecificKey(_moodEntriesKey);
    await prefs.setString(userKey, jsonEncode(entriesJson));
  }

  // Obter todas as entradas
  static Future<List<MoodEntry>> getAllMoodEntries() async {
    final userId = _getCurrentUserId();
    
    if (userId != 'local_user') {
      // Tentar carregar do Firebase primeiro
      try {
        return await _getAllMoodEntriesFromFirebase(userId);
      } catch (e) {
        // Se falhar, usar SharedPreferences como backup
        return await _getAllMoodEntriesLocally();
      }
    } else {
      // Usar SharedPreferences com chave do usuário
      return await _getAllMoodEntriesLocally();
    }
  }

  /// Carregar do Firebase
  static Future<List<MoodEntry>> _getAllMoodEntriesFromFirebase(String userId) async {
    // TODO: Implementar carregamento de múltiplos documentos do Firebase
    // Por enquanto, usar SharedPreferences como fallback
    return await _getAllMoodEntriesLocally();
  }

  /// Carregar localmente (com user-specific key)
  static Future<List<MoodEntry>> _getAllMoodEntriesLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final userKey = _getUserSpecificKey(_moodEntriesKey);
    final entriesString = prefs.getString(userKey);

    if (entriesString == null) return [];

    final List<dynamic> entriesJson = jsonDecode(entriesString);
    return entriesJson.map((json) => MoodEntry.fromJson(json)).toList();
  }

  // Obter entradas de uma data específica
  static Future<List<MoodEntry>> getEntriesForDate(DateTime date) async {
    final allEntries = await getAllMoodEntries();
    return allEntries.where((entry) {
      return entry.timestamp.year == date.year &&
          entry.timestamp.month == date.month &&
          entry.timestamp.day == date.day;
    }).toList();
  }

  // Obter entradas da semana
  static Future<List<MoodEntry>> getEntriesForWeek(DateTime startOfWeek) async {
    final allEntries = await getAllMoodEntries();
    final endOfWeek = startOfWeek.add(const Duration(days: 7));

    return allEntries.where((entry) {
      return entry.timestamp.isAfter(startOfWeek) &&
          entry.timestamp.isBefore(endOfWeek);
    }).toList();
  }

  // Obter entradas do mês
  static Future<List<MoodEntry>> getEntriesForMonth(DateTime month) async {
    final allEntries = await getAllMoodEntries();
    return allEntries.where((entry) {
      return entry.timestamp.year == month.year &&
          entry.timestamp.month == month.month;
    }).toList();
  }

  // Verificar se há entrada hoje
  static Future<bool> hasEntryToday() async {
    final today = DateTime.now();
    final todayEntries = await getEntriesForDate(today);
    return todayEntries.isNotEmpty;
  }

  // Obter última entrada
  static Future<MoodEntry?> getLastEntry() async {
    final entries = await getAllMoodEntries();
    if (entries.isEmpty) return null;

    entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return entries.first;
  }

  // Calcular média de humor da semana
  static Future<double> getWeeklyMoodAverage(DateTime weekStart) async {
    final entries = await getEntriesForWeek(weekStart);
    if (entries.isEmpty) return 0.0;

    final sum = entries.map((e) => e.moodLevel).reduce((a, b) => a + b);
    return sum / entries.length;
  }

  // Obter emoções mais frequentes
  static Future<Map<String, int>> getMostFrequentEmotions([
    int days = 30,
  ]) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    final allEntries = await getAllMoodEntries();

    final recentEntries = allEntries
        .where((entry) => entry.timestamp.isAfter(cutoffDate))
        .toList();

    final emotionCount = <String, int>{};
    for (final entry in recentEntries) {
      for (final emotion in entry.emotions) {
        emotionCount[emotion] = (emotionCount[emotion] ?? 0) + 1;
      }
    }

    return emotionCount;
  }

  // Obter gatilhos mais frequentes
  static Future<Map<String, int>> getMostFrequentTriggers([
    int days = 30,
  ]) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    final allEntries = await getAllMoodEntries();

    final recentEntries = allEntries
        .where(
          (entry) =>
              entry.timestamp.isAfter(cutoffDate) && entry.trigger != null,
        )
        .toList();

    final triggerCount = <String, int>{};
    for (final entry in recentEntries) {
      if (entry.trigger != null) {
        triggerCount[entry.trigger!] = (triggerCount[entry.trigger!] ?? 0) + 1;
      }
    }

    return triggerCount;
  }

  // Obter streak atual
  static Future<int> getCurrentStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final userKey = _getUserSpecificKey(_streakKey);
    return prefs.getInt(userKey) ?? 0;
  }

  // Atualizar streak
  static Future<void> _updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final todayString = '${today.year}-${today.month}-${today.day}';
    final userLastEntryKey = _getUserSpecificKey(_lastEntryDateKey);
    final lastEntryDateString = prefs.getString(userLastEntryKey);

    if (lastEntryDateString == null) {
      // Primeira entrada
      final userStreakKey = _getUserSpecificKey(_streakKey);
      await prefs.setInt(userStreakKey, 1);
      await prefs.setString(userLastEntryKey, todayString);
      return;
    }

    final lastEntryDate = DateTime.parse(lastEntryDateString);
    final yesterday = today.subtract(const Duration(days: 1));

    if (lastEntryDate.day == yesterday.day &&
        lastEntryDate.month == yesterday.month &&
        lastEntryDate.year == yesterday.year) {
      // Continuando streak
      final currentStreak = await getCurrentStreak();
      final userStreakKey = _getUserSpecificKey(_streakKey);
      await prefs.setInt(userStreakKey, currentStreak + 1);
    } else if (lastEntryDate.day != today.day ||
        lastEntryDate.month != today.month ||
        lastEntryDate.year != today.year) {
      // Quebrou o streak ou é o primeiro do dia
      final userStreakKey = _getUserSpecificKey(_streakKey);
      await prefs.setInt(userStreakKey, 1);
    }

    await prefs.setString(userLastEntryKey, todayString);
  }

  // Salvar reflexão semanal
  static Future<void> saveWeeklyReflection(WeeklyReflection reflection) async {
    final prefs = await SharedPreferences.getInstance();
    final reflections = await getAllWeeklyReflections();
    reflections.add(reflection);

    final reflectionsJson = reflections.map((r) => r.toJson()).toList();
    final userKey = _getUserSpecificKey(_weeklyReflectionsKey);
    await prefs.setString(userKey, jsonEncode(reflectionsJson));
  }

  // Obter todas as reflexões semanais
  static Future<List<WeeklyReflection>> getAllWeeklyReflections() async {
    final prefs = await SharedPreferences.getInstance();
    final userKey = _getUserSpecificKey(_weeklyReflectionsKey);
    final reflectionsString = prefs.getString(userKey);

    if (reflectionsString == null) return [];

    final List<dynamic> reflectionsJson = jsonDecode(reflectionsString);
    return reflectionsJson
        .map((json) => WeeklyReflection.fromJson(json))
        .toList();
  }

  // Gerar insights automáticos
  static Future<List<String>> generateInsights() async {
    final insights = <String>[];
    final last30Days = await getEntriesForMonth(DateTime.now());

    if (last30Days.isEmpty) {
      insights.add(
        'Comece registrando seus sentimentos para receber insights personalizados!',
      );
      return insights;
    }

    // Análise de humor médio
    final averageMood =
        last30Days.map((e) => e.moodLevel).reduce((a, b) => a + b) /
        last30Days.length;
    if (averageMood >= 7) {
      insights.add(
        'Seu humor tem estado consistentemente positivo! Continue assim! 😊',
      );
    } else if (averageMood <= 4) {
      insights.add(
        'Notei que você tem passado por momentos difíceis. Que tal experimentar algumas técnicas de respiração?',
      );
    }

    // Análise de gatilhos
    final triggers = await getMostFrequentTriggers();
    if (triggers.isNotEmpty) {
      final mostCommonTrigger = triggers.entries.reduce(
        (a, b) => a.value > b.value ? a : b,
      );
      insights.add(
        'O gatilho mais comum tem sido: ${mostCommonTrigger.key}. Vamos trabalhar estratégias para lidar melhor com isso.',
      );
    }

    // Análise de emoções
    final emotions = await getMostFrequentEmotions();
    if (emotions.isNotEmpty) {
      final negativeEmotions = emotions.entries
          .where(
            (e) => [
              'Ansiedade',
              'Irritação',
              'Fadiga',
              'Estresse',
              'Tristeza',
              'Frustração',
            ].contains(e.key),
          )
          .toList();

      if (negativeEmotions.isNotEmpty) {
        insights.add(
          'Percebi que você tem sentido muito: ${negativeEmotions.first.key}. Considere usar nossos exercícios de relaxamento.',
        );
      }
    }

    // Análise de streak
    final streak = await getCurrentStreak();
    if (streak >= 7) {
      insights.add(
        'Parabéns! Você está há $streak dias registrando suas emoções. O autoconhecimento é o primeiro passo! 🎉',
      );
    }

    return insights;
  }

  // Obter estatísticas gerais
  static Future<Map<String, dynamic>> getGeneralStats() async {
    final allEntries = await getAllMoodEntries();
    final streak = await getCurrentStreak();

    if (allEntries.isEmpty) {
      return {
        'totalEntries': 0,
        'currentStreak': 0,
        'averageMood': 0.0,
        'daysTracked': 0,
      };
    }

    final averageMood =
        allEntries.map((e) => e.moodLevel).reduce((a, b) => a + b) /
        allEntries.length;
    final uniqueDays = allEntries
        .map(
          (e) => '${e.timestamp.year}-${e.timestamp.month}-${e.timestamp.day}',
        )
        .toSet()
        .length;

    return {
      'totalEntries': allEntries.length,
      'currentStreak': streak,
      'averageMood': averageMood,
      'daysTracked': uniqueDays,
    };
  }

  // Limpar todos os dados do usuário atual (para testes ou reset)
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(await _getUserSpecificKey(_moodEntriesKey));
    await prefs.remove(await _getUserSpecificKey(_weeklyReflectionsKey));
    await prefs.remove(await _getUserSpecificKey(_streakKey));
    await prefs.remove(await _getUserSpecificKey(_lastEntryDateKey));
  }

  // Obter perguntas reflexivas da semana
  static List<String> getWeeklyReflectionQuestions() {
    return [
      'O que mais me estressou esta semana no trabalho?',
      'Quais estratégias de bem-estar funcionaram melhor para mim?',
      'Como foi minha relação com os clientes esta semana?',
      'O que aprendi sobre mim mesmo observando minhas emoções?',
      'Que mudança pequena posso fazer para melhorar minha experiência no trabalho?',
      'Por quais momentos positivos sou grato esta semana?',
      'Como posso cuidar melhor da minha saúde mental na próxima semana?',
    ];
  }

  // Obter sugestões baseadas no humor
  static List<String> getSuggestionsForMood(
    int moodLevel,
    List<String> emotions,
  ) {
    final suggestions = <String>[];

    if (moodLevel <= 3) {
      suggestions.add('Que tal fazer uma respiração 4-7-8 para se acalmar?');
      suggestions.add('Uma caminhada curta pode ajudar a melhorar seu humor');
      suggestions.add('Lembre-se: este sentimento é temporário');
    } else if (moodLevel <= 5) {
      suggestions.add('Experimente alguns exercícios de alongamento');
      suggestions.add('Uma técnica de respiração pode te ajudar a se centrar');
      suggestions.add('Que tal anotar três coisas pelas quais você é grato?');
    } else if (moodLevel >= 8) {
      suggestions.add('Que energia positiva! Aproveite este momento');
      suggestions.add('Compartilhe essa energia positiva com colegas');
      suggestions.add('Anote o que está funcionando bem para repetir');
    }

    // Sugestões baseadas em emoções específicas
    if (emotions.contains('Ansiedade')) {
      suggestions.add('A respiração quadrada é excelente para ansiedade');
    }
    if (emotions.contains('Fadiga')) {
      suggestions.add('Experimente a respiração energizante');
    }
    if (emotions.contains('Estresse')) {
      suggestions.add('Use nossa técnica anti-estresse express');
    }

    return suggestions;
  }
}
