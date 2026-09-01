import 'dart:async';
import 'package:get/get.dart';

class LiveFeedController extends GetxController {
  // Telemetry HUD Metrics
  final RxString fps = '30'.obs;
  final RxString latency = '42ms'.obs;
  final RxString model = 'YOLOv11n IR-Adapted'.obs;

  // AI Detection State & Overlay Data
  final RxBool isBreachDetected = true.obs;
  final RxString detectedId = '042'.obs;
  final RxString detectedSpecies = 'Rattus norvegicus'.obs;
  final RxDouble confidence = 94.8.obs;

  // Real-time Stream Control States
  final RxBool isStreaming = true.obs;
  final RxBool isAudioMuted = true.obs;
  final RxString streamQuality = '1080p'.obs;

  Timer? _telemetryTimer;

  @override
  void onInit() {
    super.onInit();
    _startSimulatedTelemetry();
  }

  @override
  void onClose() {
    _telemetryTimer?.cancel();
    super.onClose();
  }

  /// Simulates real-time telemetry updates for FPS and Latency from RTSP stream
  void _startSimulatedTelemetry() {
    _telemetryTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!isStreaming.value) return;
      
      // Simulate slight network jitter
      final randomFps = 28 + (timer.tick % 4); // 28 - 31 FPS
      final randomLatency = 38 + (timer.tick % 8); // 38ms - 45ms
      
      fps.value = '$randomFps';
      latency.value = '${randomLatency}ms';
    });
  }

  void toggleStream() {
    isStreaming.value = !isStreaming.value;
  }

  void toggleAudio() {
    isAudioMuted.value = !isAudioMuted.value;
  }

  void changeQuality(String quality) {
    streamQuality.value = quality;
  }
}