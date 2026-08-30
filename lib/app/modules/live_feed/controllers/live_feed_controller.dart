import 'package:get/get.dart';

class LiveFeedController extends GetxController {
  final RxString fps = '30'.obs;
  final RxString latency = '42ms'.obs;
  final RxString model = 'YOLOv11n IR-Adapted'.obs;

  final RxBool isBreachDetected = true.obs;
}
