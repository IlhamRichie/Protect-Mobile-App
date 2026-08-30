import 'package:get/get.dart';
import '../controllers/resolve_ticket_controller.dart';

class ResolveTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResolveTicketController>(
      () => ResolveTicketController(),
    );
  }
}
