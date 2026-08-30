import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class PestCategory {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  PestCategory({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class BookingController extends GetxController {
  // Step 1: Pest Category Selection & B2B Commercial Code
  final RxString selectedPestId = 'termite'.obs;
  final facilityCodeController = TextEditingController(text: 'FAC-2024');
  final RxBool isB2bUnlocked = false.obs;

  final List<PestCategory> pestCategories = [
    PestCategory(
      id: 'termite',
      title: 'Termite Control',
      subtitle: 'Pengendalian rayap kayu & tanah',
      icon: Icons.bug_report_outlined,
      color: const Color(0xFFD97706),
    ),
    PestCategory(
      id: 'mosquito',
      title: 'Mosquito & Fogging',
      subtitle: 'Pengasapan nyamuk & serangga',
      icon: Icons.cloud_outlined,
      color: const Color(0xFF2563EB),
    ),
    PestCategory(
      id: 'rodent',
      title: 'Rodent & Rat Control',
      subtitle: 'Perangkap tikus pemukiman',
      icon: Icons.pest_control_outlined,
      color: const Color(0xFFDC2626),
    ),
    PestCategory(
      id: 'general',
      title: 'General Pest Control',
      subtitle: 'Disinfeksi kuman & serangga umum',
      icon: Icons.sanitizer_outlined,
      color: const Color(0xFF7C3AED),
    ),
  ];

  // Step 2: Address Selection & New Address Form
  final RxString selectedSavedAddress = 'Rumah'.obs; // 'Rumah' or 'Kantor'
  final fullAddressController = TextEditingController(text: 'Jl. Raya Kebayoran Baru No. 45');
  final unitNoController = TextEditingController(text: 'Blok B3 No. 12');
  final postalCodeController = TextEditingController(text: '12150');
  final notesController = TextEditingController(text: 'Pagar warna hitam, ada anjing di halaman');
  final RxString mapPinLocation = 'Tebet, Jakarta Selatan (-6.2297, 106.8466)'.obs;

  // Step 3: Date & Time Slot Selection
  final Rx<DateTime> selectedDate = DateTime.now().add(const Duration(days: 1)).obs;
  final RxString selectedTimeSlot = '10:00 WIB'.obs;

  final List<String> availableTimeSlots = [
    '09:00 WIB',
    '11:00 WIB',
    '14:00 WIB',
    '16:00 WIB',
  ];

  double get servicePrice => 500000.0;

  void selectPestCategory(String id) {
    selectedPestId.value = id;
  }

  void verifyFacilityCode() {
    final code = facilityCodeController.text.trim().toUpperCase();
    if (code == 'FAC-2024' || code.contains('FAC')) {
      isB2bUnlocked.value = true;
      Get.snackbar(
        'Kode Terverifikasi!',
        'Fitur B2B Commercial AI CCTV Monitoring berhasil diaktifkan.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF059669),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } else {
      Get.snackbar(
        'Kode Tidak Valid',
        'Masukkan kode fasilitas komersial resmi (misal: FAC-2024).',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFF43F5E),
        colorText: Colors.white,
      );
    }
  }

  void goToAddressStep() {
    Get.toNamed(Routes.BOOKING_ADDRESS);
  }

  void goToScheduleStep() {
    Get.toNamed(Routes.BOOKING_SCHEDULE);
  }

  void confirmBookingAndProceedPayment() {
    Get.toNamed(
      Routes.B2C_PAYMENT,
      arguments: {'amount': servicePrice},
    );
  }

  void openB2bCommandCenter() {
    Get.toNamed(Routes.DASHBOARD);
  }

  @override
  void onClose() {
    facilityCodeController.dispose();
    fullAddressController.dispose();
    unitNoController.dispose();
    postalCodeController.dispose();
    notesController.dispose();
    super.onClose();
  }
}
