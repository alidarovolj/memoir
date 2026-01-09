import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:ionicons/ionicons.dart';

/// Feed Frenzy Game - Catch falling food
class FeedFrenzyGame extends StatefulWidget {
  const FeedFrenzyGame({super.key});

  @override
  State<FeedFrenzyGame> createState() => _FeedFrenzyGameState();
}

class _FeedFrenzyGameState extends State<FeedFrenzyGame> {
  int _score = 0;
  int _lives = 3;
  bool _isPlaying = false;
  Timer? _gameTimer;
  final List<FallingFood> _foods = [];
  final Random _random = Random();
  double _petPosition = 0.5;

  final List<String> _goodFood = ['🍖', '🥩', '🍗', '🥓', '🍔'];
  final List<String> _badFood = ['🥦', '🥒', '🌶️', '🧄', '🧅'];

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      _score = 0;
      _lives = 3;
      _isPlaying = true;
      _foods.clear();
    });

    _gameTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!_isPlaying) {
        timer.cancel();
        return;
      }

      setState(() {
        // Move foods down
        for (var food in _foods) {
          food.y += 0.01;
        }

        // Remove foods that went off screen
        _foods.removeWhere((food) => food.y > 1.0);

        // Add new food randomly
        if (_random.nextDouble() < 0.03) {
          final isGood = _random.nextBool();
          _foods.add(
            FallingFood(
              emoji: isGood
                  ? _goodFood[_random.nextInt(_goodFood.length)]
                  : _badFood[_random.nextInt(_badFood.length)],
              x: _random.nextDouble(),
              y: 0,
              isGood: isGood,
            ),
          );
        }

        // Check collisions
        _foods.removeWhere((food) {
          if (food.y > 0.85 && food.y < 0.95) {
            if ((food.x - _petPosition).abs() < 0.1) {
              if (food.isGood) {
                _score += 10;
              } else {
                _lives--;
                if (_lives <= 0) {
                  _endGame();
                }
              }
              return true;
            }
          }
          return false;
        });
      });
    });
  }

  void _endGame() {
    setState(() => _isPlaying = false);
    _gameTimer?.cancel();

    final foodCaught = (_score / 10).floor();
    final happinessGain = min(foodCaught * 5, 50);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          '🍖 Кормление завершено!',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Поймано еды: $foodCaught',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '😊 Счастье',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '+$happinessGain',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '💚 Здоровье',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '+${(foodCaught * 3).clamp(0, 30)}',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, {
                'foodCaught': foodCaught,
                'happiness': happinessGain,
              });
            },
            child: const Text('Готово'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startGame();
            },
            child: const Text('Ещё раз'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: Column(
        children: [
          Container(
            color: AppTheme.headerBackgroundColor,
            child: const SafeArea(
              bottom: false,
              child: CustomHeader(
                title: '🍖 Feed Frenzy',
                type: HeaderType.pop,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Счёт: $_score',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: List.generate(
                    3,
                    (index) => Icon(
                      index < _lives ? Ionicons.heart : Ionicons.heart_outline,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: !_isPlaying && _score == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '🍖 Покормите питомца',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            'Ловите еду 🍖 чтобы покормить питомца\nИзбегайте плохую еду 🥦',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: _startGame,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 16,
                            ),
                          ),
                          child: const Text(
                            'Начать игру',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  )
                : GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        _petPosition +=
                            details.delta.dx /
                            MediaQuery.of(context).size.width;
                        _petPosition = _petPosition.clamp(0.1, 0.9);
                      });
                    },
                    child: Stack(
                      children: [
                        // Falling foods
                        ..._foods.map(
                          (food) => Positioned(
                            left:
                                food.x * MediaQuery.of(context).size.width - 20,
                            top:
                                food.y *
                                MediaQuery.of(context).size.height *
                                0.8,
                            child: Text(
                              food.emoji,
                              style: const TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                        // Pet
                        Positioned(
                          left:
                              _petPosition * MediaQuery.of(context).size.width -
                              30,
                          bottom: 20,
                          child: const Text(
                            '🐱',
                            style: TextStyle(fontSize: 60),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class FallingFood {
  final String emoji;
  final double x;
  double y;
  final bool isGood;

  FallingFood({
    required this.emoji,
    required this.x,
    required this.y,
    required this.isGood,
  });
}
