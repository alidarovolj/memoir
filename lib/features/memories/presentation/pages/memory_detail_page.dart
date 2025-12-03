import 'package:flutter/material.dart';
import 'package:memoir/core/core.dart';
import 'package:memoir/features/memories/data/datasources/memory_remote_datasource.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/features/memories/presentation/pages/edit_memory_page.dart';

class MemoryDetailPage extends StatefulWidget {
  final String memoryId;

  const MemoryDetailPage({
    super.key,
    required this.memoryId,
  });

  @override
  State<MemoryDetailPage> createState() => _MemoryDetailPageState();
}

class _MemoryDetailPageState extends State<MemoryDetailPage> {
  late final MemoryRemoteDataSource _memoryDataSource;
  Map<String, dynamic>? _memory;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _memoryDataSource = MemoryRemoteDataSourceImpl(dio: DioClient.instance);
    _loadMemory();
  }

  Future<void> _loadMemory() async {
    setState(() => _isLoading = true);

    try {
      final memory = await _memoryDataSource.getMemory(widget.memoryId);
      if (mounted) {
        setState(() {
          _memory = memory;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        SnackBarUtils.showError(
          context,
          ErrorMessages.getErrorMessage(e),
        );
        Navigator.pop(context);
      }
    }
  }

  Future<void> _editMemory() async {
    if (_memory == null) return;

    final result = await Navigator.of(context).push(
      PageTransitions.slideFromRight(
        EditMemoryPage(memory: _memory!),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      print('📝 [DETAIL] Received updated data, refreshing...');
      try {
        await _memoryDataSource.updateMemory(widget.memoryId, result);
        await _loadMemory();
        SnackBarUtils.showSuccess(
          context,
          '✅ Воспоминание обновлено!',
        );
      } catch (e) {
        print('❌ [DETAIL] Error updating: $e');
        final message = ErrorMessages.getErrorMessage(e);
        SnackBarUtils.showError(context, 'Не удалось обновить: $message');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Ionicons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (!_isLoading && _memory != null) ...[
            IconButton(
              icon: const Icon(Ionicons.create_outline),
              onPressed: _editMemory,
              tooltip: 'Редактировать',
            ),
            IconButton(
              icon: const Icon(Ionicons.trash_outline),
              onPressed: () => _showDeleteConfirmation(),
              color: Colors.red.shade400,
            ),
          ],
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingState(message: 'Загрузка воспоминания...');
    }

    if (_memory == null) {
      return const EmptyState(
        icon: Ionicons.alert_circle_outline,
        title: 'Воспоминание не найдено',
        subtitle: 'Возможно, оно было удалено',
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final createdAt = _memory!['created_at'] != null
        ? DateTime.parse(_memory!['created_at'])
        : DateTime.now();
    final updatedAt = _memory!['updated_at'] != null
        ? DateTime.parse(_memory!['updated_at'])
        : null;

    // AI data
    final aiConfidence = _memory!['ai_confidence'] != null
        ? (_memory!['ai_confidence'] as num).toDouble()
        : null;
    final tags = _memory!['tags'] != null
        ? List<String>.from(_memory!['tags'])
        : <String>[];
    final extraMetadata = _memory!['extra_metadata'] as Map<String, dynamic>?;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category and AI confidence
          Row(
            children: [
              if (_memory!['category_name'] != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Ionicons.apps,
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _memory!['category_name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
              ],
              if (aiConfidence != null && aiConfidence > 0) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _getConfidenceGradient(aiConfidence),
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Ionicons.sparkles,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'AI ${(aiConfidence * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            _memory!['title'] ?? 'Без заголовка',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
          ),
          const SizedBox(height: 8),

          // Timestamp
          Row(
            children: [
              Icon(
                Ionicons.time_outline,
                size: 16,
                color: isDark ? Colors.white60 : Colors.black54,
              ),
              const SizedBox(width: 6),
              Text(
                _formatDate(createdAt),
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
              if (updatedAt != null) ...[
                const SizedBox(width: 16),
                Icon(
                  Ionicons.create_outline,
                  size: 16,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
                const SizedBox(width: 6),
                Text(
                  'Изменено ${_formatDate(updatedAt)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 24),

          // Content
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Text(
              _memory!['content'] ?? '',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                  ),
            ),
          ),
          const SizedBox(height: 24),

          // Tags
          if (tags.isNotEmpty) ...[
            Text(
              'Теги',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Ionicons.pricetag,
                        size: 14,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        tag,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],

          // AI Extracted Data
          if (extraMetadata != null && extraMetadata.isNotEmpty) ...[
            Text(
              'AI Метаданные',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: extraMetadata.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Ionicons.information_circle,
                          size: 18,
                          color: AppTheme.accentColor,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _formatMetadataKey(entry.key),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                entry.value?.toString() ?? 'N/A',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Только что';
        }
        return '${difference.inMinutes} мин назад';
      }
      return '${difference.inHours} ч назад';
    } else if (difference.inDays == 1) {
      return 'Вчера';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} дн назад';
    } else {
      return '${date.day}.${date.month.toString().padLeft(2, '0')}.${date.year}';
    }
  }

  String _formatMetadataKey(String key) {
    // Capitalize and add spaces
    return key
        .replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) => ' ${match.group(0)}',
        )
        .trim()
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  List<Color> _getConfidenceGradient(double confidence) {
    if (confidence >= 0.8) {
      return [Colors.green.shade500, Colors.green.shade700];
    } else if (confidence >= 0.6) {
      return [Colors.lightGreen.shade500, Colors.lightGreen.shade700];
    } else if (confidence >= 0.4) {
      return [Colors.orange.shade400, Colors.orange.shade600];
    } else {
      return [Colors.deepOrange.shade400, Colors.deepOrange.shade600];
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Удалить воспоминание?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Это действие нельзя отменить',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              try {
                await _memoryDataSource.deleteMemory(widget.memoryId);
                if (mounted) {
                  Navigator.pop(context, true); // Return to previous page
                  SnackBarUtils.showSuccess(context, 'Воспоминание удалено');
                }
              } catch (e) {
                if (mounted) {
                  SnackBarUtils.showError(
                    context,
                    ErrorMessages.getErrorMessage(e),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }
}

