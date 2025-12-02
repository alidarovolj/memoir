import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:ionicons/ionicons.dart';

class CategoriesModal extends StatefulWidget {
  const CategoriesModal({super.key});

  @override
  State<CategoriesModal> createState() => _CategoriesModalState();
}

class _CategoriesModalState extends State<CategoriesModal> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Фильмы и сериалы',
      'icon': Ionicons.film_outline,
      'color': const Color(0xFFE50914),
      'emoji': '🎬',
    },
    {
      'name': 'Книги и статьи',
      'icon': Ionicons.book_outline,
      'color': const Color(0xFF4285F4),
      'emoji': '📚',
    },
    {
      'name': 'Места',
      'icon': Ionicons.location_outline,
      'color': const Color(0xFF34A853),
      'emoji': '📍',
    },
    {
      'name': 'Идеи и инсайты',
      'icon': Ionicons.bulb_outline,
      'color': const Color(0xFFFBBC04),
      'emoji': '💡',
    },
    {
      'name': 'Рецепты',
      'icon': Ionicons.restaurant_outline,
      'color': const Color(0xFFFF6D00),
      'emoji': '🍳',
    },
    {
      'name': 'Покупки',
      'icon': Ionicons.bag_handle_outline,
      'color': const Color(0xFF9C27B0),
      'emoji': '🛍️',
    },
  ];

  List<Map<String, dynamic>> get _filteredCategories {
    if (_searchQuery.isEmpty) {
      return _categories;
    }
    return _categories
        .where((cat) =>
            cat['name'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Хендлер
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Заголовок и закрыть
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Категории',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Ionicons.close_outline),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.black54,
                ),
              ],
            ),
          ),

          // Поиск
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Поиск или создать',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon: Icon(Ionicons.search_outline, color: Colors.grey.shade500),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                style: const TextStyle(color: Colors.black87),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Список категорий
          Flexible(
            child: _filteredCategories.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        'Категории не найдены',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredCategories.length,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      final category = _filteredCategories[index];
                      return _CategoryItem(
                        emoji: category['emoji'],
                        name: category['name'],
                        icon: category['icon'],
                        color: category['color'],
                        onTap: () {
                          Navigator.pop(context, category);
                        },
                      );
                    },
                  ),
          ),

          const SizedBox(height: 16),

          // Кнопка создать
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            child: SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      // TODO: Создать новую категорию
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Ionicons.add_outline, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Создать новую категорию',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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

class _CategoryItem extends StatelessWidget {
  final String emoji;
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.emoji,
    required this.name,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              // Аватар с emoji
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Название
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Иконка
              Icon(
                Ionicons.chevron_forward_outline,
                color: Colors.grey.shade400,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

