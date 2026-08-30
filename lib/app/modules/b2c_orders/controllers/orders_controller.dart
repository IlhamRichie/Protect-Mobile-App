import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class B2cOrder {
  final String orderId;
  final String serviceTitle;
  final String date;
  final String status;
  final double price;

  B2cOrder({
    required this.orderId,
    required this.serviceTitle,
    required this.date,
    required this.status,
    required this.price,
  });
}

class OrdersController extends GetxController {
  final RxInt selectedTab = 0.obs; // 0: Aktif, 1: Riwayat

  final RxList<B2cOrder> activeOrders = <B2cOrder>[
    B2cOrder(
      orderId: 'ORD-20260830-01',
      serviceTitle: 'Termite Control Barrier',
      date: 'Hari ini • 10:00 WIB',
      status: 'Teknisi En Route',
      price: 500000,
    ),
  ].obs;

  final RxList<B2cOrder> pastOrders = <B2cOrder>[
    B2cOrder(
      orderId: 'ORD-20260715-88',
      serviceTitle: 'General Disinfection',
      date: '15 Juli 2026',
      status: 'Selesai',
      price: 300000,
    ),
  ].obs;

  void openTracker() {
    Get.toNamed(Routes.B2C_TRACKER);
  }

  void openWarranty() {
    Get.toNamed(Routes.B2C_WARRANTY);
  }
}
