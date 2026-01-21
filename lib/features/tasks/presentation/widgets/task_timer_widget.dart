import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/tasks/data/datasources/task_time_remote_datasource.dart';
import 'package:memoir/features/tasks/data/models/task_time_log_model.dart';

class TaskTimerWidget extends StatefulWidget {
  final String taskId;
  final bool isActiveInitially;
  final VoidCallback? onTimerStateChanged;

  const TaskTimerWidget({
    super.key,
    required this.taskId,
    this.isActiveInitially = false,
    this.onTimerStateChanged,
  });

  @override
  State<TaskTimerWidget> createState() => _TaskTimerWidgetState();
}

class _TaskTimerWidgetState extends State<TaskTimerWidget> {
  final _dataSource = TaskTimeRemoteDataSourceImpl(dio: DioClient.instance);

  bool _isActive = false;
  int _elapsedSeconds = 0;
  Timer? _timer;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isActive = widget.isActiveInitially;
    if (_isActive) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsedSeconds++;
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _handleStartStop() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      if (_isActive) {
        // Stop tracking
        final log = await _dataSource.stopTimeTracking(widget.taskId);
        _stopTimer();

        if (mounted) {
          setState(() {
            _isActive = false;
            _elapsedSeconds = 0;
          });

          SnackBarUtils.showSuccess(
            context,
            'Время остановлено: ${log.duration?.toFormattedDuration() ?? '0s'}',
          );

          widget.onTimerStateChanged?.call();
        }
      } else {
        // Start tracking
        await _dataSource.startTimeTracking(widget.taskId);
        _startTimer();

        if (mounted) {
          setState(() {
            _isActive = true;
            _elapsedSeconds = 0;
          });

          SnackBarUtils.showSuccess(context, 'Таймер запущен');
          widget.onTimerStateChanged?.call();
        }
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.showError(
          context,
          'Ошибка: ${_isActive ? "не удалось остановить" : "не удалось запустить"} таймер',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: _isActive
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor.withOpacity(0.1),
                  AppTheme.accentColor.withOpacity(0.1),
                ],
              )
            : null,
        color: _isActive ? null : AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isActive
              ? AppTheme.primaryColor.withOpacity(0.3)
              : AppTheme.darkColor.withOpacity(0.1),
          width: _isActive ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Timer icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: _isActive
                  ? AppTheme.primaryGradient
                  : LinearGradient(
                      colors: [
                        AppTheme.darkColor.withOpacity(0.1),
                        AppTheme.darkColor.withOpacity(0.15),
                      ],
                    ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: _isActive
                  ? [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              _isActive ? Ionicons.time : Ionicons.time_outline,
              color: _isActive ? Colors.white : AppTheme.darkColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),

          // Time display
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _elapsedSeconds.toTimeFormat(),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: _isActive
                        ? AppTheme.primaryColor
                        : AppTheme.darkColor,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isActive ? 'Идет отсчет...' : 'Остановлено',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.darkColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),

          // Start/Stop button
          _isLoading
              ? const SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _isActive
                        ? Colors.red.withOpacity(0.1)
                        : AppTheme.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _handleStartStop,
                    icon: Icon(
                      _isActive
                          ? Ionicons.stop_circle
                          : Ionicons.play_circle,
                      size: 40,
                      color: _isActive ? Colors.red : AppTheme.primaryColor,
                    ),
                    tooltip: _isActive ? 'Остановить' : 'Запустить',
                  ),
                ),
        ],
      ),
    );
  }
}
