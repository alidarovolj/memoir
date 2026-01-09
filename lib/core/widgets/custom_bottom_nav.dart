import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomBottomNav extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  final List<_NavItemData> _navItems = [
    _NavItemData(
      index: 0,
      selectedIcon: Ionicons.home,
      icon: Ionicons.home_outline,
      label: 'Главная',
    ),
    _NavItemData(
      index: 1,
      selectedIcon: Ionicons.people,
      icon: Ionicons.people_outline,
      label: 'Друзья',
    ),
    _NavItemData(
      index: 2,
      selectedIcon: Ionicons.stats_chart,
      icon: Ionicons.stats_chart_outline,
      label: 'Аналитика',
    ),
    _NavItemData(
      index: 3,
      selectedIcon: Ionicons.person,
      icon: Ionicons.person_outline,
      label: 'Профиль',
    ),
  ];

  Offset? _dragPosition;
  int? _hoveredIndex;
  final Map<int, GlobalKey> _itemKeys = {};

  @override
  void initState() {
    super.initState();
    for (var item in _navItems) {
      _itemKeys[item.index] = GlobalKey();
    }
  }

  int _getIndexFromPosition(Offset position, Size containerSize) {
    final itemWidth = containerSize.width / _navItems.length;
    final index = (position.dx / itemWidth).floor().clamp(0, _navItems.length - 1);
    return index;
  }

  void _onPanStart(DragStartDetails details) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      final localPosition = box.globalToLocal(details.globalPosition);
      final index = _getIndexFromPosition(localPosition, box.size);
      if (index == widget.selectedIndex) {
        setState(() {
          _dragPosition = localPosition;
        });
      }
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_dragPosition == null) return;

    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      final localPosition = box.globalToLocal(details.globalPosition);
      final newIndex = _getIndexFromPosition(localPosition, box.size);

      setState(() {
        _dragPosition = localPosition;
        if (newIndex != widget.selectedIndex && newIndex != _hoveredIndex) {
          _hoveredIndex = newIndex;
          // Переключаемся на новый таб при перетаскивании
          widget.onDestinationSelected(newIndex);
        }
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _dragPosition = null;
      _hoveredIndex = null;
    });
  }

  void _onPanCancel() {
    setState(() {
      _dragPosition = null;
      _hoveredIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
          child: GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            onPanCancel: _onPanCancel,
            child: Container(
              height: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(34),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(34),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: _navItems.map((item) {
                            return Expanded(
                              key: _itemKeys[item.index],
                              child: _buildNavItem(item),
                            );
                          }).toList(),
                        ),
                        // Визуальный индикатор перетаскивания
                        if (_dragPosition != null)
                          Positioned(
                            left: _dragPosition!.dx - 30,
                            top: 0,
                            child: IgnorePointer(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.drag_handle,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
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
      ),
    );
  }

  Widget _buildNavItem(_NavItemData item) {
    final isSelected = widget.selectedIndex == item.index;
    final isHovered = _hoveredIndex == item.index && _dragPosition != null;

    return GestureDetector(
      onTap: () => widget.onDestinationSelected(item.index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.2)
              : isHovered
                  ? Colors.white.withOpacity(0.15)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? item.selectedIcon : item.icon,
              color: isSelected
                  ? Colors.white
                  : isHovered
                      ? Colors.white.withOpacity(0.8)
                      : Colors.white.withOpacity(0.6),
              size: 24,
            ),
            const SizedBox(height: 3),
            Text(
              item.label,
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 10,
                fontWeight: isSelected
                    ? FontWeight.w600
                    : isHovered
                        ? FontWeight.w600
                        : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : isHovered
                        ? Colors.white.withOpacity(0.8)
                        : Colors.white.withOpacity(0.6),
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
    );
  }
}

class _NavItemData {
  final int index;
  final IconData selectedIcon;
  final IconData icon;
  final String label;

  _NavItemData({
    required this.index,
    required this.selectedIcon,
    required this.icon,
    required this.label,
  });
}
