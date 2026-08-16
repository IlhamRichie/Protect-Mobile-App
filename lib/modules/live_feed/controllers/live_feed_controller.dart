import 'package:get/get.dart';

class LiveFeedController extends GetxController {
  final RxInt gridCount = 4.obs; // Default 4 cameras

  void changeGrid(int count) {
    gridCount.value = count;
  }
}
