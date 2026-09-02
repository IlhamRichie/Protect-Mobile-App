import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

/// SplashController — menangani smart auth routing berdasarkan session & role.
///
/// Alur:
///   isFirstInstall → ONBOARDING
///   !isLoggedIn    → LOGIN
///   role='b2b'     → DASHBOARD  (B2B Enterprise Flow)
///   role='technician' → TECHNICIAN_JOB_BOARD (Field Tech Flow)
///   role='b2c'     → MAIN_WRAPPER (B2C Retail Flow via IndexedStack)
///
/// TODO: Ganti simulasi dengan GetStorage / SharedPreferences untuk
///       membaca token dan role dari persistent storage.
class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _handleSmartAuthRouting();
  }

  void _handleSmartAuthRouting() async {
    await Future.delayed(const Duration(seconds: 2));

    // ── Simulasi Session Data ──────────────────────────────────────────────
    // Ganti dengan: final box = GetStorage(); bool isFirst = box.read('isFirstInstall') ?? true;
    const bool isFirstInstall = false;
    const bool isLoggedIn = true;
    const String userRole = 'b2c'; // 'b2c' | 'b2b' | 'technician'
    // ─────────────────────────────────────────────────────────────────────

    if (isFirstInstall) {
      Get.offAllNamed(Routes.ONBOARDING);
      return;
    }

    if (!isLoggedIn) {
      Get.offAllNamed(Routes.LOGIN);
      return;
    }

    // Direct Navigation Sesuai Role
    switch (userRole) {
      case 'b2b':
        Get.offAllNamed(Routes.DASHBOARD);
        break;
      case 'technician':
        Get.offAllNamed(Routes.TECHNICIAN_JOB_BOARD);
        break;
      case 'b2c':
      default:
        Get.offAllNamed(Routes.MAIN_WRAPPER);
        break;
    }
  }
}
