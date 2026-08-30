import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraManagementController extends GetxController {
  final nameController = TextEditingController(text: 'CCTV-04 Storage Tepung');
  final rtspController = TextEditingController(text: 'rtsp://admin:pass@192.168.1.108:554/ch01');
  final selectedZone = 'Zone A2 Storage'.obs;

  final RxDouble lineYPosition = 180.0.obs; // Y=550 virtual line representation in pixels

  void updateLinePosition(double newY) {
    lineYPosition.value = newY.clamp(20.0, 240.0);
  }

  void saveCameraSetup() {
    Get.snackbar(
      'Konfigurasi Disimpan',
      'Kamera ${nameController.text} & Virtual Line Y=550 berhasil diaktifkan.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    rtspController.dispose();
    super.onClose();
  }
}
