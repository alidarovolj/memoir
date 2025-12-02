import 'package:intl/intl.dart';

/// Date utilities
class DateUtils {
  /// Format date to relative time (e.g., "2 hours ago")
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'год' : 'лет'} назад';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'месяц' : 'месяцев'} назад';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'день' : 'дней'} назад';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'час' : 'часов'} назад';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'минуту' : 'минут'} назад';
    } else {
      return 'только что';
    }
  }
  
  /// Format date to short string (e.g., "12 дек 2024")
  static String formatShortDate(DateTime dateTime) {
    return DateFormat('d MMM yyyy', 'ru').format(dateTime);
  }
  
  /// Format date to full string (e.g., "12 декабря 2024, 14:30")
  static String formatFullDate(DateTime dateTime) {
    return DateFormat('d MMMM yyyy, HH:mm', 'ru').format(dateTime);
  }
}

