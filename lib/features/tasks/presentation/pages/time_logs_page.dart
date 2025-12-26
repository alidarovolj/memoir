import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/core.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/tasks/data/datasources/task_time_remote_datasource.dart';
import 'package:memoir/features/tasks/data/models/task_time_log_model.dart';
import 'package:intl/intl.dart';

class TimeLogsPage extends StatefulWidget {
  final String taskId;
  final String taskTitle;

  const TimeLogsPage({
    super.key,
    required this.taskId,
    required this.taskTitle,
  });

  @override
  State<TimeLogsPage> createState() => _TimeLogsPageState();
}

class _TimeLogsPageState extends State<TimeLogsPage> {
  final _dataSource = TaskTimeRemoteDataSourceImpl(dio: DioClient.instance);

  bool _isLoading = true;
  List<TaskTimeLogModel> _logs = [];
  int _totalDuration = 0;

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    setState(() => _isLoading = true);

    try {
      final response = await _dataSource.getTaskTimeLogs(widget.taskId);

      if (mounted) {
        setState(() {
          _logs = (response['items'] as List)
              .map((item) => TaskTimeLogModel.fromJson(item))
              .toList();
          _totalDuration = response['total_duration'] ?? 0;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        SnackBarUtils.showError(context, 'Не удалось загрузить историю');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'История времени',
        leading: IconButton(
          icon: const Icon(Ionicons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with task title and total time
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.taskTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Ionicons.time,
                          size: 20,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Всего: ${_totalDuration.toFormattedDuration()}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Logs list
              Expanded(
                child: _isLoading
                    ? const LoadingState()
                    : _logs.isEmpty
                    ? EmptyState(
                        title: 'Нет записей',
                        subtitle:
                            'Запустите таймер чтобы начать отслеживать время',
                      )
                    : RefreshIndicator(
                        onRefresh: _loadLogs,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          itemCount: _logs.length,
                          itemBuilder: (context, index) {
                            final log = _logs[index];
                            return _TimeLogCard(
                              log: log,
                              onDelete: () async {
                                await _dataSource.deleteTimeLog(log.id);
                                _loadLogs();
                                if (mounted) {
                                  SnackBarUtils.showSuccess(
                                    context,
                                    'Запись удалена',
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeLogCard extends StatelessWidget {
  final TaskTimeLogModel log;
  final VoidCallback onDelete;

  const _TimeLogCard({required this.log, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm', 'ru');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceColor.withOpacity(0.5) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.08),
        ),
      ),
      child: Row(
        children: [
          // Duration icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: log.isActive
                  ? AppTheme.primaryGradient
                  : LinearGradient(
                      colors: [Colors.grey.shade400, Colors.grey.shade500],
                    ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                log.isActive ? '⏱️' : '✓',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log.duration?.toFormattedDuration() ??
                      (log.isActive ? 'Идет...' : '0s'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: log.isActive
                        ? AppTheme.primaryColor
                        : isDark
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dateFormat.format(log.startTime.toLocal()),
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? Colors.white.withOpacity(0.6)
                        : Colors.black54,
                  ),
                ),
                if (log.notes != null && log.notes!.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    log.notes!,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black54,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),

          // Delete button
          if (!log.isActive)
            IconButton(
              icon: const Icon(Ionicons.trash_outline, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Удалить запись?'),
                    content: const Text(
                      'Эта запись времени будет удалена безвозвратно.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Отмена'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onDelete();
                        },
                        child: const Text(
                          'Удалить',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
