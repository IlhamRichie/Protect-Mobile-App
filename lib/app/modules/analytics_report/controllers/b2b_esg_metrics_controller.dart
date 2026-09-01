import 'package:flutter/material.dart';
import 'package:get/get.dart';

class B2bEsgMetricsController extends GetxController {
  final RxDouble pesticideReductionRate = 62.4.obs; // %
  final RxDouble savedChemicalLiters = 148.5.obs; // Liters saved
  final RxDouble foodWasteSavedTons = 4.2.obs; // Tons of food saved
  final RxDouble co2OffsetKg = 890.0.obs; // kg CO2 equivalent offset

  final RxString selectedPeriod = 'Quarter 3 (2026)'.obs;
  final List<String> periods = ['Quarter 1 (2026)', 'Quarter 2 (2026)', 'Quarter 3 (2026)'];

  void exportEsgPdfReport() {
    Get.snackbar(
      'Export Laporan ESG',
      'Laporan Dampak Lingkungan ESG & Kepatuhan Keberlanjutan berhasil diunduh (PDF).',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
  }
}