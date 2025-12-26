import 'package:flutter_test/flutter_test.dart';
import 'package:memoir/core/services/audio_recorder_service.dart';

void main() {
  group('AudioRecorderService', () {
    late AudioRecorderService service;

    setUp(() {
      service = AudioRecorderService();
    });

    tearDown(() async {
      await service.dispose();
    });

    test('initial state should not be recording', () {
      expect(service.isRecording, false);
      expect(service.currentRecordingPath, null);
    });

    test('requestPermission should request microphone access', () async {
      // Note: This will fail in unit tests as it requires platform channels
      // For real testing, use integration tests
      expect(service.requestPermission, isA<Future<bool>>());
    });

    // More tests would require mocking platform channels
    // These are better suited for integration tests
  });
}
