import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/live_tracker_controller.dart';

class LiveTrackerView extends GetView<LiveTrackerController> {
  const LiveTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Live GPS Tracker'),
      ),
      body: Stack(
        children: [
          // Top Half (60% Height): Map View Simulation
          Positioned.fill(
            bottom: MediaQuery.of(context).size.height * 0.35,
            child: Container(
              color: const Color(0xFFE5E7EB),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Map Grid Lines Mockup
                  CustomPaint(
                    size: Size.infinite,
                    painter: _MapGridPainter(),
                  ),

                  // Destination House Marker
                  Positioned(
                    top: 120,
                    right: 80,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.home, color: Colors.white, size: 24),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('Rumah Klien', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),

                  // Technician Moving Marker (Motor Icon)
                  Positioned(
                    bottom: 140,
                    left: 90,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.emerald600,
                            shape: BoxShape.circle,
                            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
                          ),
                          child: const Icon(Icons.two_wheeler, color: Colors.white, size: 24),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('Bpk. Doni (ETA 12 Min)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Sheet Floating Card (40% Height)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.38,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle Bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Profile & License Plate
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: AppTheme.primaryColor,
                        child: Icon(Icons.person, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text(controller.techName.value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                            const SizedBox(height: 2),
                            Obx(() => Text('Plat Motor: ${controller.licensePlate.value} • Honda Vario', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: controller.callTechnician,
                            icon: const Icon(Icons.call, color: AppTheme.primaryColor),
                          ),
                          IconButton(
                            onPressed: controller.openWhatsApp,
                            icon: const Icon(Icons.chat_bubble_outline, color: AppTheme.primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  // Timeline Progress
                  const Text('Timeline Penugasan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      _buildStatusNode('Di Jalan (ETA 12m)', isActive: true),
                      const Expanded(child: Divider(color: AppTheme.primaryColor, thickness: 2)),
                      _buildStatusNode('Tiba', isActive: false),
                      const Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                      _buildStatusNode('Tindakan', isActive: false),
                    ],
                  ),
                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.goToWarranty,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Buka E-Sertifikat Garansi'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusNode(String title, {required bool isActive}) {
    return Column(
      children: [
        Icon(
          isActive ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isActive ? AppTheme.primaryColor : Colors.grey,
          size: 18,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? AppTheme.primaryColor : Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 2;

    for (double i = 0; i < size.width; i += 60) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double j = 0; j < size.height; j += 60) {
      canvas.drawLine(Offset(0, j), Offset(size.width, j), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
