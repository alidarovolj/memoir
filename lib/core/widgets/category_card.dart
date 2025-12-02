import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String name;
  final IconData icon;
  final Color color;
  final String emoji;
  final int count;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    required this.emoji,
    required this.count,
    this.onTap,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1.0,
    );
    _scaleController.value = 1.0;
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleController,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => _isPressed = true);
          _scaleController.reverse();
        },
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _scaleController.forward();
          widget.onTap?.call();
        },
        onTapCancel: () {
          setState(() => _isPressed = false);
          _scaleController.forward();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.color.withOpacity(0.25),
                widget.color.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: widget.color.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: _isPressed
                ? []
                : [
                    BoxShadow(
                      color: widget.color.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Emoji + Icon
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      widget.emoji,
                      style: const TextStyle(fontSize: 48),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: widget.color.withOpacity(0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Icon(
                          widget.icon,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: widget.color.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${widget.count} воспоминаний',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

