import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class AudioRecorderService {
  final AudioRecorder _recorder = AudioRecorder();
  String? _currentRecordingPath;
  bool _isRecording = false;

  bool get isRecording => _isRecording;
  String? get currentRecordingPath => _currentRecordingPath;

  /// Проверка и запрос разрешения на запись аудио
  Future<bool> requestPermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  /// Начать запись
  Future<bool> startRecording() async {
    try {
      // Проверяем разрешение
      if (!await requestPermission()) {
        print('❌ [AUDIO] Microphone permission denied');
        return false;
      }

      // Проверяем поддержку кодека
      if (!await _recorder.hasPermission()) {
        print('❌ [AUDIO] No recording permission');
        return false;
      }

      // Создаем директорию для временных файлов
      final dir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      _currentRecordingPath = '${dir.path}/audio_$timestamp.m4a';

      // Начинаем запись
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc, // AAC для iOS/Android
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: _currentRecordingPath!,
      );

      _isRecording = true;
      print('🎙️ [AUDIO] Recording started: $_currentRecordingPath');
      return true;
    } catch (e) {
      print('❌ [AUDIO] Error starting recording: $e');
      return false;
    }
  }

  /// Остановить запись
  Future<String?> stopRecording() async {
    try {
      if (!_isRecording) {
        print('⚠️ [AUDIO] Not recording');
        return null;
      }

      final path = await _recorder.stop();
      _isRecording = false;

      if (path != null) {
        final file = File(path);
        if (await file.exists()) {
          final size = await file.length();
          print('✅ [AUDIO] Recording stopped: $path (${size / 1024} KB)');
          return path;
        }
      }

      print('⚠️ [AUDIO] Recording file not found');
      return null;
    } catch (e) {
      print('❌ [AUDIO] Error stopping recording: $e');
      _isRecording = false;
      return null;
    }
  }

  /// Отменить запись и удалить файл
  Future<void> cancelRecording() async {
    try {
      if (_isRecording) {
        await _recorder.stop();
        _isRecording = false;
      }

      if (_currentRecordingPath != null) {
        final file = File(_currentRecordingPath!);
        if (await file.exists()) {
          await file.delete();
          print('🗑️ [AUDIO] Recording cancelled and deleted');
        }
        _currentRecordingPath = null;
      }
    } catch (e) {
      print('❌ [AUDIO] Error cancelling recording: $e');
    }
  }

  /// Получить амплитуду (для визуализации)
  Stream<Amplitude> get amplitudeStream =>
      _recorder.onAmplitudeChanged(const Duration(milliseconds: 200));

  /// Очистка ресурсов
  Future<void> dispose() async {
    if (_isRecording) {
      await cancelRecording();
    }
    await _recorder.dispose();
  }
}
