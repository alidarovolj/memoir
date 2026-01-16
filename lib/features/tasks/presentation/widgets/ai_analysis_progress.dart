import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';

class AIAnalysisProgress extends StatefulWidget {
  final VoidCallback? onComplete;

  const AIAnalysisProgress({super.key, this.onComplete});

  @override
  State<AIAnalysisProgress> createState() => _AIAnalysisProgressState();
}

class _AIAnalysisProgressState extends State<AIAnalysisProgress> {
  int _currentStep = 0;

  final List<AIAnalysisStep> _steps = [
    AIAnalysisStep(title: 'Анализ контекста', icon: Ionicons.text_outline),
    AIAnalysisStep(
      title: 'Определение приоритета',
      icon: Ionicons.flag_outline,
    ),
    AIAnalysisStep(title: 'Временной масштаб', icon: Ionicons.time_outline),
    AIAnalysisStep(
      title: 'Выбор оформления',
      icon: Ionicons.color_palette_outline,
    ),
    AIAnalysisStep(
      title: 'Проверка повторяемости',
      icon: Ionicons.repeat_outline,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAnalysis();
  }

  Future<void> _startAnalysis() async {
    // Просто показываем анимацию прогресса
    // Не вызываем onComplete автоматически
    for (int i = 0; i < _steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        setState(() {
          _currentStep = i + 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Progress steps
        ...List.generate(_steps.length, (index) {
          final step = _steps[index];
          final isCompleted = index < _currentStep;
          final isActive = index == _currentStep - 1;
          final isVisible = index <= _currentStep;

          return AnimatedSlide(
            duration: Duration(milliseconds: 300 + (index * 30)),
            curve: Curves.easeOutCubic,
            offset: isVisible ? Offset.zero : const Offset(-0.2, 0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300 + (index * 30)),
              opacity: isVisible ? 1.0 : 0.0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: _buildStepItem(
                  step: step,
                  isCompleted: isCompleted,
                  isActive: isActive,
                  index: index,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildStepItem({
    required AIAnalysisStep step,
    required bool isCompleted,
    required bool isActive,
    required int index,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isCompleted || isActive ? 1.0 : 0.4,
      child: Row(
        children: [
          // Icon or checkmark
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppTheme.primaryColor
                  : isActive
                  ? AppTheme.primaryColor.withOpacity(0.2)
                  : AppTheme.lightGrayColor,
              shape: BoxShape.circle,
            ),
            child: isCompleted
                ? const Icon(Ionicons.checkmark, color: AppTheme.whiteColor, size: 16)
                : isActive
                ? Padding(
                    padding: const EdgeInsets.all(6),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.primaryColor,
                      ),
                    ),
                  )
                : Icon(
                    step.icon,
                    color: AppTheme.darkColor.withOpacity(0.3),
                    size: 14,
                  ),
          ),

          const SizedBox(width: 12),

          // Text
          Expanded(
            child: Text(
              step.title,
              style: TextStyle(
                color: isActive || isCompleted
                    ? AppTheme.darkColor
                    : AppTheme.darkColor.withOpacity(0.5),
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AIAnalysisStep {
  final String title;
  final IconData icon;

  AIAnalysisStep({required this.title, required this.icon});
}
