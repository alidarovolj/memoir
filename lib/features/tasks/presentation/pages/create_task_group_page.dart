import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/core/widgets/glass_button.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:developer';

class CreateTaskGroupPage extends StatefulWidget {
  const CreateTaskGroupPage({super.key});

  @override
  State<CreateTaskGroupPage> createState() => _CreateTaskGroupPageState();
}

class _CreateTaskGroupPageState extends State<CreateTaskGroupPage> {
  final _nameController = TextEditingController();
  String _name = 'Новая группа';
  Color _selectedColor = const Color(0xFF4CAF50); // Green
  String _selectedIcon = '📋';
  String _notificationEnabled = 'none';
  bool _isLoading = false;

  // Available colors
  final List<Color> _availableColors = [
    const Color(0xFF4CAF50), // Green
    const Color(0xFF2196F3), // Blue
    const Color(0xFFE91E63), // Pink
    const Color(0xFF9C27B0), // Purple
    const Color(0xFFFF9800), // Orange
    const Color(0xFFFF5722), // Deep Orange
    const Color(0xFF00BCD4), // Cyan
    const Color(0xFFFFC107), // Amber
    const Color(0xFF795548), // Brown
    const Color(0xFF607D8B), // Blue Grey
  ];

  // Available icons
  final List<String> _availableIcons = [
    '📋', '🎯', '💼', '🏃', '📚', '🍎', '💪', '🏠', '🎨', '🎵',
    '⚡', '🔥', '🌟', '🎓', '🛒', '📞', '✈️', '🌙', '☀️', '🌸'
  ];

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text.isEmpty
            ? 'Новая группа'
            : _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _createGroup() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите название группы')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final groupData = {
        'name': _nameController.text.trim(),
        'color': '#${_selectedColor.value.toRadixString(16).substring(2, 8)}',
        'icon': _selectedIcon,
        'notification_enabled': _notificationEnabled,
        'order_index': 0,
      };

      log('📁 [CREATE_GROUP] Creating task group: $groupData');

      if (mounted) {
        Navigator.of(context).pop(groupData);
      }
    } catch (e, stackTrace) {
      log('❌ [CREATE_GROUP] Error: $e', error: e, stackTrace: stackTrace);
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 84, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Preview Section
                  _buildSectionHeader('Предпросмотр'),
                  const SizedBox(height: 12),
                  _buildPreviewCard(),

                  const SizedBox(height: 32),

                  // Appearance Section
                  _buildSectionHeader('Внешний вид'),
                  const SizedBox(height: 12),
                  _buildAppearanceSection(),

                  const SizedBox(height: 32),

                  // General Section
                  _buildSectionHeader('Общее'),
                  const SizedBox(height: 12),
                  _buildGeneralSection(),

                  const SizedBox(height: 32),
                ],
              ),
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
                title: 'Добавить группу',
                type: HeaderType.back,
                onBack: () => Navigator.of(context).pop(),
                trailing: GlassButton(
                  onTap: _isLoading ? () {} : () => _createGroup(),
                  child: Icon(
                    Ionicons.checkmark,
                    color: _isLoading ? Colors.white38 : Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildPreviewCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _selectedColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _selectedColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                _selectedIcon,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              _name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppearanceSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Name input
          _buildSettingTile(
            icon: Ionicons.text_outline,
            iconColor: Colors.white,
            title: 'Название',
            trailing: Expanded(
              child: TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите название',
                  hintStyle: TextStyle(color: Colors.white38, fontSize: 15),
                ),
              ),
            ),
            onTap: null,
          ),

          const Divider(height: 1, color: Colors.white12),

          // Color picker
          _buildSettingTile(
            icon: Ionicons.color_palette_outline,
            iconColor: Colors.red,
            title: 'Цвет',
            trailing: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: _selectedColor,
                shape: BoxShape.circle,
              ),
            ),
            onTap: _showColorPicker,
          ),

          const Divider(height: 1, color: Colors.white12),

          // Icon picker
          _buildSettingTile(
            icon: Ionicons.happy_outline,
            iconColor: Colors.orange,
            title: 'Иконка',
            trailing: Text(
              _selectedIcon,
              style: const TextStyle(fontSize: 20),
            ),
            onTap: _showIconPicker,
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Notifications
          _buildSettingTile(
            icon: Ionicons.notifications_outline,
            iconColor: Colors.pink,
            title: 'Уведомления',
            trailing: Text(
              _getNotificationLabel(_notificationEnabled),
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 15,
              ),
            ),
            onTap: _showNotificationPicker,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget trailing,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            trailing is Expanded
                ? trailing
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      trailing,
                      if (onTap != null) ...[
                        const SizedBox(width: 8),
                        Icon(
                          Ionicons.chevron_forward,
                          color: Colors.white.withOpacity(0.3),
                          size: 16,
                        ),
                      ],
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  void _showColorPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Выберите цвет',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _availableColors.map((color) {
                final isSelected = color == _selectedColor;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.white, width: 3)
                          : null,
                    ),
                    child: isSelected
                        ? const Icon(
                            Ionicons.checkmark,
                            color: Colors.white,
                            size: 28,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showIconPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Выберите иконку',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _availableIcons.map((icon) {
                final isSelected = icon == _selectedIcon;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIcon = icon;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _selectedColor
                          : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        icon,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showNotificationPicker() {
    final options = [
      {'value': 'none', 'label': 'Нет'},
      {'value': 'automatic', 'label': 'Автоматически'},
      {'value': 'custom', 'label': 'Настроить'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Уведомления',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...options.map((option) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  option['label']!,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                trailing: _notificationEnabled == option['value']
                    ? Icon(Ionicons.checkmark_circle, color: _selectedColor)
                    : null,
                onTap: () {
                  setState(() {
                    _notificationEnabled = option['value']!;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  String _getNotificationLabel(String value) {
    switch (value) {
      case 'none':
        return 'Нет';
      case 'automatic':
        return 'Автоматически';
      case 'custom':
        return 'Настроить';
      default:
        return 'Нет';
    }
  }
}
