import 'package:get/get.dart';

import '../controllers/incident_log_controller.dart';

class IncidentLogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncidentLogController>(
      () => IncidentLogController(),
    );
  }
}
