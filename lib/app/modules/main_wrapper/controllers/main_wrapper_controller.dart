import 'package:get/get.dart';

/// Controller untuk MainWrapperView — mengelola index tab aktif B2C BottomNavBar.
/// Solusi anti-looping: tidak pakai Get.toNamed() saat pindah tab, cukup ubah index.
class MainWrapperController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    if (index >= 0 && index <= 3) {
      currentIndex.value = index;
    }
  }
}
