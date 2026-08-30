import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class OnboardingItem {
  final String title;
  final String description;
  final String badgeText;
  final IconData icon;
  final Color themeColor;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.badgeText,
    required this.icon,
    required this.themeColor,
  });
}

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingItem> slides = [
    OnboardingItem(
      title: 'Deteksi AI Otonom 24/7',
      description:
          'Retrofit kamera CCTV lama Anda tanpa beli perangkat hardware baru (\$0 CapEx). Memantau steril zone 24/7 latensi <80ms.',
      badgeText: 'B2B ENTERPRISE AI',
      icon: Icons.videocam_outlined,
      themeColor: const Color(0xFF059669),
    ),
    OnboardingItem(
      title: 'Pest Control Consultative',
      description:
          'Konsultasi CS mudah via foto/video lokasi. Dapatkan jaminan Free On-Site Survey (S&K) & Garansi Bebas Hama 12 Bulan.',
      badgeText: 'B2C RETAIL PEST CONTROL',
      icon: Icons.home_work_outlined,
      themeColor: const Color(0xFF10B981),
    ),
    OnboardingItem(
      title: 'Zero E-Waste & Eco-Friendly',
      description:
          'Dukung keberlanjutan ESG perusahaan Anda dengan reduksi hingga 60% penggunaan bahan racun kimia berbahaya pada lingkungan.',
      badgeText: 'SUSTAINABILITY & ESG',
      icon: Icons.eco_outlined,
      themeColor: const Color(0xFF0D9488),
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < slides.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      finishOnboarding();
    }
  }

  void finishOnboarding() {
    Get.offNamed(Routes.LOGIN);
  }
}
