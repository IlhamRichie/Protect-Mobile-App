import 'package:get/get.dart';
import '../controllers/digital_warranty_controller.dart';

class DigitalWarrantyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DigitalWarrantyController>(
      () => DigitalWarrantyController(),
    );
  }
}
