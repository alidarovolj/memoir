import 'package:flutter/material.dart';
import 'dart:ui';
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

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkColor.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 76,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                gradient: isDark
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppTheme.surfaceColor.withOpacity(0.7),
                          AppTheme.darkColor.withOpacity(0.8),
                        ],
                      )
                    : AppTheme.floatingTabBarGradient,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: AppTheme.whiteColor.withOpacity(0.15),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildNavItem(
                    context,
                    0,
                    Ionicons.home,
                    Ionicons.home_outline,
                    'Home',
                  ),
                  _buildNavItem(
                    context,
                    1,
                    Ionicons.search,
                    Ionicons.search_outline,
                    'Search',
                  ),
                  _buildNavItem(
                    context,
                    2,
                    Ionicons.sparkles,
                    Ionicons.sparkles_outline,
                    'AI',
                  ),
                  _buildNavItem(
                    context,
                    3,
                    Ionicons.apps,
                    Ionicons.apps_outline,
                    'Browse',
                  ),
                  _buildNavItem(
                    context,
                    4,
                    Ionicons.person,
                    Ionicons.person_outline,
                    'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Кнопки навигации
  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData selectedIcon,
    IconData icon,
    String label,
  ) {
    final isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onDestinationSelected(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                color: isSelected
                    ? AppTheme.blueColor
                    : AppTheme.whiteColor.withOpacity(0.5),
                size: 24,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? AppTheme.blueColor
                      : AppTheme.whiteColor.withOpacity(0.5),
                  letterSpacing: 0,
                  height: 1.0,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
