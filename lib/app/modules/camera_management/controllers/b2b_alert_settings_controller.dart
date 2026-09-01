import 'package:flutter/material.dart';
import 'package:get/get.dart';

class B2bAlertSettingsController extends GetxController {
  final waNumberController = TextEditingController(text: '081299887766');
  final webhookUrlController = TextEditingController(text: 'https://api.pangansejahtera.com/v1/alerts/webhook');

  final RxBool isWaAlertEnabled = true.obs;
  final RxBool isAutoDispatchEnabled = true.obs;
  final RxBool isSoundSirenEnabled = false.obs;

  void testWaAlert() {
    Get.snackbar(
      'Uji Coba WhatsApp Alert',
      'Pesan uji coba E-Tilang berhasil dikirimkan ke nomor +62 ${waNumberController.text}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
  }

  void saveAlertSettings() {
    Get.snackbar(
      'Integrasi Disimpan',
      'Pengaturan WhatsApp Sub-Second Alert & Webhook Dispatch diperbarui!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
    Get.back();
  }

  @override
  void onClose() {
    waNumberController.dispose();
    webhookUrlController.dispose();
    super.onClose();
  }
}