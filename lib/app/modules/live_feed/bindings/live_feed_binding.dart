import 'package:get/get.dart';
import '../controllers/live_feed_controller.dart';

class LiveFeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveFeedController>(
      () => LiveFeedController(),
    );
  }
}
