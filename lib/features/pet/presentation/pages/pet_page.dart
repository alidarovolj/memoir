import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/features/pet/data/datasources/pet_remote_datasource.dart';
import 'package:memoir/features/pet/data/models/pet_model.dart';
import 'package:memoir/core/network/dio_client.dart';
// Pet 2.0 pages
import 'package:memoir/features/pet/presentation/pages/pet_games_page.dart';
import 'package:memoir/features/pet/presentation/pages/pet_shop_page.dart';
import 'package:memoir/features/pet/presentation/pages/pet_village_page.dart';
import 'package:memoir/features/pet/presentation/pages/pet_journal_page.dart';
import 'package:memoir/features/pet/presentation/pages/games/feed_frenzy_game.dart';
import 'package:memoir/features/pet/presentation/widgets/pet_particle_effect.dart';
import 'package:memoir/features/pet/presentation/widgets/animated_pet_sprite.dart';

/// Full-screen pet interaction page
class PetPage extends StatefulWidget {
  final PetModel initialPet;

  const PetPage({super.key, required this.initialPet});

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> with TickerProviderStateMixin {
  late PetModel _pet;
  late PetRemoteDataSource _petDataSource;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;
  late AnimationController _rotationController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _pet = widget.initialPet;
    _petDataSource = PetRemoteDataSourceImpl(dio: DioClient.instance);

    // Bounce animation for pet emoji
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );

