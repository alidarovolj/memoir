import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/daily_prompts/data/models/daily_prompt_model.dart';
import 'package:memoir/features/daily_prompts/data/datasources/daily_prompt_remote_datasource.dart';

/// Beautiful Daily Prompt Card with animations
class DailyPromptCard extends StatefulWidget {
  const DailyPromptCard({super.key});

  @override
  State<DailyPromptCard> createState() => _DailyPromptCardState();
}

class _DailyPromptCardState extends State<DailyPromptCard>
    with TickerProviderStateMixin {
  late DailyPromptRemoteDataSource _dataSource;
  DailyPromptModel? _prompt;
  bool _isLoading = true;
  bool _isAnswering = false;
  bool _isExpanded = false;

  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  final _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dataSource = DailyPromptRemoteDataSourceImpl(dio: DioClient.instance);

    // Scale animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutBack,
    );

    // Slide animation
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _loadPrompt();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _slideController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _loadPrompt() async {
    try {
      final prompt = await _dataSource.getPromptOfTheDay();
      setState(() {
        _prompt = prompt;
        _isLoading = false;
      });

      // Start animations
      _scaleController.forward();
      await Future.delayed(const Duration(milliseconds: 100));
      _slideController.forward();
    } catch (e) {
      setState(() => _isLoading = false);
      print('⚠️ Failed to load daily prompt: $e');
    }
  }

  Future<void> _submitAnswer() async {
    if (_answerController.text.trim().isEmpty || _prompt == null) return;

    setState(() => _isAnswering = true);

    try {
      final response = await _dataSource.answerPrompt(
        promptId: _prompt!.id,
        answer: _answerController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
            backgroundColor: AppTheme.primaryColor,
            behavior: SnackBarBehavior.floating,
          ),
        );

        // Collapse card and clear answer
        setState(() {
          _isExpanded = false;
          _answerController.clear();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isAnswering = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingCard();
    }

    if (_prompt == null) {
      return const SizedBox.shrink();
    }

    return ScaleTransition(
      scale: _scaleAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTap: () {
            setState(() => _isExpanded = !_isExpanded);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Color(_prompt!.gradientColors[0]),
                  Color(_prompt!.gradientColors[1]),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(_prompt!.gradientColors[0]).withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                  spreadRadius: -5,
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: [
                      // Emoji icon
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            _prompt!.promptIcon,
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Title and category
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Вопрос дня',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _prompt!.categoryName,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.95),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Expand icon
                      Icon(
                        _isExpanded
                            ? Ionicons.chevron_up
                            : Ionicons.chevron_down,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Prompt text
                  Text(
                    _prompt!.promptText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),

                  // Expanded content
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: _isExpanded
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),

                              // Answer field
                              TextField(
                                controller: _answerController,
                                style: const TextStyle(color: Colors.white),
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: 'Поделитесь вашими мыслями...',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Submit button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _isAnswering
                                      ? null
                                      : _submitAnswer,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Color(
                                      _prompt!.gradientColors[0],
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: _isAnswering
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Color(
                                                    _prompt!.gradientColors[0],
                                                  ),
                                                ),
                                          ),
                                        )
                                      : const Text(
                                          'Сохранить ответ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.grey.shade300, Colors.grey.shade200],
        ),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
