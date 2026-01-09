import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';

/// Memory Match Game - Match pairs
class MemoryMatchGame extends StatefulWidget {
  const MemoryMatchGame({super.key});

  @override
  State<MemoryMatchGame> createState() => _MemoryMatchGameState();
}

class _MemoryMatchGameState extends State<MemoryMatchGame> {
  int _score = 0;
  int _moves = 0;
  bool _gameStarted = false;
  List<String> _cards = [];
  List<bool> _revealed = [];
  List<bool> _matched = [];
  int? _firstCard;
  int? _secondCard;
  bool _isChecking = false;

  final List<String> _emojis = ['🐱', '🐶', '🦊', '🐼', '🦄', '🐰', '🦉', '🐉'];

  void _initGame() {
    setState(() {
      _cards = [..._emojis, ..._emojis]..shuffle(Random());
      _revealed = List.filled(16, false);
      _matched = List.filled(16, false);
      _firstCard = null;
      _secondCard = null;
      _score = 0;
      _moves = 0;
      _gameStarted = true;
    });
  }

  void _onCardTap(int index) {
    if (_isChecking || _revealed[index] || _matched[index]) return;

    setState(() {
      _revealed[index] = true;

      if (_firstCard == null) {
        _firstCard = index;
      } else if (_secondCard == null) {
        _secondCard = index;
        _moves++;
        _checkMatch();
      }
    });
  }

  void _checkMatch() {
    _isChecking = true;

    Timer(const Duration(milliseconds: 1000), () {
      if (_cards[_firstCard!] == _cards[_secondCard!]) {
        setState(() {
          _matched[_firstCard!] = true;
          _matched[_secondCard!] = true;
          _score += 5;
        });

        // Check if game is won
        if (_matched.every((m) => m)) {
          _endGame();
        }
      } else {
        setState(() {
          _revealed[_firstCard!] = false;
          _revealed[_secondCard!] = false;
        });
      }

      setState(() {
        _firstCard = null;
        _secondCard = null;
        _isChecking = false;
      });
    });
  }

  void _endGame() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppTheme.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            '🎉 Победа!',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Счёт: $_score',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Ходов: $_moves',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'XP: ${min(_score, 40)}',
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
                _initGame();
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
              child: CustomHeader(
                title: '🧠 Memory Match',
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
                Text(
                  'Ходы: $_moves',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
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
                          '🧠 Memory Match',
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
                            'Найдите все пары!\nЗапоминайте карточки',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: _initGame,
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
                : Center(
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemCount: 16,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => _onCardTap(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: _matched[index]
                                ? LinearGradient(
                                    colors: [
                                      AppTheme.primaryColor.withOpacity(0.5),
                                      AppTheme.primaryColor.withOpacity(0.2),
                                    ],
                                  )
                                : const LinearGradient(
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
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Center(
                              child: Text(
                                _revealed[index] || _matched[index]
                                    ? _cards[index]
                                    : '❓',
                                style: const TextStyle(fontSize: 32),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