    // Rotation animation for 3D effect
    _rotationController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  Future<void> _feedPet() async {
    // Launch Feed Frenzy game for feeding
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FeedFrenzyGame()),
    );

    if (result != null && result is Map<String, dynamic>) {
      final foodCaught = result['foodCaught'] as int;
      final happinessGain = result['happiness'] as int;

      setState(() => _isLoading = true);

      try {
        // Call backend feed API
        final apiResult = await _petDataSource.feedPet();

        if (mounted) {
          setState(() {
            _pet = apiResult.pet.copyWith(
              happiness: (_pet.happiness + happinessGain).clamp(0, 100),
              health: (_pet.health + (foodCaught * 3).clamp(0, 30)).clamp(
                0,
                100,
              ),
            );
            _isLoading = false;
          });

          SnackBarUtils.showSuccess(
            context,
            '🍖 Питомец покормлен! Поймано еды: $foodCaught',
          );

          // Show celebration if leveled up or evolved
          if (apiResult.levelUps > 0 || apiResult.evolved) {
            _showCelebration(apiResult);
          }
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            // Still apply game results even if API fails
            _pet = _pet.copyWith(
              happiness: (_pet.happiness + happinessGain).clamp(0, 100),
              health: (_pet.health + (foodCaught * 3).clamp(0, 30)).clamp(
                0,
                100,
              ),
            );
            _isLoading = false;
          });
          SnackBarUtils.showSuccess(
            context,
            '🍖 Покормлено! Поймано еды: $foodCaught',
          );
        }
      }
    }
  }

  Future<void> _playWithPet() async {
    // Launch games selection page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PetGamesPage()),
    );
  }

  void _showCelebration(PetActionResponse result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            Text(
              result.evolved ? '✨ Эволюция!' : '🎉 Новый уровень!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(_pet.petTypeEmoji, style: const TextStyle(fontSize: 80)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (result.evolved)
              Text(
                '${_pet.name} эволюционировал в ${_pet.evolutionStage.name}!',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              )
            else
              Text(
                '${_pet.name} достиг ${_pet.level} уровня!',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16),
            if (_pet.nextMilestone != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _pet.nextMilestone!,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Продолжить'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateName() async {
    final controller = TextEditingController(text: _pet.name);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Переименовать питомца',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Новое имя',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          maxLength: 50,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              final newName = controller.text.trim();
              if (newName.isEmpty) {
                SnackBarUtils.showWarning(context, 'Имя не может быть пустым');
                return;
              }

              Navigator.pop(context);

              try {
                final updatedPet = await _petDataSource.updatePetName(newName);
                setState(() => _pet = updatedPet);
                SnackBarUtils.showSuccess(context, 'Имя изменено на $newName');
              } catch (e) {
                SnackBarUtils.showError(context, 'Не удалось изменить имя');
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
        ),
        child: Column(
          children: [
            // SafeArea с хедером
            Container(
              color: AppTheme.headerBackgroundColor,
              child: SafeArea(
                bottom: false,
                child: CustomHeader(
                  title: _pet.name,
                  type: HeaderType.pop,
                  trailing: IconButton(
                    icon: const Icon(Ionicons.create_outline),
                    color: Colors.white,
                    onPressed: _updateName,
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Pet display (animated sprite)
                    PetParticleEffect(
                      isActive: _pet.happiness >= 80,
                      particleColor: _pet.isShiny
                          ? Colors.amber
                          : AppTheme.primaryColor,
                      child: AnimatedBuilder(
                        animation: _bounceAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, -_bounceAnimation.value),
                            child: child,
                          );
                        },
                        child: AnimatedPetSprite(
                          emotion: _pet.currentEmotion ?? 'happy',
                          size: 120,
                          isShiny: _pet.isShiny,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 3D Model section
                    // _build3DModelSection(),

                    // const SizedBox(height: 24),

                    // Level and XP
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Уровень ${_pet.level}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _pet.evolutionStage.name.toUpperCase(),
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: _pet.xpPercentage,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.yellow,
                              ),
                              minHeight: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${_pet.xp} / ${_pet.xpForNextLevel} XP',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                          if (_pet.nextMilestone != null) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Ionicons.information_circle_outline,
                                    color: AppTheme.primaryColor,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _pet.nextMilestone!,
                                      style: const TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Stats
                    _buildStatCard(
                      icon: Ionicons.heart,
                      label: 'Счастье',
                      value: _pet.happiness,
                      color: Colors.pink,
                      emoji: _pet.happinessEmoji,
                    ),
                    const SizedBox(height: 12),
                    _buildStatCard(
                      icon: Ionicons.fitness,
                      label: 'Здоровье',
                      value: _pet.health,
                      color: Colors.green,
                      emoji: _pet.healthEmoji,
                    ),

                    const SizedBox(height: 24),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            icon: Ionicons.restaurant,
                            label: 'Покормить',
                            gradient: const LinearGradient(
                              colors: [Colors.pink, Colors.orange],
                            ),
                            onPressed: _isLoading ? null : _feedPet,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildActionButton(
                            icon: Ionicons.football,
                            label: 'Поиграть',
                            gradient: const LinearGradient(
                              colors: [Colors.green, Colors.teal],
                            ),
                            onPressed: _isLoading ? null : _playWithPet,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Info card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Ionicons.information_circle,
                                color: AppTheme.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Как растить питомца',
                                style: const TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            '🍔 Создавайте воспоминания, чтобы кормить питомца',
                          ),
                          _buildInfoRow(
                            '🎾 Выполняйте задачи, чтобы играть с питомцем',
                          ),
                          _buildInfoRow(
                            '🔥 Поддерживайте streak для здоровья питомца',
                          ),
                          _buildInfoRow(
                            '⭐ Питомец эволюционирует на уровнях 5, 15, 30',
                          ),
                          const SizedBox(height: 16),
                          const Divider(color: Colors.white24),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(
                                Ionicons.star,
                                color: AppTheme.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Как заработать XP',
                                style: const TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow('📝 Создавайте воспоминания (+XP)'),
                          _buildInfoRow('✅ Выполняйте задачи (+XP)'),
                          _buildInfoRow('🔥 Поддерживайте стрики (+XP)'),
                          _buildInfoRow('🎮 Играйте в мини-игры (до 40 XP)'),
                          _buildInfoRow('🍖 Кормите питомца через Feed Frenzy'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Pet 2.0 Features Navigation
                    _buildFeatureButtons(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required int value,
    required Color color,
    required String emoji,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(emoji, style: const TextStyle(fontSize: 24)),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: value / 100,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$value / 100',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Gradient gradient,
    required VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: onPressed == null
              ? const LinearGradient(colors: [Colors.grey, Colors.grey])
              : gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: onPressed == null
              ? null
              : [
                  BoxShadow(
                    color: gradient.colors.first.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontSize: 13,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildFeatureButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildFeatureButton(
                icon: Ionicons.game_controller,
                label: 'Мини-игры',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PetGamesPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildFeatureButton(
                icon: Ionicons.storefront,
                label: 'Магазин',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetShopPage(currentXp: _pet.xp),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildFeatureButton(
                icon: Ionicons.people,
                label: 'Village',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PetVillagePage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildFeatureButton(
                icon: Ionicons.book,
                label: 'Журнал',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PetJournalPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryColor.withOpacity(0.3),
              AppTheme.primaryColor.withOpacity(0.1),
            ],
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeechBubble(String text) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _getEmotionEmoji(_pet.currentEmotion),
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  String _getEmotionEmoji(String? emotion) {
    switch (emotion) {
      case 'happy':
        return '😊';
      case 'sad':
        return '😢';
      case 'sleepy':
        return '😴';
      case 'excited':
        return '🤩';
      case 'loving':
        return '😍';
      case 'celebrating':
        return '🥳';
      case 'thinking':
        return '🤔';
      case 'cool':
        return '😎';
      default:
        return '😊';
    }
  }

  Widget _build3DModelSection() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(255, 255, 255, 0.2),
            Color.fromRGBO(233, 233, 233, 0.2),
            Color.fromRGBO(242, 242, 242, 0),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(44, 44, 44, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              // Создаем 3D эффект с вращением
              final angle = _rotationController.value * 2 * math.pi;
              final scale = 1.0 + math.sin(angle) * 0.1; // Пульсация

              return Stack(
                children: [
                  // Фоновые круги для глубины
                  Positioned.fill(
                    child: CustomPaint(painter: _CirclesPainter(angle)),
                  ),

                  // Основной питомец с 3D эффектом
                  Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // Перспектива
                        ..rotateY(angle)
                        ..scale(scale),
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: _pet.isShiny
                                ? [
                                    Colors.amber.withOpacity(0.5),
                                    Colors.purple.withOpacity(0.3),
                                    AppTheme.primaryColor.withOpacity(0.1),
                                    Colors.transparent,
                                  ]
                                : [
                                    AppTheme.primaryColor.withOpacity(0.3),
                                    AppTheme.primaryColor.withOpacity(0.1),
                                    Colors.transparent,
                                  ],
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Shiny sparkles effect
                            if (_pet.isShiny)
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: _SparklesPainter(angle),
                                ),
                              ),

                            // Pet emoji
                            Text(
                              _pet.petTypeEmoji,
                              style: const TextStyle(fontSize: 100),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Shiny badge
                  if (_pet.isShiny)
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.amber.withOpacity(0.9),
                              Colors.purple.withOpacity(0.9),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('✨', style: TextStyle(fontSize: 14)),
                            const SizedBox(width: 4),
                            Text(
                              'SHINY',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Speech Bubble
                  if (_pet.speechBubble != null &&
                      _pet.speechBubble!.isNotEmpty)
                    Positioned(
                      top: 40,
                      left: 20,
                      right: 20,
                      child: _buildSpeechBubble(_pet.speechBubble!),
                    ),

                  // Подсказка снизу
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Ionicons.hand_left_outline,
                              color: Colors.white.withOpacity(0.6),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Питомец автоматически вращается',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Custom painter для фоновых кругов
class _CirclesPainter extends CustomPainter {
  final double angle;

  _CirclesPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final center = Offset(size.width / 2, size.height / 2);

    // Рисуем вращающиеся круги
    for (int i = 1; i <= 3; i++) {
      final radius = (size.width / 6) * i;
      final opacity = 0.1 - (i * 0.02);
      paint.color = Colors.white.withOpacity(opacity);

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle * i * 0.5);
      canvas.translate(-center.dx, -center.dy);

      canvas.drawCircle(center, radius, paint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_CirclesPainter oldDelegate) => angle != oldDelegate.angle;
}

/// Custom painter для sparkles эффекта (shiny pets)
class _SparklesPainter extends CustomPainter {
  final double angle;

  _SparklesPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.5;

    // Рисуем блестки вокруг питомца
    for (int i = 0; i < 8; i++) {
      final sparkleAngle = (angle + (i * math.pi / 4)) % (2 * math.pi);
      final sparkleX = center.dx + radius * math.cos(sparkleAngle);
      final sparkleY = center.dy + radius * math.sin(sparkleAngle);

      // Чередуем цвета блесток
      paint.color = i % 2 == 0
          ? Colors.amber.withOpacity(0.6)
          : Colors.purple.withOpacity(0.6);

      // Рисуем маленькие звездочки
      final sparklePath = Path();
      final sparkleSize = 4.0 + math.sin(angle * 3 + i) * 2;

      sparklePath.moveTo(sparkleX, sparkleY - sparkleSize);
      sparklePath.lineTo(sparkleX + sparkleSize / 2, sparkleY);
      sparklePath.lineTo(sparkleX, sparkleY + sparkleSize);
      sparklePath.lineTo(sparkleX - sparkleSize / 2, sparkleY);
      sparklePath.close();

      canvas.drawPath(sparklePath, paint);
    }
  }

  @override
  bool shouldRepaint(_SparklesPainter oldDelegate) =>
      angle != oldDelegate.angle;
}
