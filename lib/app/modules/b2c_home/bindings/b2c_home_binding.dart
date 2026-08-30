import 'package:get/get.dart';
import '../controllers/b2c_home_controller.dart';

class B2cHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<B2cHomeController>(
      () => B2cHomeController(),
    );
  }
}
