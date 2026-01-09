import 'package:flutter/material.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';
import 'package:memoir/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:memoir/features/tasks/presentation/pages/create_task_page.dart';
import 'package:memoir/features/tasks/presentation/pages/task_details_page.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/core/utils/error_messages.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:developer';
import 'package:memoir/features/pet/data/services/pet_service.dart';
import 'package:intl/intl.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/core/widgets/glass_button.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late TaskRemoteDataSource _taskDataSource;
  List<TaskModel> _tasks = [];
  bool _isLoading = false;
  int _streakCount = 0;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _taskDataSource = TaskRemoteDataSourceImpl(dio: DioClient.instance);
    _loadTasks();
    _loadStreak();
  }

  Future<void> _loadTasks() async {
    setState(() => _isLoading = true);

    try {
      final response = await _taskDataSource.getTasks(
        timeScope: TimeScope.daily,
        date: _selectedDate, // Передаем выбранную дату
      );

      final items = response['items'] as List;
      final tasks = items.map((item) => TaskModel.fromJson(item)).toList();

      if (mounted) {
        setState(() {
          _tasks = tasks;
          _isLoading = false;
        });
        log(
          '📋 [TASKS] Loaded ${_tasks.length} tasks for ${_selectedDate.toString().split(' ')[0]}',
        );
      }
    } catch (e, stackTrace) {
      log(
        '❌ [TASKS] Error loading tasks: $e',
        error: e,
        stackTrace: stackTrace,
      );
      if (mounted) {
        setState(() => _isLoading = false);
        SnackBarUtils.showError(
          context,
          'Не удалось загрузить задачи: ${ErrorMessages.getErrorMessage(e)}',
        );
      }
    }
  }

  Future<void> _loadStreak() async {
    // TODO: Load real streak from backend
    setState(() {
      _streakCount = 1;
    });
  }

  Future<void> _toggleTaskStatus(TaskModel task) async {
    if (task.status == TaskStatus.completed) {
      // Already completed, just show info
      SnackBarUtils.showInfo(context, 'Задача уже выполнена');
      return;
    }

    try {
      // Complete task
      await _taskDataSource.completeTask(task.id);

      // 🐾 Play with pet when completing task
      await PetService().playWithPet();

      SnackBarUtils.showSuccess(context, 'Задача выполнена! 🎉');

      await _loadTasks();
    } catch (e) {
      log('❌ [TASKS] Error completing task: $e');
      SnackBarUtils.showError(
        context,
        'Ошибка: ${ErrorMessages.getErrorMessage(e)}',
      );
    }
  }

  Future<void> _openTaskDetails(TaskModel task) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TaskDetailsPage(task: task, onTaskUpdated: _loadTasks),
      ),
    );
  }

  String _getHeaderTitle() {
    final today = DateTime.now();
    final isToday =
        _selectedDate.year == today.year &&
        _selectedDate.month == today.month &&
        _selectedDate.day == today.day;

    if (isToday) {
      return 'Today';
    } else {
      // Показываем дату в формате "дд.мм"
      return DateFormat('dd.MM').format(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: Stack(
        children: [
          // Контент страницы
          _buildBody(),

          // CustomHeader поверх контента
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: CustomHeader(
                title: _getHeaderTitle(),
                type: HeaderType.none,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Streak badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Ionicons.flame,
                            color: Colors.orange,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _streakCount.toString(),
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Add button
                    GlassButton(
                      onTap: _openCreateTask,
                      child: const Icon(
                        Ionicons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          // Отступ для CustomHeader
          SizedBox(height: 64),

          // Week Calendar
          _buildWeekCalendar(),

          // Tasks List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _tasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.checkbox_outline,
                          size: 64,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Нет задач на сегодня',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: _openCreateTask,
                          icon: const Icon(Ionicons.add_circle_outline),
                          label: const Text('Создать задачу'),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _loadTasks,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return _buildTaskCard(task);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekCalendar() {
    final today = DateTime.now();
    final weekStart = today.subtract(Duration(days: today.weekday - 1));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (index) {
          final date = weekStart.add(Duration(days: index));
          final isToday =
              date.day == today.day &&
              date.month == today.month &&
              date.year == today.year;
          final isSelected =
              date.day == _selectedDate.day &&
              date.month == _selectedDate.month &&
              date.year == _selectedDate.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
              // Загружаем задачи для выбранной даты
              _loadTasks();
            },
            child: Column(
              children: [
                Text(
                  DateFormat('E').format(date),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF6366F1)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: isToday && !isSelected
                        ? Border.all(color: const Color(0xFF6366F1), width: 2)
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : isToday
                            ? const Color(0xFF6366F1)
                            : Colors.white.withOpacity(0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTaskCard(TaskModel task) {
    final isCompleted = task.status == TaskStatus.completed;
    final color = _getTaskColor(task);

    return GestureDetector(
      onTap: () => _openTaskDetails(task),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(_getTaskIcon(task), color: Colors.white, size: 28),
            ),

            const SizedBox(width: 16),

            // Task info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (task.is_recurring) ...[
                        const Icon(
                          Ionicons.repeat,
                          color: Colors.white70,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        _getTaskSubtitle(task),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Completion indicator
            GestureDetector(
              onTap: () => _toggleTaskStatus(task),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.white
                      : Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: !isCompleted
                      ? Border.all(color: Colors.white, width: 2)
                      : null,
                ),
                child: isCompleted
                    ? Icon(Ionicons.checkmark, color: color, size: 28)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTaskColor(TaskModel task) {
    // Generate color based on priority or use default
    switch (task.priority) {
      case TaskPriority.urgent:
        return const Color(0xFFEF4444); // Red
      case TaskPriority.high:
        return const Color(0xFFF97316); // Orange
      case TaskPriority.medium:
        return const Color(0xFFE91E63); // Magenta (default Grit color)
      case TaskPriority.low:
        return const Color(0xFF8B5CF6); // Purple
    }
  }

  IconData _getTaskIcon(TaskModel task) {
    // TODO: Store icon in task metadata
    return Ionicons.checkbox_outline;
  }

  String _getTaskSubtitle(TaskModel task) {
    if (task.is_recurring) {
      return 'Каждый день';
    }
    if (task.scheduled_time != null) {
      return task.scheduled_time!;
    }

    // Показываем дату задачи относительно выбранного дня
    final today = DateTime.now();
    final isToday =
        _selectedDate.year == today.year &&
        _selectedDate.month == today.month &&
        _selectedDate.day == today.day;

    if (isToday) {
      return _getTimeScopeLabel(task.time_scope);
    } else {
      // Показываем дату в формате "дд.мм"
      return DateFormat('dd.MM').format(_selectedDate);
    }
  }

  String _getTimeScopeLabel(TimeScope scope) {
    switch (scope) {
      case TimeScope.daily:
        return 'Сегодня';
      case TimeScope.weekly:
        return 'На этой неделе';
      case TimeScope.monthly:
        return 'В этом месяце';
      case TimeScope.longTerm:
        return 'Долгосрочная';
    }
  }

  Future<void> _openCreateTask() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            const CreateTaskPage(initialTimeScope: TimeScope.daily),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      try {
        final task = await _taskDataSource.createTask(result);

        // Если задача повторяющаяся, генерируем экземпляры на 30 дней вперед
        if (result['is_recurring'] == true) {
          try {
            await _taskDataSource.generateRecurringInstances(
              task.id,
              daysAhead: 30,
            );
            log('✅ [TASKS] Generated recurring instances for task: ${task.id}');
          } catch (e) {
            log('⚠️ [TASKS] Warning: Could not generate instances: $e');
            // Не показываем ошибку пользователю, т.к. задача создана успешно
          }
        }

        SnackBarUtils.showSuccess(context, 'Задача создана!');
        await _loadTasks();
      } catch (e) {
        log('❌ [TASKS] Error creating task: $e');
        SnackBarUtils.showError(
          context,
          'Не удалось создать задачу: ${ErrorMessages.getErrorMessage(e)}',
        );
      }
    }
  }
}
