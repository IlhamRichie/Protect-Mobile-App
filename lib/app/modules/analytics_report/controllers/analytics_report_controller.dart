import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalyticsReportController extends GetxController {
  final RxString selectedPeriod = '30 Hari Terakhir'.obs;
  final RxString selectedFacility = 'Gudang Cikarang Plant 01'.obs;

  final List<String> periods = [
    '7 Hari Terakhir',
    '30 Hari Terakhir',
    '3 Bulan Terakhir',
    'Tahun Ini'
  ];

  final List<String> facilities = [
    'Gudang Cikarang Plant 01',
    'Gudang Cikarang Plant 02',
    'Hub Logistik Surabaya'
  ];

  void exportReport(String format) {
    Get.snackbar(
      'Export Laporan',
      'Laporan Analitik ($format) berhasil diunduh.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
  }
}