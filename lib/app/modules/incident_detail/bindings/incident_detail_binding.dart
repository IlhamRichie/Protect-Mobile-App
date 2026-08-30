import 'package:get/get.dart';
import '../controllers/incident_detail_controller.dart';

class IncidentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncidentDetailController>(
      () => IncidentDetailController(),
    );
  }
}
