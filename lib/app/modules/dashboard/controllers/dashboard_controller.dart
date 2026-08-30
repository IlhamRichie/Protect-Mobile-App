import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class DashboardController extends GetxController {
  final RxString selectedFacility = 'Gudang Cikarang Plant 01'.obs;
  final RxString cameraStatusPill = '8/8 CCTVs Online'.obs;
  final RxDouble haccpScore = 98.5.obs;

  void openCameraSetup() {
    Get.toNamed(Routes.CAMERA_SETUP);
  }

  void openLiveFeed() {
    Get.toNamed(Routes.LIVE_FEED);
  }

  void openIncidentDetail() {
    Get.toNamed(Routes.INCIDENT_DETAIL);
  }

  void openExportHaccp() {
    Get.toNamed(Routes.EXPORT_HACCP);
  }

  void openProfile() {
    Get.toNamed(Routes.PROFILE);
  }
}
