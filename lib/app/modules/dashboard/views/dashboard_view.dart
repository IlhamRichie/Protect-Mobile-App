import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            // Facility Selector Dropdown
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.business, color: AppTheme.primaryColor, size: 18),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Gudang Cikarang Plant 01 ▼',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.darkSlate),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Camera Status Pill Widget
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.emerald50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.primaryColor),
              ),
              child: Row(
                children: const [
                  Icon(Icons.videocam, color: AppTheme.primaryColor, size: 14),
                  SizedBox(width: 4),
                  Text(
                    '8/8 Online',
                    style: TextStyle(color: AppTheme.primaryColor, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: AppTheme.darkSlate),
            onPressed: controller.openProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Summary Cards (Horizontal Scroll View)
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  // Card 1: HACCP Score
                  _buildKpiCard(
                    title: 'HACCP Compliance',
                    value: '98.5%',
                    subtitle: 'Audit Ready',
                    icon: Icons.verified_user,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(width: 12),
                  // Card 2: Active Breaches
                  _buildKpiCard(
                    title: 'Active Breaches',
                    value: '0 Active',
                    subtitle: '1 Resolved Today',
                    icon: Icons.shield_outlined,
                    color: AppTheme.emerald600,
                  ),
                  const SizedBox(width: 12),
                  // Card 3: Chemical Cut
                  _buildKpiCard(
                    title: 'Chemical Reduction',
                    value: '-62%',
                    subtitle: 'ESG Target Passed',
                    icon: Icons.eco_outlined,
                    color: const Color(0xFF0D9488),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions Bar
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: controller.openCameraSetup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.video_call, size: 18),
                    label: const Text('Setup Camera', style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: controller.openExportHaccp,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: AppTheme.primaryColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.file_download, size: 18, color: AppTheme.primaryColor),
                    label: const Text('HACCP PDF', style: TextStyle(color: AppTheme.primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Analytics Preview Chart Mockup Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Tren Penurunan Deteksi Hama (30 Hari)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text('-84% Detection', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Line Chart Representation Box
                    Container(
                      height: 120,
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.borderColor),
                      ),
                      child: CustomPaint(
                        painter: _TrendChartPainter(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Live Incident Feed Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Live Incident Feed (CCTV ProViewAI)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text('Realtime', style: TextStyle(color: AppTheme.primaryColor, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),

            // Live Incident Cards
            InkWell(
              onTap: controller.openIncidentDetail,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppTheme.dangerBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTheme.dangerColor.withOpacity(0.3)),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.warning_amber_rounded, color: AppTheme.dangerColor, size: 24),
                            Text('CCTV-04', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.dangerColor)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('CAM-04 Storage Tepung', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            SizedBox(height: 2),
                            Text('02:14:05 WIB • Zone A2 Steril Boundary', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.dangerBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('NEED ACTION', style: TextStyle(color: AppTheme.dangerColor, fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppTheme.emerald50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline, color: AppTheme.primaryColor, size: 24),
                          Text('CCTV-02', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('CAM-02 Loading Dock B', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 2),
                          Text('Yesterday 18:30 WIB • Resolved by Staff', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.emerald50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('RESOLVED', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 10)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: const [BoxShadow(color: Color(0x06000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary, fontWeight: FontWeight.w600)),
              Icon(icon, color: color, size: 18),
            ],
          ),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          Text(subtitle, style: const TextStyle(fontSize: 10, color: AppTheme.darkSlate)),
        ],
      ),
    );
  }
}

class _TrendChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.4, size.width * 0.6, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.85, size.width, size.height * 0.9);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
