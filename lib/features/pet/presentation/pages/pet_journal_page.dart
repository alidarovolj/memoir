import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';

class PetJournalPage extends StatefulWidget {
  const PetJournalPage({super.key});

  @override
  State<PetJournalPage> createState() => _PetJournalPageState();
}

class _PetJournalPageState extends State<PetJournalPage> {
  bool _isLoading = true;
  List<JournalEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadJournal();
  }

  Future<void> _loadJournal() async {
    // TODO: Load from API
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _entries = [
        JournalEntry(
          type: 'evolution',
          title: 'Эволюция в Легенду! 🎉',
          description:
              'Ваш питомец достиг высшей стадии эволюции! Теперь это настоящая легенда.',
          level: 30,
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        JournalEntry(
          type: 'milestone',
          title: 'Первые 100 XP! ⭐',
          description:
              'Поздравляем! Вы заработали свои первые 100 очков опыта.',
          level: 8,
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
        JournalEntry(
          type: 'achievement',
          title: 'Победа в 10 играх 🏆',
          description:
              'Вы выиграли 10 мини-игр подряд! Невероятное достижение.',
          level: 12,
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
        ),
        JournalEntry(
          type: 'photo',
          title: 'Первое фото с питомцем 📸',
          description:
              'Вы сделали первую памятную фотографию со своим питомцем.',
          level: 5,
          timestamp: DateTime.now().subtract(const Duration(days: 5)),
        ),
        JournalEntry(
          type: 'evolution',
          title: 'Эволюция во Взрослого! 🌟',
          description:
              'Ваш питомец вырос и стал взрослым. Новые возможности разблокированы.',
          level: 15,
          timestamp: DateTime.now().subtract(const Duration(days: 7)),
        ),
        JournalEntry(
          type: 'milestone',
          title: '7 дней подряд! 🔥',
          description:
              'Вы поддерживали активность 7 дней подряд. Продолжайте в том же духе!',
          level: 10,
          timestamp: DateTime.now().subtract(const Duration(days: 10)),
        ),
        JournalEntry(
          type: 'achievement',
          title: 'Первый визит в Village 🏘️',
          description:
              'Вы впервые посетили Pet Village и познакомились с другими питомцами.',
          level: 6,
          timestamp: DateTime.now().subtract(const Duration(days: 12)),
        ),
        JournalEntry(
          type: 'evolution',
          title: 'Эволюция в Ребёнка! 🌱',
          description:
              'Ваш питомец повзрослел и перешёл на следующую стадию развития.',
          level: 5,
          timestamp: DateTime.now().subtract(const Duration(days: 14)),
        ),
        JournalEntry(
          type: 'photo',
          title: 'Рождение питомца 🥚',
          description:
              'Ваше удивительное путешествие началось! Питомец вылупился из яйца.',
          level: 1,
          timestamp: DateTime.now().subtract(const Duration(days: 20)),
        ),
      ];
      _isLoading = false;
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
                title: '📖 Pet Journal',
                type: HeaderType.pop,
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _entries.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('📖', style: TextStyle(fontSize: 64)),
                        const SizedBox(height: 16),
                        const Text(
                          'Журнал пуст',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'История вашего питомца\nпоявится здесь',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _entries.length,
                    itemBuilder: (context, index) =>
                        _buildTimelineItem(_entries[index], index),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Ionicons.add),
      ),
    );
  }

  Widget _buildTimelineItem(JournalEntry entry, int index) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getEntryColor(entry.type),
                  boxShadow: [
                    BoxShadow(
                      color: _getEntryColor(entry.type).withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _getEntryIcon(entry.type),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              if (index < _entries.length - 1)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          _getEntryColor(entry.type),
                          _getEntryColor(entry.type).withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
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
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              entry.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (entry.level != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Lvl ${entry.level}',
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (entry.description != null)
                        Text(
                          entry.description!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat(
                          'dd MMM yyyy, HH:mm',
                        ).format(entry.timestamp),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 12,
                        ),
                      ),
                      if (entry.imageUrl != null) ...[
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            entry.imageUrl!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getEntryColor(String type) {
    switch (type) {
      case 'evolution':
        return Colors.purple;
      case 'milestone':
        return Colors.orange;
      case 'photo':
        return Colors.blue;
      case 'achievement':
        return Colors.green;
      default:
        return AppTheme.primaryColor;
    }
  }

  String _getEntryIcon(String type) {
    switch (type) {
      case 'evolution':
        return '✨';
      case 'milestone':
        return '🎯';
      case 'photo':
        return '📸';
      case 'achievement':
        return '🏆';
      default:
        return '📝';
    }
  }

  void _addEntry() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Новая запись',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Заголовок',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Описание',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Save entry
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}

class JournalEntry {
  final String type;
  final String title;
  final String? description;
  final String? imageUrl;
  final int? level;
  final DateTime timestamp;

  JournalEntry({
    required this.type,
    required this.title,
    this.description,
    this.imageUrl,
    this.level,
    required this.timestamp,
  });
}
