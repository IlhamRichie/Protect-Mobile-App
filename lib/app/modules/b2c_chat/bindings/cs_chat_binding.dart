import 'package:get/get.dart';
import '../controllers/cs_chat_controller.dart';

class CsChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CsChatController>(
      () => CsChatController(),
    );
  }
}
