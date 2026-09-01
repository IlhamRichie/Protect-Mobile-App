import 'package:get/get.dart';

class MainNavigationController extends GetxController {
  /// Index navigasi tab yang aktif (0: Dasbor, 1: Live Feed, 2: Log Insiden, 3: Alert Setup)
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Memeriksa argumen awal jika ada perpindahan tab spesifik dari luar halaman
    if (Get.arguments != null && Get.arguments is Map) {
      final initialTab = Get.arguments['initialTab'];
      if (initialTab != null && initialTab is int) {
        currentIndex.value = initialTab;
      }
    }
  }

  /// Mengubah tab navigasi aktif
  void changePage(int index) {
    if (index >= 0 && index <= 3) {
      currentIndex.value = index;
    }
  }
}