import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:ionicons/ionicons.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark 
            ? AppTheme.surfaceColor.withOpacity(0.9)
            : Colors.white.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Ionicons.home, Ionicons.home_outline, 'Главная'),
              _buildNavItem(
                1,
                Ionicons.apps,
                Ionicons.apps_outline,
                'Категории',
              ),
              _buildNavItem(
                2,
                Ionicons.search,
                Ionicons.search_outline,
                'Поиск',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData selectedIcon,
    IconData icon,
    String label,
  ) {
    final isSelected = selectedIndex == index;

    return Expanded(
      child: Builder(
        builder: (context) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          
          return InkWell(
            onTap: () => onDestinationSelected(index),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected ? selectedIcon : icon,
                    color: isSelected 
                        ? AppTheme.primaryColor 
                        : (isDark ? Colors.white54 : Colors.black54),
                    size: 28,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected 
                          ? AppTheme.primaryColor 
                          : (isDark ? Colors.white54 : Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
