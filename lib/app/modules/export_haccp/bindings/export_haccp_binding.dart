import 'package:get/get.dart';

import '../controllers/export_haccp_controller.dart';

class ExportHaccpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExportHaccpController>(
      () => ExportHaccpController(),
    );
  }
}
