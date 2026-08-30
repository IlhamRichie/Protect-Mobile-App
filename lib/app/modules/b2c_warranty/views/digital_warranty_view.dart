import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../../routes/app_pages.dart';
import '../controllers/digital_warranty_controller.dart';

class DigitalWarrantyView extends GetView<DigitalWarrantyController> {
  const DigitalWarrantyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Digital E-Certificate'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Exclusive Certificate Card with Gold Emerald Gradient Border
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFFD97706), AppTheme.primaryColor, Color(0xFF10B981)],
                ),
                boxShadow: const [BoxShadow(color: Color(0x15000000), blurRadius: 20, offset: Offset(0, 8))],
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21),
                ),
                child: Column(
                  children: [
                    // Certificate Header & Rectangular Logo Watermark
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/logo_protect.png',
                          height: 36,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Row(
                            children: const [
                              Icon(Icons.shield, color: AppTheme.primaryColor, size: 28),
                              SizedBox(width: 8),
                              Text('PROTECT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.amber),
                          ),
                          child: const Text('VERIFIED OFFICIAL', style: TextStyle(color: Colors.amber, fontSize: 9, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const Divider(height: 32),

                    const Text(
                      'E-SERTIFIKAT BEBAS HAMA & GARANSI RESMI',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppTheme.darkSlate, letterSpacing: 0.8),
                    ),
                    const SizedBox(height: 4),
                    Obx(() => Text(controller.certId.value, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary, fontWeight: FontWeight.bold))),
                    const SizedBox(height: 20),

                    const Text('Diberikan Kepada:', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                    const SizedBox(height: 2),
                    Obx(() => Text(controller.clientName.value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryColor))),
                    const SizedBox(height: 4),
                    Obx(() => Text(controller.propertyAddress.value, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: AppTheme.darkSlate))),
                    const SizedBox(height: 20),

                    // Guarantee Badges
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.emerald.shade50,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: const [
                              Text('Masa Garansi', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                              SizedBox(height: 2),
                              Text('12 Bulan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.primaryColor)),
                            ],
                          ),
                          Container(width: 1, height: 24, color: Colors.grey.shade300),
                          Column(
                            children: const [
                              Text('Tipe Pest Control', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                              SizedBox(height: 2),
                              Text('Termite Barrier', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.darkSlate)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // QR Code Widget
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.borderColor),
                      ),
                      child: Column(
                        children: const [
                          Icon(Icons.qr_code_2, size: 100, color: AppTheme.darkSlate),
                          SizedBox(height: 4),
                          Text('Pindai untuk verifikasi garansi resmi', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.downloadPdfCertificate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.download, size: 20),
                label: const Text('Unduh Sertifikat PDF', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: controller.bookingRoutineControl,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: AppTheme.primaryColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.calendar_today, size: 18, color: AppTheme.primaryColor),
                label: const Text('Booking Kontrol Rutin Gratis', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Orders/Warranty tab active
        onTap: (index) {
          if (index == 0) Get.offAllNamed(Routes.B2C_HOME);
          if (index == 1) Get.toNamed(Routes.B2C_ORDERS);
          if (index == 2) Get.toNamed(Routes.B2C_TRACKER);
          if (index == 3) Get.toNamed(Routes.PROFILE);
        },
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondary,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
