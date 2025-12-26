import 'package:flutter/material.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';
import 'package:memoir/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:memoir/features/tasks/presentation/widgets/daily_timeline.dart';
import 'package:memoir/features/tasks/presentation/widgets/kanban_board.dart';
import 'package:memoir/features/tasks/presentation/pages/create_task_page.dart';
import 'package:memoir/features/tasks/presentation/pages/task_details_page.dart';
import 'package:memoir/core/widgets/widgets.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/core/utils/error_messages.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:developer';
import 'package:memoir/features/pet/data/services/pet_service.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TaskRemoteDataSource _taskDataSource;

  List<TaskModel> _tasks = [];
  bool _isLoading = false;
  TimeScope _currentScope = TimeScope.daily;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _taskDataSource = TaskRemoteDataSourceImpl(dio: DioClient.instance);
    _tabController.addListener(_onTabChanged);
    _loadTasks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      setState(() {
        _currentScope = _getScopeFromTab(_tabController.index);
      });
      _loadTasks();
    }
  }

  TimeScope _getScopeFromTab(int index) {
    switch (index) {
      case 0:
        return TimeScope.daily;
      case 1:
        return TimeScope.weekly;
      case 2:
        return TimeScope.monthly;
      case 3:
        return TimeScope.longTerm;
      default:
        return TimeScope.daily;
    }
  }

  Future<void> _loadTasks() async {
    setState(() => _isLoading = true);

    try {
      final response = await _taskDataSource.getTasks(
        timeScope: _currentScope,
        // Load all statuses for Kanban board
      );

      final items = response['items'] as List;
      final tasks = items.map((item) => TaskModel.fromJson(item)).toList();

      if (mounted) {
        setState(() {
          _tasks = tasks;
          _isLoading = false;
        });
        log(
          '📋 [TASKS] Loaded ${_tasks.length} tasks for ${_currentScope.name}',
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

  Future<void> _openTaskDetails(TaskModel task) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TaskDetailsPage(task: task, onTaskUpdated: _loadTasks),
      ),
    );
  }

  // ignore: unused_element
  Future<void> _completeTask(TaskModel task) async {
    try {
      await _taskDataSource.completeTask(task.id);

      // 🐾 Play with pet when completing task
      await PetService().playWithPet();

      SnackBarUtils.showSuccess(context, 'Задача выполнена!');
      await _loadTasks();
    } catch (e) {
      log('❌ [TASKS] Error completing task: $e');
      SnackBarUtils.showError(
        context,
        'Не удалось завершить задачу: ${ErrorMessages.getErrorMessage(e)}',
      );
    }
  }

  // ignore: unused_element
  Future<void> _deleteTask(TaskModel task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить задачу?'),
        content: Text('Вы уверены, что хотите удалить "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _taskDataSource.deleteTask(task.id);
        SnackBarUtils.showSuccess(context, 'Задача удалена');
        await _loadTasks();
      } catch (e) {
        log('❌ [TASKS] Error deleting task: $e');
        SnackBarUtils.showError(
          context,
          'Не удалось удалить задачу: ${ErrorMessages.getErrorMessage(e)}',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: Column(
        children: [
          // SafeArea с хедером
          Container(
            color: AppTheme.headerBackgroundColor,
            child: SafeArea(
              bottom: false,
              child: CustomHeader(
                title: 'Планирование',
                type: HeaderType.none,
                trailing: IconButton(
                  icon: const Icon(Ionicons.filter_outline, size: 22),
                  onPressed: () {
                    SnackBarUtils.showInfo(context, 'Фильтры - в разработке');
                  },
                ),
              ),
            ),
          ),
          // Tabs
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(4),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.6),
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Сегодня'),
                Tab(text: 'Неделя'),
                Tab(text: 'Месяц'),
                Tab(text: 'Долгосрочные'),
              ],
            ),
          ),

          // Task list
          Expanded(
            child: _isLoading
                ? const LoadingState(message: 'Загрузка задач...')
                : _tasks.isEmpty
                ? EmptyState(
                    title: 'Нет задач',
                    subtitle: _getEmptyMessage(),
                    buttonText: 'Создать задачу',
                    buttonIcon: Ionicons.add_circle_outline,
                    onButtonPressed: _openCreateTask,
                  )
                : _currentScope == TimeScope.daily
                // Daily tasks: Timeline view with hours
                ? DailyTimeline(
                    tasks: _tasks,
                    onRefresh: _loadTasks,
                    onTaskTap: _openTaskDetails,
                  )
                // Other scopes: Kanban board with status columns
                : KanbanBoard(
                    tasks: _tasks,
                    onRefresh: _loadTasks,
                    onTaskTap: _openTaskDetails,
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateTask,
        icon: const Icon(Ionicons.add_outline, size: 20),
        label: const Text('Создать'),
      ),
    );
  }

  String _getEmptyMessage() {
    switch (_currentScope) {
      case TimeScope.daily:
        return 'На сегодня задач нет.\nСоздайте первую задачу!';
      case TimeScope.weekly:
        return 'На эту неделю задач нет.\nЗапланируйте что-нибудь!';
      case TimeScope.monthly:
        return 'На этот месяц задач нет.\nПора планировать!';
      case TimeScope.longTerm:
        return 'Нет долгосрочных целей.\nПоставьте себе цель!';
    }
  }

  Future<void> _openCreateTask() async {
    final result = await Navigator.of(context).push(
      PageTransitions.slideFromBottom(
        CreateTaskPage(initialTimeScope: _currentScope),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      // Create task via API
      try {
        await _taskDataSource.createTask(result);
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
