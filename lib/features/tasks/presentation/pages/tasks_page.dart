import 'package:flutter/material.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';
import 'package:memoir/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:memoir/features/tasks/presentation/pages/create_task_page.dart';
import 'package:memoir/features/tasks/presentation/pages/task_details_page.dart';
import 'package:memoir/features/tasks/presentation/widgets/task_card.dart';
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

      // Логируем подзадачи для отладки
      for (final task in tasks) {
        if (task.subtasks.isNotEmpty) {
          log('📝 [TASKS] Task "${task.title}" has ${task.subtasks.length} subtasks: ${task.subtasks.map((s) => s.title).join(", ")}');
        }
      }

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
    try {
      if (task.status == TaskStatus.completed) {
        // Отменяем выполнение задачи
        await _taskDataSource.uncompleteTask(task.id);
        SnackBarUtils.showInfo(context, 'Выполнение задачи отменено');
      } else {
        // Выполняем задачу
        await _taskDataSource.completeTask(task.id);

        // 🐾 Play with pet when completing task
        await PetService().playWithPet();

        SnackBarUtils.showSuccess(context, 'Задача выполнена! 🎉');
      }

      await _loadTasks();
    } catch (e) {
      log('❌ [TASKS] Error toggling task status: $e');
      SnackBarUtils.showError(
        context,
        'Ошибка: ${ErrorMessages.getErrorMessage(e)}',
      );
    }
  }

  Future<void> _toggleSubtask(String taskId, String subtaskId) async {
    try {
      // Находим задачу
      final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
      if (taskIndex == -1) return;

      final task = _tasks[taskIndex];

      // Находим подзадачу
      final subtaskIndex = task.subtasks.indexWhere((s) => s.id == subtaskId);
      if (subtaskIndex == -1) return;

      final subtask = task.subtasks[subtaskIndex];
      final newState = !subtask.is_completed;

      // Оптимистичное обновление
      final updatedSubtask = subtask.copyWith(is_completed: newState);
      final updatedSubtasks = [...task.subtasks];
      updatedSubtasks[subtaskIndex] = updatedSubtask;
      final updatedTask = task.copyWith(subtasks: updatedSubtasks);

      // Обновляем задачу в списке
      _tasks[taskIndex] = updatedTask;
      setState(() {});

      // API call
      await _taskDataSource.updateSubtask(taskId, subtaskId, {
        'is_completed': newState,
      });
    } catch (e) {
      log('❌ [TASKS] Error toggling subtask: $e');
      // Перезагружаем задачи при ошибке
      await _loadTasks();
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
                        return TaskCard(
                          key: ValueKey(task.id),
                          task: task,
                          onTap: () => _openTaskDetails(task),
                          onToggleStatus: () => _toggleTaskStatus(task),
                          onToggleSubtask: (subtaskId) =>
                              _toggleSubtask(task.id, subtaskId),
                        );
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
                        ? AppTheme.primaryColor
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: isToday && !isSelected
                        ? Border.all(color: AppTheme.primaryColor, width: 2)
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : isToday
                            ? AppTheme.primaryColor
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
