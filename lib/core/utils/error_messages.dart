import 'package:dio/dio.dart';

class ErrorMessages {
  /// Получить понятное сообщение об ошибке
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    }
    
    return 'Произошла неизвестная ошибка';
  }
  
  /// Обработка ошибок Dio
  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Превышено время ожидания подключения';
      
      case DioExceptionType.sendTimeout:
        return 'Превышено время ожидания отправки данных';
      
      case DioExceptionType.receiveTimeout:
        return 'Превышено время ожидания ответа от сервера';
      
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      
      case DioExceptionType.cancel:
        return 'Запрос был отменен';
      
      case DioExceptionType.connectionError:
        return 'Проблема с подключением к интернету';
      
      case DioExceptionType.badCertificate:
        return 'Ошибка сертификата безопасности';
      
      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') ?? false) {
          return 'Нет подключения к интернету';
        }
        return 'Не удалось подключиться к серверу';
    }
  }
  
  /// Обработка ошибок HTTP статусов
  static String _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    
    // Если есть detail от backend
    if (data is Map && data.containsKey('detail')) {
      final detail = data['detail'];
      
      // Если detail - строка
      if (detail is String) {
        return _translateBackendError(detail);
      }
      
      // Если detail - массив ошибок валидации (Pydantic)
      if (detail is List && detail.isNotEmpty) {
        final firstError = detail[0];
        if (firstError is Map && firstError.containsKey('msg')) {
          return 'Ошибка валидации: ${firstError['msg']}';
        }
      }
    }
    
    // Стандартные сообщения по статус-кодам
    switch (statusCode) {
      case 400:
        return 'Некорректные данные запроса';
      case 401:
        return 'Неверный email или пароль';
      case 403:
        return 'Доступ запрещен';
      case 404:
        return 'Запрашиваемый ресурс не найден';
      case 422:
        return 'Ошибка валидации данных';
      case 500:
        return 'Ошибка сервера. Попробуйте позже';
      case 503:
        return 'Сервис временно недоступен';
      default:
        return 'Ошибка сервера (код: $statusCode)';
    }
  }
  
  /// Перевод ошибок от backend на понятный язык
  static String _translateBackendError(String error) {
    final lowerError = error.toLowerCase();
    
    // Ошибки авторизации
    if (lowerError.contains('incorrect email or password')) {
      return 'Неверный email или пароль';
    }
    if (lowerError.contains('email already registered')) {
      return 'Этот email уже зарегистрирован';
    }
    if (lowerError.contains('username already taken')) {
      return 'Это имя пользователя уже занято';
    }
    if (lowerError.contains('not authenticated')) {
      return 'Требуется авторизация';
    }
    if (lowerError.contains('invalid token')) {
      return 'Недействительный токен. Войдите снова';
    }
    if (lowerError.contains('token expired')) {
      return 'Сессия истекла. Войдите снова';
    }
    
    // Ошибки валидации
    if (lowerError.contains('password') && lowerError.contains('short')) {
      return 'Пароль слишком короткий (минимум 6 символов)';
    }
    if (lowerError.contains('invalid email')) {
      return 'Неверный формат email';
    }
    if (lowerError.contains('username') && lowerError.contains('short')) {
      return 'Имя пользователя слишком короткое';
    }
    
    // Если не удалось распознать - возвращаем как есть
    return error;
  }
  
  /// Специфичные сообщения для разных экранов
  static String getAuthErrorMessage(dynamic error) {
    final message = getErrorMessage(error);
    
    // Если это ошибка подключения
    if (message.contains('подключени')) {
      return '$message\n\nУбедитесь, что backend запущен на http://localhost:8000';
    }
    
    return message;
  }
}

