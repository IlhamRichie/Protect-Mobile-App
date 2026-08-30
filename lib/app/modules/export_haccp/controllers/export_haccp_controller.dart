import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExportHaccpController extends GetxController {
  final RxString dateRange = '01 Ags 2026 - 31 Ags 2026'.obs;
  final RxBool isHaccpChecked = true.obs;
  final RxBool isIsoChecked = true.obs;
  final RxBool isEsgChecked = true.obs;

  void exportOfficialPdf() {
    Get.snackbar(
      'Mengekspor Berkas',
      'Mengunduh Laporan Resmi HACCP & ESG Audit Log (PDF)...',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
