import 'package:get/get.dart';
import '../controllers/live_tracker_controller.dart';

class LiveTrackerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveTrackerController>(
      () => LiveTrackerController(),
    );
  }
}
