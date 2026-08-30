import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final RxInt selectedAuthTab = 0.obs; // 0: B2C, 1: Enterprise B2B

  // B2C Inputs
  final phoneController = TextEditingController(text: '81234567890');
  final referralController = TextEditingController(text: 'PROTECTFREE');
  final RxBool isReferralExpanded = false.obs;

  // B2B Enterprise Inputs
  final corporateEmailController = TextEditingController(text: 'qa.manager@pangansejahtera.com');
  final passwordController = TextEditingController(text: '12345678');
  final RxBool isPasswordObscured = true.obs;

  void switchTab(int index) {
    selectedAuthTab.value = index;
  }

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void loginB2cWhatsApp() {
    final phone = phoneController.text.trim();
    if (phone.isEmpty) {
      Get.snackbar(
        'Peringatan',
        'Masukkan nomor WhatsApp Anda',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }
    Get.snackbar(
      'Login Berhasil',
      'Masuk sebagai Retail User (+62 $phone)',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
    Get.offNamed(Routes.B2C_HOME);
  }

  void loginB2cGoogle() {
    Get.snackbar(
      'Google SSO',
      'Terhubung via Akun Google Auth',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
    Get.offNamed(Routes.B2C_HOME);
  }

  void loginB2bEnterprise() {
    final email = corporateEmailController.text.trim().toLowerCase();
    if (!email.contains('@') || (!email.endsWith('pangansejahtera.com') && !email.contains('enterprise'))) {
      Get.snackbar(
        'Akses SSO Ditolak',
        'Harap gunakan Email Perusahaan Resmi (misal: @pangansejahtera.com)',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFF43F5E),
        colorText: Colors.white,
      );
      return;
    }
    Get.snackbar(
      'Enterprise SSO Success',
      'Selamat datang di ProViewAI Command Center',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
    Get.offNamed(Routes.DASHBOARD);
  }

  void openFieldTechMode() {
    Get.snackbar(
      'Field Tech Portal',
      'Membuka Layanan Teknisi Lapangan...',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF3B82F6),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
    Get.offNamed(Routes.TECHNICIAN_JOB_BOARD);
  }

  @override
  void onClose() {
    phoneController.dispose();
    referralController.dispose();
    corporateEmailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
