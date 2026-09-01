import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ResolveTicketController extends GetxController {
  final notesController = TextEditingController(text: 'Perangkap mekanis terpasang di celah dinding utara Zone A2.');

  void submitResolution() {
    Get.snackbar(
      'Tiket Insiden Selesai',
      'Verifikasi penanganan lapangan berhasil disimpan. Status tiket diubah ke RESOLVED.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
    Get.offAllNamed(Routes.DASHBOARD);
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }
}
