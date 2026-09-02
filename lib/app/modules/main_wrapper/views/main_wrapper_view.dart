import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../../b2c_home/views/b2c_home_view.dart';
import '../../b2c_orders/views/orders_view.dart';
import '../../b2c_tracker/views/live_tracker_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/main_wrapper_controller.dart';

/// MainWrapperView — solusi anti-looping BottomNavBar untuk alur B2C.
///
/// Semua tab B2C dibungkus dalam satu IndexedStack sehingga state tidak
/// ter-destroy saat pindah tab dan tidak ada route push/pop yang menumpuk.
///
/// Struktur tab:
///   0 → B2cHomeView  (Home)
///   1 → OrdersView   (Orders)
///   2 → LiveTrackerView (Activity)
///   3 → ProfileView  (Profile)
class MainWrapperView extends GetView<MainWrapperController> {
  const MainWrapperView({super.key});

  @override
  Widget build(BuildContext context) {
    // Semua halaman tab diinisialisasi sekali — state tetap hidup saat tab berganti
    const pages = [
      B2cHomeView(),
      OrdersView(),
      LiveTrackerView(),
      ProfileView(),
    ];

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: AppTheme.textSecondary,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              activeIcon: Icon(Icons.storefront),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart_outlined),
              activeIcon: Icon(Icons.show_chart),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
