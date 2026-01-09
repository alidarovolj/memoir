import 'package:flutter/material.dart';
import 'package:memoir/features/tasks/data/models/category_model.dart';
import 'package:memoir/features/tasks/data/datasources/category_remote_datasource.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:developer';

class SelectCategoryPage extends StatefulWidget {
  final String? selectedCategoryId;

  const SelectCategoryPage({super.key, this.selectedCategoryId});

  @override
  State<SelectCategoryPage> createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  late CategoryRemoteDataSource _categoryDataSource;
  List<CategoryModel> _categories = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _categoryDataSource = CategoryRemoteDataSourceImpl(dio: DioClient.instance);
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoading = true);

    try {
      final categories = await _categoryDataSource.getCategories();

      if (mounted) {
        setState(() {
          _categories = categories;
          _isLoading = false;
        });
        log('📁 [CATEGORIES] Loaded ${_categories.length} categories');
      }
    } catch (e, stackTrace) {
      log(
        '❌ [CATEGORIES] Error loading categories: $e',
        error: e,
        stackTrace: stackTrace,
      );
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Не удалось загрузить категории: $e')),
        );
      }
    }
  }

  Color _parseColor(String hexColor) {
    try {
      final hex = hexColor.replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (e) {
      return AppTheme.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: Stack(
        children: [
          // Контент страницы
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 64), // Отступ для CustomHeader
                
                if (_isLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (_categories.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Ionicons.folder_outline,
                            size: 64,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Нет категорий',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      children: [
                        // Опция "Без категории"
                        _buildCategoryTile(
                          id: null,
                          displayName: 'Без категории',
                          icon: '📋',
                          color: Colors.grey,
                          isSelected: widget.selectedCategoryId == null,
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Список категорий
                        ..._categories.map((category) {
                          return _buildCategoryTile(
                            id: category.id,
                            displayName: category.display_name,
                            icon: category.icon,
                            color: _parseColor(category.color),
                            isSelected: widget.selectedCategoryId == category.id,
                          );
                        }).toList(),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          
          // CustomHeader поверх контента
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: CustomHeader(
                title: 'Категория',
                type: HeaderType.back,
                onBack: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTile({
    required String? id,
    required String displayName,
    required String icon,
    required Color color,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop({
          'id': id,
          'display_name': displayName,
          'icon': icon,
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: color, width: 2)
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  icon,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                displayName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Ionicons.checkmark_circle,
                color: color,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
