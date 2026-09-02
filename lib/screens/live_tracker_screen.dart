import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'cs_chat_screen.dart';

class LiveTrackerScreen extends StatefulWidget {
  const LiveTrackerScreen({super.key});

  @override
  State<LiveTrackerScreen> createState() => _LiveTrackerScreenState();
}

class _LiveTrackerScreenState extends State<LiveTrackerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Live GPS Dispatch Tracker'),
      ),
      body: Column(
        children: [
          // Interactive GPS Canvas Map
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              color: const Color(0xFFE2E8F0),
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return CustomPaint(
                        size: Size.infinite,
                        painter: GpsMapPainter(pulseValue: _pulseController.value),
                      );
                    },
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.emerald50,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.navigation, color: AppColors.emerald600, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Estimasi Kedatangan (ETA): 12 Menit', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.darkSlate900)),
                                Text('Jarak 2.4 km • Menuju Senopati Hub', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Technician Panel
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                border: const Border(top: BorderSide(color: AppColors.borderColor)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: AppColors.emerald600,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(Icons.person, color: Colors.white, size: 28),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Doni Pratama',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.darkSlate900),
                            ),
                            Text(
                              'Senior PCO Specialist • Lisensi Kemenkes',
                              style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '⭐ 4.9 / 5.0 (148 Treatment Selesai)',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFD97706)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Menghubungkan panggilan ke teknisi Doni (+62 812-3456-7890)...')),
                            );
                          },
                          icon: const Icon(Icons.phone, size: 16),
                          label: const Text('Telepon'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.emerald600,
                            side: const BorderSide(color: AppColors.emerald600),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const CsChatScreen()),
                            );
                          },
                          icon: const Icon(Icons.chat, size: 16, color: Colors.white),
                          label: const Text('Chat Teknisi', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.emerald600,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GpsMapPainter extends CustomPainter {
  final double pulseValue;

  GpsMapPainter({required this.pulseValue});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw simplified map roads
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke;

    final roadPath = Path()
      ..moveTo(0, size.height * 0.3)
      ..lineTo(size.width * 0.4, size.height * 0.3)
      ..lineTo(size.width * 0.4, size.height * 0.7)
      ..lineTo(size.width, size.height * 0.7);

    canvas.drawPath(roadPath, roadPaint);

    final roadOutline = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(roadPath, roadOutline);

    // Draw active GPS navigation line
    final navPaint = Paint()
      ..color = AppColors.emerald600
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final navPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.3)
      ..lineTo(size.width * 0.4, size.height * 0.3)
      ..lineTo(size.width * 0.4, size.height * 0.6);

    canvas.drawPath(navPath, navPaint);

    // Destination Pin
    final destPinCenter = Offset(size.width * 0.4, size.height * 0.6);
    final pinPaint = Paint()..color = AppColors.danger;
    canvas.drawCircle(destPinCenter, 10, pinPaint);
    canvas.drawCircle(destPinCenter, 4, Paint()..color = Colors.white);

    // Moving Technician Vehicle Marker
    final techPos = Offset(size.width * 0.25, size.height * 0.3);
    final pulsePaint = Paint()
      ..color = AppColors.emerald600.withOpacity(0.3 * (1 - pulseValue))
      ..style = PaintingStyle.fill;
    canvas.drawCircle(techPos, 24 * (0.8 + pulseValue * 0.4), pulsePaint);

    final techMarker = Paint()..color = AppColors.emerald600;
    canvas.drawCircle(techPos, 12, techMarker);
    canvas.drawCircle(techPos, 5, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant GpsMapPainter oldDelegate) => true;
}
