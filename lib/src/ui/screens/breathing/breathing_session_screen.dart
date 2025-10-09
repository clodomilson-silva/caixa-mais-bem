import 'package:flutter/material.dart';
import 'dart:async';
import '../../../models/breathing_technique.dart';

class BreathingSessionScreen extends StatefulWidget {
  final BreathingTechnique technique;

  const BreathingSessionScreen({super.key, required this.technique});

  @override
  State<BreathingSessionScreen> createState() => _BreathingSessionScreenState();
}

class _BreathingSessionScreenState extends State<BreathingSessionScreen>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late AnimationController _progressController;
  late Animation<double> _breathingAnimation;
  late Animation<double> _progressAnimation;

  Timer? _sessionTimer;
  Timer? _stepTimer;

  int _currentStepIndex = 0;
  int _currentCycle = 0;
  int _totalCycles = 0;
  int _remainingSeconds = 0;
  bool _isSessionActive = false;
  bool _isPaused = false;
  String _currentInstruction = '';

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _calculateTotalCycles();
    _setupSession();
  }

  void _setupAnimations() {
    _breathingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: Duration(minutes: widget.technique.durationMinutes),
      vsync: this,
    );

    _breathingAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut),
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_progressController);
  }

  void _calculateTotalCycles() {
    final cycleDuration = widget.technique.steps
        .map((step) => step.durationSeconds)
        .reduce((a, b) => a + b);
    _totalCycles = (widget.technique.durationMinutes * 60) ~/ cycleDuration;
  }

  void _setupSession() {
    _remainingSeconds = widget.technique.durationMinutes * 60;
    _currentInstruction = widget.technique.steps.first.instruction;
  }

  void _startSession() {
    setState(() {
      _isSessionActive = true;
      _isPaused = false;
    });

    _progressController.forward();
    _startSessionTimer();
    _executeCurrentStep();
  }

  void _pauseSession() {
    setState(() {
      _isPaused = true;
    });

    _sessionTimer?.cancel();
    _stepTimer?.cancel();
    _breathingController.stop();
    _progressController.stop();
  }

  void _resumeSession() {
    setState(() {
      _isPaused = false;
    });

    _progressController.forward();
    _startSessionTimer();
    _executeCurrentStep();
  }

  void _stopSession() {
    _sessionTimer?.cancel();
    _stepTimer?.cancel();
    _breathingController.stop();
    _progressController.stop();

    setState(() {
      _isSessionActive = false;
      _isPaused = false;
      _currentStepIndex = 0;
      _currentCycle = 0;
      _remainingSeconds = widget.technique.durationMinutes * 60;
      _currentInstruction = widget.technique.steps.first.instruction;
    });
  }

  void _startSessionTimer() {
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _completeSession();
      }
    });
  }

  void _executeCurrentStep() {
    final currentStep = widget.technique.steps[_currentStepIndex];

    setState(() {
      _currentInstruction = currentStep.instruction;
    });

    // Animação baseada no tipo de passo
    _animateStep(currentStep);

    // Timer para o próximo passo
    _stepTimer = Timer(Duration(seconds: currentStep.durationSeconds), () {
      _nextStep();
    });
  }

  void _animateStep(BreathingStep step) {
    switch (step.type) {
      case 'inspirar':
        _breathingController.duration = Duration(seconds: step.durationSeconds);
        _breathingController.forward();
        break;
      case 'expirar':
        _breathingController.duration = Duration(seconds: step.durationSeconds);
        _breathingController.reverse();
        break;
      case 'segurar':
      case 'pausa':
        _breathingController.stop();
        break;
    }
  }

  void _nextStep() {
    if (_currentStepIndex < widget.technique.steps.length - 1) {
      setState(() {
        _currentStepIndex++;
      });
    } else {
      setState(() {
        _currentStepIndex = 0;
        _currentCycle++;
      });
    }

    if (!_isPaused && _remainingSeconds > 0) {
      _executeCurrentStep();
    }
  }

  void _completeSession() {
    _sessionTimer?.cancel();
    _stepTimer?.cancel();
    _breathingController.stop();

    setState(() {
      _isSessionActive = false;
    });

    _showCompletionDialog();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 28),
            SizedBox(width: 8),
            Text('Sessão Concluída!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Parabéns! Você completou ${widget.technique.durationMinutes} minutos de ${widget.technique.name}.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Como você se sente agora?',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Finalizar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _setupSession();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
            ),
            child: const Text('Repetir'),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    _stepTimer?.cancel();
    _breathingController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: Text(
          widget.technique.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (_isSessionActive && !_isPaused)
            IconButton(onPressed: _pauseSession, icon: const Icon(Icons.pause)),
          if (_isSessionActive && _isPaused)
            IconButton(
              onPressed: _resumeSession,
              icon: const Icon(Icons.play_arrow),
            ),
          if (_isSessionActive)
            IconButton(onPressed: _stopSession, icon: const Icon(Icons.stop)),
        ],
      ),
      body: Column(
        children: [
          // Progresso da sessão
          if (_isSessionActive) ...[
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ciclo ${_currentCycle + 1}/$_totalCycles',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _formatTime(_remainingSeconds),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: _progressAnimation.value,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF4CAF50),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],

          // Círculo de respiração
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Círculo animado
                  AnimatedBuilder(
                    animation: _breathingAnimation,
                    builder: (context, child) {
                      return Container(
                        width: 200 * _breathingAnimation.value,
                        height: 200 * _breathingAnimation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4CAF50).withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(Icons.air, color: Colors.white, size: 60),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // Instrução atual
                  Text(
                    _currentInstruction,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  // Indicador do tipo de respiração
                  if (_isSessionActive) ...[
                    Text(
                      _getStepTypeDisplay(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Botões de controle
          if (!_isSessionActive) ...[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Informações da técnica
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.technique.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Duração: ${widget.technique.durationMinutes} minutos',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Botão iniciar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _startSession,
                      icon: const Icon(Icons.play_arrow, size: 24),
                      label: const Text(
                        'Iniciar Sessão',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getStepTypeDisplay() {
    final stepType = widget.technique.steps[_currentStepIndex].type;
    switch (stepType) {
      case 'inspirar':
        return 'Inspirando...';
      case 'expirar':
        return 'Expirando...';
      case 'segurar':
        return 'Segurando...';
      case 'pausa':
        return 'Pausando...';
      default:
        return '';
    }
  }
}
