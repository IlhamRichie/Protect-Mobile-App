import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/b2c_home_controller.dart';

class B2cHomeView extends GetView<B2cHomeController> {
  const B2cHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: controller.openProfile,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFFECFDF5),
                  child: Icon(Icons.person, color: AppTheme.primaryColor, size: 22),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Halo, Kak Siska!',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.darkSlate),
                ),
                SizedBox(height: 2),
                Text(
                  'Siap Melindungi Properti Anda',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Official Rectangular Logo Asset in AppBar
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'assets/logo_protect.png',
              height: 28,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppTheme.darkSlate),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Grid 4 Main Menu Icons (Pesanan, Profil, Artikel, Chat)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGridMenuItem(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Pesanan',
                  color: const Color(0xFF059669),
                  onTap: controller.openOrders,
                ),
                _buildGridMenuItem(
                  icon: Icons.person_outline,
                  label: 'Profil',
                  color: const Color(0xFF2563EB),
                  onTap: controller.openProfile,
                ),
                _buildGridMenuItem(
                  icon: Icons.article_outlined,
                  label: 'Artikel',
                  color: const Color(0xFFD97706),
                  onTap: controller.openArticles,
                ),
                _buildGridMenuItem(
                  icon: Icons.chat_bubble_outline,
                  label: 'Chat',
                  color: const Color(0xFF7C3AED),
                  onTap: controller.openCsConsultationChat,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // AI Monitoring CCTV Widget Card (Bridge to B2B)
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.videocam_outlined, color: AppTheme.primaryColor, size: 20),
                            SizedBox(width: 6),
                            Text('AI CCTV Monitoring Widget', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.darkSlate)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.emerald.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('Live CCTV Preview', style: TextStyle(color: AppTheme.primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Mock Stream Box
                    Container(
                      height: 110,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.videocam, color: Colors.white24, size: 36),
                              SizedBox(height: 4),
                              Text('ProViewAI CCTV Feed • Active', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(6)),
                              child: const Text('🔴 LIVE', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Akses Komersial & Industri', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                        TextButton(
                          onPressed: controller.openB2bCommandCenter,
                          child: const Text('Buka Full Dashboard →', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 11)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Special Promo Banner Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.stars, color: Colors.amberAccent, size: 18),
                      SizedBox(width: 6),
                      Text('PROMO SURVEY GRATIS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pesan Layanan Bebas Hama Bergaransi 12 Bulan',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: controller.openBookingWizard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('Pesan Layanan Sekarang →', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Popular Services Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Layanan Terpopuler', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkSlate)),
                TextButton(
                  onPressed: controller.openBookingWizard,
                  child: const Text('Lihat Semua', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Popular Services Cards List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.popularServices.length,
              itemBuilder: (context, index) {
                final service = controller.popularServices[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: service.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(service.icon, color: service.color, size: 24),
                    ),
                    title: Text(service.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Text(service.subtitle, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                        const SizedBox(height: 4),
                        Text(service.priceRange, style: TextStyle(color: service.color, fontWeight: FontWeight.bold, fontSize: 11)),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: controller.openBookingWizard,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: service.color,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      ),
                      child: const Text('Booking', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: controller.changeBottomNav,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondary,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildGridMenuItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.darkSlate)),
        ],
      ),
    );
  }
}