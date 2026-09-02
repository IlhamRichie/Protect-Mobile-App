import 'package:get/get.dart';
import '../controllers/main_wrapper_controller.dart';
import '../../b2c_home/controllers/b2c_home_controller.dart';
import '../../b2c_orders/controllers/orders_controller.dart';
import '../../b2c_tracker/controllers/live_tracker_controller.dart';
import '../../profile/controllers/profile_controller.dart';

/// Binding untuk MainWrapperView — mendaftarkan semua controller tab B2C sekaligus
/// agar IndexedStack bisa render semua tab tanpa perlu route navigation.
class MainWrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainWrapperController>(() => MainWrapperController());
    Get.lazyPut<B2cHomeController>(() => B2cHomeController());
    Get.lazyPut<OrdersController>(() => OrdersController());
    Get.lazyPut<LiveTrackerController>(() => LiveTrackerController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
