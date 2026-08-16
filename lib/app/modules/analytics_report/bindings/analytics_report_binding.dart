import 'package:get/get.dart';

import '../controllers/analytics_report_controller.dart';

class AnalyticsReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalyticsReportController>(
      () => AnalyticsReportController(),
    );
  }
}
