import 'package:flutter/material.dart';
import 'package:memoir/features/tasks/data/models/task_group_model.dart';
import 'package:memoir/features/tasks/data/datasources/task_group_remote_datasource.dart';
import 'package:memoir/features/tasks/presentation/pages/create_task_group_page.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:developer';

class SelectTaskGroupPage extends StatefulWidget {
  final String? selectedGroupId;

  const SelectTaskGroupPage({super.key, this.selectedGroupId});

  @override
  State<SelectTaskGroupPage> createState() => _SelectTaskGroupPageState();
}

class _SelectTaskGroupPageState extends State<SelectTaskGroupPage> {
  late TaskGroupRemoteDataSource _groupDataSource;
  List<TaskGroupModel> _groups = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _groupDataSource = TaskGroupRemoteDataSourceImpl(dio: DioClient.instance);
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    setState(() => _isLoading = true);

    try {
      final groups = await _groupDataSource.getTaskGroups();

      if (mounted) {
        setState(() {
          _groups = groups;
          _isLoading = false;
        });
        log('📁 [GROUPS] Loaded ${_groups.length} task groups');
      }
    } catch (e, stackTrace) {
      log(
        '❌ [GROUPS] Error loading task groups: $e',
        error: e,
        stackTrace: stackTrace,
      );
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Не удалось загрузить группы: $e')),
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

  Future<void> _createNewGroup() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateTaskGroupPage(),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      try {
        final group = await _groupDataSource.createTaskGroup(result);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Группа создана!')),
          );
          
          // Перезагружаем список групп
          await _loadGroups();
          
          // Автоматически выбираем новую группу
          Navigator.of(context).pop({
            'id': group.id,
            'name': group.name,
            'icon': group.icon,
            'color': group.color,
          });
        }
      } catch (e) {
        log('❌ [GROUPS] Error creating group: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка: $e')),
          );
        }
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
            child: Column(
              children: [
                const SizedBox(height: 64), // Отступ для CustomHeader

                if (_isLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      children: [
                        // Кнопка создания новой группы
                        GestureDetector(
                          onTap: _createNewGroup,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppTheme.primaryColor,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Ionicons.add,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Expanded(
                                  child: Text(
                                    'Создать группу',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Ionicons.chevron_forward,
                                  color: Colors.white.withOpacity(0.5),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Опция "Без группы"
                        _buildGroupTile(
                          id: null,
                          name: 'Без группы',
                          icon: '📋',
                          color: Colors.grey,
                          isSelected: widget.selectedGroupId == null,
                        ),

                        const SizedBox(height: 8),

                        // Список групп
                        if (_groups.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Ionicons.folder_outline,
                                    size: 64,
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Нет групп',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Создайте группу для организации задач',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.3),
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          ..._groups.map((group) {
                            return _buildGroupTile(
                              id: group.id,
                              name: group.name,
                              icon: group.icon,
                              color: _parseColor(group.color),
                              isSelected: widget.selectedGroupId == group.id,
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
                title: 'Группа',
                type: HeaderType.back,
                onBack: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupTile({
    required String? id,
    required String name,
    required String icon,
    required Color color,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop({
          'id': id,
          'name': name,
          'icon': icon,
          'color': '#${color.value.toRadixString(16).substring(2, 8)}',
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? Border.all(color: color, width: 2) : null,
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
                name,
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
