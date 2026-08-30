import 'package:get/get.dart';
import '../controllers/digital_quote_controller.dart';

class DigitalQuoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DigitalQuoteController>(
      () => DigitalQuoteController(),
    );
  }
}
