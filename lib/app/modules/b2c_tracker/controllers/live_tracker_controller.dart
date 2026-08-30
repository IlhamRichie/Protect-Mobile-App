import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class LiveTrackerController extends GetxController {
  final RxString techName = 'Bpk. Doni Prasetyo'.obs;
  final RxString licensePlate = 'B 4910 TEK'.obs;
  final RxInt etaMinutes = 12.obs;
  final RxInt currentStatusIndex = 0.obs; // 0: Di Jalan, 1: Tiba di Lokasi, 2: Treatment Action

  void callTechnician() {
    Get.snackbar(
      'Hubungi Teknisi',
      'Menghubungkan telepon ke Bpk. Doni (0812-9988-7766)',
      snackPosition: SnackPosition.TOP,
    );
  }

  void openWhatsApp() {
    Get.snackbar(
      'WhatsApp Chat',
      'Membuka percakapan WhatsApp dengan Bpk. Doni',
      snackPosition: SnackPosition.TOP,
    );
  }

  void goToWarranty() {
    Get.toNamed(Routes.B2C_WARRANTY);
  }
}
