import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class PaymentController extends GetxController {
  final RxString selectedPaymentMethod = 'QRIS Instant'.obs;
  final RxDouble subtotal = 500000.0.obs;
  final RxDouble discount = 0.0.obs;

  final voucherController = TextEditingController();
  final RxBool isVoucherApplied = false.obs;

  final RxInt treatmentStep = 0.obs; 
  // 0: Checkout Payment Selection, 1: Payment Verified, 2: Technician En Route, 3: Ready for Sign-Off

  final List<String> paymentMethods = [
    'QRIS Instant',
    'BCA Virtual Account',
    'Mandiri Virtual Account',
    'Transfer Bank Manual',
    'Tunai / Cash On Site',
  ];

  double get grandTotal => (subtotal.value - discount.value).clamp(0.0, double.infinity);

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void applyVoucher() {
    final code = voucherController.text.trim().toUpperCase();
    if (code == 'PROTECTFREE' || code.contains('PROMO')) {
      discount.value = 50000.0;
      isVoucherApplied.value = true;
      Get.snackbar(
        'Voucher Berhasil!',
        'Potongan harga Rp 50.000 berhasil diterapkan.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF059669),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Voucher Tidak Valid',
        'Gunakan kode voucher resmi (misal: PROTECTFREE)',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFF43F5E),
        colorText: Colors.white,
      );
    }
  }

  void processPayment() {
    treatmentStep.value = 1; // Verified

    Get.snackbar(
      'Pembayaran Berhasil!',
      'Metode ${selectedPaymentMethod.value} terverifikasi. Teknisi Bpk. Doni siap menuju lokasi.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );

    Future.delayed(const Duration(seconds: 2), () {
      treatmentStep.value = 2; // En route
    });

    Future.delayed(const Duration(seconds: 4), () {
      treatmentStep.value = 3; // Ready for Sign-Off
    });
  }

  void goToSignOffWarranty() {
    Get.toNamed(Routes.B2C_WARRANTY);
  }

  @override
  void onClose() {
    voucherController.dispose();
    super.onClose();
  }
}
