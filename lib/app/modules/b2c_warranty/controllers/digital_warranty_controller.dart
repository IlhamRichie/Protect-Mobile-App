import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DigitalWarrantyController extends GetxController {
  final RxString certId = 'CERT-2026-88912'.obs;
  final RxString clientName = 'Bpk. Hendra Kurniawan'.obs;
  final RxString propertyAddress = 'Jl. Raya Kebayoran Baru No. 45, Jakarta Selatan'.obs;

  void downloadPdfCertificate() {
    Get.snackbar(
      'Unduh Berkas',
      'Mengunduh E-Sertifikat Garansi PDF ($certId)...',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
  }

  void bookingRoutineControl() {
    Get.snackbar(
      'Booking Kontrol Rutin',
      'Jadwal kontrol rutin 3 bulanan berhasil diajukan untuk $clientName',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
  }
}
