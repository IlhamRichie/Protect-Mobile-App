import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TechnicianChemicalLogController extends GetxController {
  final RxString selectedAgent = 'Exterra Eco-Bait Matrix (Termite)'.obs;
  final dosageController = TextEditingController(text: '150');
  final RxString selectedUnit = 'Gram'.obs;
  final notesController = TextEditingController();

  final List<String> ecoAgents = [
    'Exterra Eco-Bait Matrix (Termite)',
    'Fipronil Low-Dose Microencapsulated (2.5L)',
    'Biorational Rodent Block (Non-Toxic Eco)',
  ];

  final List<String> units = ['Gram', 'Milliliter', 'Liter'];

  void submitChemicalLog() {
    if (dosageController.text.isEmpty) {
      Get.snackbar('Input Error', 'Harap masukkan takaran dosis bahan.', backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    Get.snackbar(
      'Log ESG Berhasil Ditambahkan',
      'Penggunaan ${dosageController.text} ${selectedUnit.value} ${selectedAgent.value} tercatat di Server Audit ESG!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
    Get.back();
  }

  @override
  void onClose() {
    dosageController.dispose();
    notesController.dispose();
    super.onClose();
  }
}