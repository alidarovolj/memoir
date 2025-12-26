import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';

/// Hide and Seek Game - Find the pet
class HideAndSeekGame extends StatefulWidget {
  const HideAndSeekGame({super.key});

  @override
  State<HideAndSeekGame> createState() => _HideAndSeekGameState();
}

class _HideAndSeekGameState extends State<HideAndSeekGame> with SingleTickerProviderStateMixin {
  int _score = 0;
  int _attempts = 3;
  int? _hidingSpot;
  bool _isRevealed = false;
  bool _gameStarted = false;
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _startRound() {
    setState(() {
      _hidingSpot = Random().nextInt(9);
      _isRevealed = false;
      _gameStarted = true;
    });
  }

  void _checkSpot(int index) {
    if (_isRevealed || _attempts <= 0) return;

    setState(() {
      _attempts--;
      if (index == _hidingSpot) {
        _score += 10;
        _isRevealed = true;
        _attempts = 3;
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) _startRound();
        });
      } else {
        _shakeController.forward(from: 0);
        if (_attempts <= 0) {
          _isRevealed = true;
          _endGame();
        }
      }
    });
  }

  void _endGame() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppTheme.surfaceColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('🎮 Игра окончена!', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Счёт: $_score',
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'XP: ${min(_score, 30)}',
                style: TextStyle(color: AppTheme.primaryColor, fontSize: 18),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, _score);
              },
              child: const Text('Готово'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _score = 0;
                  _attempts = 3;
                });
                _startRound();
              },
              child: const Text('Ещё раз'),
            ),
          ],
        ),
      );
    });
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
              child: CustomHeader(title: '🔍 Hide & Seek', type: HeaderType.pop),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Счёт: $_score', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Попытки: $_attempts', style: const TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),
          Expanded(
            child: !_gameStarted
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '🔍 Hide & Seek',
                          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            'Найдите питомца!\nУ вас 3 попытки',
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: _startRound,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                          ),
                          child: const Text('Начать игру', style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(32),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        final isHiding = index == _hidingSpot && _isRevealed;
                        return AnimatedBuilder(
                          animation: _shakeController,
                          builder: (context, child) {
                            final shake = sin(_shakeController.value * pi * 2) * 10;
                            return Transform.translate(
                              offset: Offset(shake, 0),
                              child: child,
                            );
                          },
                          child: GestureDetector(
                            onTap: () => _checkSpot(index),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(255, 255, 255, 0.2),
                                    Color.fromRGBO(242, 242, 242, 0),
                                  ],
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(44, 44, 44, 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    isHiding ? '🐱' : '📦',
                                    style: const TextStyle(fontSize: 48),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
