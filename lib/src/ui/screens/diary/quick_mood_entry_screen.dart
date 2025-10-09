import 'package:flutter/material.dart';
import '../../../models/mood_entry.dart';
import '../../../services/mood_repository.dart';
import '../../../core/constants.dart';

class QuickMoodEntryScreen extends StatefulWidget {
  const QuickMoodEntryScreen({super.key});

  @override
  State<QuickMoodEntryScreen> createState() => _QuickMoodEntryScreenState();
}

class _QuickMoodEntryScreenState extends State<QuickMoodEntryScreen> {
  int _selectedMood = 5;
  final List<String> _selectedEmotions = [];
  String? _selectedTrigger;
  WorkContext? _workContext;
  final TextEditingController _notesController = TextEditingController();
  bool _isDetailed = false;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Como você está?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () => setState(() => _isDetailed = !_isDetailed),
            child: Text(
              _isDetailed ? 'Simples' : 'Detalhado',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.primary, AppColors.serenity],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Icon(Icons.mood, size: 48, color: Colors.white),
                  const SizedBox(height: 12),
                  Text(
                    _getMoodDescription(_selectedMood),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Registre suas emoções do momento',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Seletor de humor
                  _buildMoodSelector(),

                  const SizedBox(height: 24),

                  // Seleção de emoções
                  _buildEmotionsSection(),

                  const SizedBox(height: 24),

                  // Gatilhos (se detalhado)
                  if (_isDetailed) ...[
                    _buildTriggersSection(),
                    const SizedBox(height: 24),
                  ],

                  // Contexto de trabalho (se detalhado)
                  if (_isDetailed) ...[
                    _buildWorkContextSection(),
                    const SizedBox(height: 24),
                  ],

                  // Notas opcionais
                  _buildNotesSection(),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // Botão salvar
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveMoodEntry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7043),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Salvar Registro',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Qual seu nível de humor hoje?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2E2E),
            ),
          ),
          const SizedBox(height: 16),

          // Escala visual
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(10, (index) {
              final mood = index + 1;
              final isSelected = mood == _selectedMood;
              return GestureDetector(
                onTap: () => setState(() => _selectedMood = mood),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isSelected ? _getMoodColor(mood) : Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isSelected
                          ? _getMoodColor(mood)
                          : Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$mood',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 16),

          // Slider para seleção mais precisa
          Slider(
            value: _selectedMood.toDouble(),
            min: 1,
            max: 10,
            divisions: 9,
            activeColor: _getMoodColor(_selectedMood),
            onChanged: (value) => setState(() => _selectedMood = value.round()),
          ),

          // Labels dos extremos
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '😢 Muito mal',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                '😊 Excelente',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Que emoções você está sentindo?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2E2E),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Pode selecionar várias',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: MoodEmotions.values.map((emotion) {
              final isSelected = _selectedEmotions.contains(
                emotion.displayName,
              );
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(emotion.emoji),
                    const SizedBox(width: 4),
                    Text(emotion.displayName),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedEmotions.add(emotion.displayName);
                    } else {
                      _selectedEmotions.remove(emotion.displayName);
                    }
                  });
                },
                backgroundColor: Colors.grey[100],
                selectedColor: _getEmotionColor(emotion.category),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTriggersSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'O que influenciou seu humor?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2E2E),
            ),
          ),
          const SizedBox(height: 16),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: WorkTriggers.values.map((trigger) {
              final isSelected = _selectedTrigger == trigger.displayName;
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(trigger.emoji),
                    const SizedBox(width: 4),
                    Text(trigger.displayName),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedTrigger = selected ? trigger.displayName : null;
                  });
                },
                backgroundColor: Colors.grey[100],
                selectedColor: const Color(0xFFFF7043),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkContextSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contexto do trabalho',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2E2E),
            ),
          ),
          const SizedBox(height: 16),

          // Turno
          const Text('Turno:', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: WorkShift.values.map((shift) {
              final isSelected = _workContext?.shift == shift.value;
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(shift.emoji),
                    const SizedBox(width: 4),
                    Text(shift.displayName),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _workContext = WorkContext(
                        shift: shift.value,
                        customerVolume:
                            _workContext?.customerVolume ?? 'medium',
                        specialSituations:
                            _workContext?.specialSituations ?? [],
                      );
                    }
                  });
                },
                backgroundColor: Colors.grey[100],
                selectedColor: const Color(0xFF2196F3),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // Volume de clientes
          const Text(
            'Volume de clientes:',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: CustomerVolume.values.map((volume) {
              final isSelected = _workContext?.customerVolume == volume.value;
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(volume.emoji),
                    const SizedBox(width: 4),
                    Text(volume.displayName),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _workContext = WorkContext(
                        shift: _workContext?.shift ?? 'morning',
                        customerVolume: volume.value,
                        specialSituations:
                            _workContext?.specialSituations ?? [],
                      );
                    }
                  });
                },
                backgroundColor: Colors.grey[100],
                selectedColor: const Color(0xFF4CAF50),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Observações (opcional)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2E2E),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Conte mais sobre como você está se sentindo',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _notesController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText:
                  'Ex: Hoje foi um dia difícil por causa da fila grande, mas consegui manter a calma...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFFF7043)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getMoodDescription(int mood) {
    if (mood <= 2) return 'Muito Mal';
    if (mood <= 4) return 'Mal';
    if (mood <= 6) return 'Neutro';
    if (mood <= 8) return 'Bem';
    return 'Excelente';
  }

  Color _getMoodColor(int mood) {
    if (mood <= 3) return const Color(0xFFE53935);
    if (mood <= 5) return const Color(0xFFFF9800);
    if (mood <= 7) return const Color(0xFF4CAF50);
    return const Color(0xFF2E7D32);
  }

  Color _getEmotionColor(String category) {
    switch (category) {
      case 'positive':
        return const Color(0xFF4CAF50);
      case 'negative':
        return const Color(0xFFE53935);
      default:
        return const Color(0xFF2196F3);
    }
  }

  Future<void> _saveMoodEntry() async {
    if (_selectedEmotions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione pelo menos uma emoção'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final entry = MoodEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        moodLevel: _selectedMood,
        emotions: _selectedEmotions,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        trigger: _selectedTrigger,
        workContext: _workContext,
        entryType: _isDetailed ? 'detailed' : 'quick',
      );

      await MoodRepository.saveMoodEntry(entry);

      if (mounted) {
        // Mostrar sugestões baseadas no humor
        final suggestions = MoodRepository.getSuggestionsForMood(
          _selectedMood,
          _selectedEmotions,
        );
        if (suggestions.isNotEmpty) {
          _showSuggestions(suggestions);
        } else {
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao salvar registro'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _showSuggestions(List<String> suggestions) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.lightbulb, color: Color(0xFFFF7043)),
            SizedBox(width: 8),
            Text('Sugestões para Você'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Baseado no seu humor atual:'),
            const SizedBox(height: 12),
            ...suggestions
                .take(3)
                .map(
                  (suggestion) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.arrow_right, color: Color(0xFFFF7043)),
                        const SizedBox(width: 8),
                        Expanded(child: Text(suggestion)),
                      ],
                    ),
                  ),
                ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            child: const Text('Obrigado!'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}
