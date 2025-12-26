import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:memoir/core/core.dart';
import 'package:memoir/features/memories/data/datasources/memory_remote_datasource.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/features/memories/presentation/pages/edit_memory_page.dart';

class MemoryDetailPage extends StatefulWidget {
  final String memoryId;

  const MemoryDetailPage({super.key, required this.memoryId});

  @override
  State<MemoryDetailPage> createState() => _MemoryDetailPageState();
}

class _MemoryDetailPageState extends State<MemoryDetailPage> {
  late final MemoryRemoteDataSource _memoryDataSource;
  Map<String, dynamic>? _memory;
  bool _isLoading = true;
  late ScrollController _scrollController;
  final ValueNotifier<double> _scrollOffset = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _memoryDataSource = MemoryRemoteDataSourceImpl(dio: DioClient.instance);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _loadMemory();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _scrollOffset.dispose();
    super.dispose();
  }

  void _onScroll() {
    _scrollOffset.value = _scrollController.offset;
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
        SnackBarUtils.showError(context, ErrorMessages.getErrorMessage(e));
        Navigator.pop(context);
      }
    }
  }

  Future<void> _editMemory() async {
    if (_memory == null) return;

    final result = await Navigator.of(
      context,
    ).push(PageTransitions.slideFromRight(EditMemoryPage(memory: _memory!)));

    if (result != null && result is Map<String, dynamic>) {
      print('📝 [DETAIL] Received updated data, refreshing...');
      try {
        await _memoryDataSource.updateMemory(widget.memoryId, result);
        await _loadMemory();
        SnackBarUtils.showSuccess(context, '✅ Воспоминание обновлено!');
      } catch (e) {
        print('❌ [DETAIL] Error updating: $e');
        final message = ErrorMessages.getErrorMessage(e);
        SnackBarUtils.showError(context, 'Не удалось обновить: $message');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Устанавливаем светлый статус бар
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingState(message: 'Загрузка воспоминания...');
    }

    if (_memory == null) {
      return const EmptyState(
        title: 'Воспоминание не найдено',
        subtitle: 'Возможно, оно было удалено',
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final createdAt = _memory!['created_at'] != null
        ? DateTime.parse(_memory!['created_at'])
        : DateTime.now();

    // AI data
    final aiConfidence = _memory!['ai_confidence'] != null
        ? (_memory!['ai_confidence'] as num).toDouble()
        : null;
    final tags = _memory!['tags'] != null
        ? List<String>.from(_memory!['tags'])
        : <String>[];
    final extraMetadata = _memory!['extra_metadata'] as Map<String, dynamic>?;
    final imageUrl = _memory!['image_url'] as String?;

    return Stack(
      children: [
        // Основной контент
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Изображение с информацией поверх
            SliverToBoxAdapter(
              child: SizedBox(
                height: 430,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Изолированный блок с размытым фоном
                    if (imageUrl != null && imageUrl.isNotEmpty)
                      ClipRect(
                        child: Stack(
                          children: [
                            // Размытый фон
                            Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 430,
                            ),
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Container(color: Colors.transparent),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        color: AppTheme.pageBackgroundColor,
                        height: 430,
                      ),

                    // Основное изображение с размытыми границами
                    if (imageUrl != null && imageUrl.isNotEmpty)
                      SizedBox(
                        height: 430,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            // Основное изображение с сильным блюром
                            Stack(
                              children: [
                                // Очень размытое изображение как фон
                                ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    sigmaX: 25,
                                    sigmaY: 25,
                                  ),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                    height: 430,
                                  ),
                                ),
                                // Четкое изображение с расширенной градиентной маской
                                ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.white.withOpacity(0.3),
                                        Colors.white,
                                        Colors.white,
                                        Colors.white,
                                        Colors.white.withOpacity(0.3),
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.transparent,
                                      ],
                                      stops: const [
                                        0.0,
                                        0.1,
                                        0.2,
                                        0.3,
                                        0.4,
                                        0.5,
                                        0.6,
                                        0.7,
                                        0.8,
                                        0.9,
                                        1.0,
                                      ],
                                    ).createShader(bounds);
                                  },
                                  blendMode: BlendMode.dstIn,
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                    height: 430,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                    // Градиентный переход снизу
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              AppTheme.pageBackgroundColor.withOpacity(0.1),
                              AppTheme.pageBackgroundColor.withOpacity(0.3),
                              AppTheme.pageBackgroundColor.withOpacity(0.5),
                              AppTheme.pageBackgroundColor.withOpacity(0.7),
                              AppTheme.pageBackgroundColor,
                            ],
                            stops: const [0.0, 0.4, 0.6, 0.75, 0.85, 0.95, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Кнопки сверху справа
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 16,
                      right: 16,
                      child: Row(
                        children: [
                          if (!_isLoading && _memory != null) ...[
                            GestureDetector(
                              onTap: _editMemory,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Ionicons.create_outline,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: _showDeleteConfirmation,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Ionicons.trash_outline,
                                  color: Colors.red,
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.close,
                                color: AppTheme.primaryColor,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Информация в нижней части изображения
                    Positioned(
                      bottom: 24,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Заголовок
                          Text(
                            _memory!['title'] ?? 'Без заголовка',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Категория и дата
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (_memory!['category_name'] != null)
                                Flexible(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Ionicons.apps,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          _memory!['category_name'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            shadows: [
                                              Shadow(
                                                offset: const Offset(0, 1),
                                                blurRadius: 3,
                                                color: Colors.black.withOpacity(
                                                  0.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (_memory!['category_name'] != null)
                                const SizedBox(width: 16),
                              Flexible(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Ionicons.time_outline,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        _formatDate(createdAt),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          shadows: [
                                            Shadow(
                                              offset: const Offset(0, 1),
                                              blurRadius: 3,
                                              color: Colors.black.withOpacity(
                                                0.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Скроллируемый контент
            SliverToBoxAdapter(
              child: Container(
                color: AppTheme.pageBackgroundColor,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AI Confidence
                    if (aiConfidence != null && aiConfidence > 0) ...[
                      Row(
                        children: [
                          const Icon(
                            Ionicons.sparkles,
                            size: 16,
                            color: AppTheme.accentColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'AI ${(aiConfidence * 100).toInt()}%',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Заголовок "Содержание"
                    const Text(
                      'Содержание',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Content
                    Text(
                      _memory!['content'] ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: isDark
                            ? Colors.white.withOpacity(0.85)
                            : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Tags
                    if (tags.isNotEmpty) ...[
                      const Text(
                        'Теги',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
                      const Text(
                        'AI Метаданные',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...extraMetadata.entries.map((entry) {
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
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                    const SizedBox(height: 80), // Отступ снизу
                  ],
                ),
              ),
            ),
          ],
        ),

        // Анимированная SafeArea при скролле
        ValueListenableBuilder<double>(
          valueListenable: _scrollOffset,
          builder: (context, offset, child) {
            // Вычисляем прозрачность на основе скролла
            final opacity = (offset / 100).clamp(0.0, 1.0);

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: MediaQuery.of(context).padding.top,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.8 * opacity),
                    Colors.black.withOpacity(0.4 * opacity),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
            );
          },
        ),
      ],
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
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}')
        .trim()
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
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
