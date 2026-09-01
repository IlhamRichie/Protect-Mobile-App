import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class IncidentDetailController extends GetxController {
  final RxString incidentId = 'INC-1082'.obs;
  final RxString timestamp = '02:14:05 WIB'.obs;
  final RxString zone = 'Zone A2 Raw Material Storage'.obs;
  final RxString camera = 'CAM-04 Storage Tepung'.obs;
  final RxDouble confidence = 94.8.obs;

  void dispatchWaShiftJaga() {
    Get.snackbar(
      'Dispatch WA Shift Jaga',
      'Pesan peringatan E-Tilang terkirim ke WhatsApp Tim Shift Jaga Gudang.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
  }

  void openResolveTicket() {
    Get.toNamed(Routes.INCIDENT_RESOLVE);
  }
}
