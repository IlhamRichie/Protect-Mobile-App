import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ServiceCatalogItem {
  final String id;
  final String title;
  final String subtitle;
  final String priceRange;
  final IconData icon;
  final Color color;

  ServiceCatalogItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.priceRange,
    required this.icon,
    required this.color,
  });
}

class B2cHomeController extends GetxController {
  final RxInt selectedBottomNav = 0.obs;

  final List<ServiceCatalogItem> popularServices = [
    ServiceCatalogItem(
      id: 'termite',
      title: 'Termite Control Specialist',
      subtitle: 'Sistem umpan Exterra & injeksi chemical barrier',
      priceRange: 'Free Survey Lokasi',
      icon: Icons.bug_report_outlined,
      color: const Color(0xFFD97706),
    ),
    ServiceCatalogItem(
      id: 'rodent',
      title: 'Rodent & Rat Control',
      subtitle: 'Pengendalian tikus area pemukiman & kantor',
      priceRange: 'Mulai Rp 350rb',
      icon: Icons.pest_control_outlined,
      color: const Color(0xFFDC2626),
    ),
  ];

  void openBookingWizard() {
    Get.toNamed(Routes.BOOKING_SERVICE);
  }

  void openOrders() {
    Get.toNamed(Routes.B2C_ORDERS);
  }

  void openProfile() {
    Get.toNamed(Routes.PROFILE);
  }

  void openArticles() {
    Get.toNamed(Routes.ARTICLES);
  }

  void openCsConsultationChat() {
    Get.toNamed(Routes.B2C_CHAT);
  }

  void openDigitalWarrantyPage() {
    Get.toNamed(Routes.B2C_WARRANTY);
  }

  void openB2bCommandCenter() {
    Get.toNamed(Routes.DASHBOARD);
  }

  void changeBottomNav(int index) {
    if (index == 0) return;
    if (index == 1) openOrders();
    if (index == 2) Get.toNamed(Routes.B2C_TRACKER);
    if (index == 3) openProfile();
  }
}
