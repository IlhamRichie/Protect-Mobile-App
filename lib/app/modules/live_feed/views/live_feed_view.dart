import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/live_feed_controller.dart';

class LiveFeedView extends GetView<LiveFeedController> {
  const LiveFeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          'Live Stream & AI Vision Overlay',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Stack(
        children: [
          // Full Video Viewport
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFF0F172A),
              child: Stack(
                children: [
                  // Mock Camera Stream Background
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.videocam, color: Colors.white24, size: 80),
                        SizedBox(height: 12),
                        Text(
                          'RTSP STREAM 1080P • LIVE',
                          style: TextStyle(
                            color: Colors.white38,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Custom Painter AI Overlay Bounding Box
                  CustomPaint(
                    size: Size.infinite,
                    painter: _AiVisionOverlayPainter(),
                  ),

                  // Bounding Box Label Overlay
                  Positioned(
                    top: 180,
                    left: 120,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.dangerColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '[ID #042] Rattus norvegicus (94.8%)',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top HUD Metric Bar (Transparent Dark Overlay Bar)
          Positioned(
            top: 12,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white24),
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'FPS: ${controller.fps.value}',
                      style: const TextStyle(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Latency: ${controller.latency.value}',
                      style: const TextStyle(
                        color: AppTheme.warningColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Model: ${controller.model.value}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiVisionOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Virtual Line Y=550 (represented in scaled view)
    final linePaint = Paint()
      ..color = AppTheme.dangerColor
      ..strokeWidth = 3;

    canvas.drawLine(
      Offset(0, size.height * 0.55),
      Offset(size.width, size.height * 0.55),
      linePaint,
    );

    // AI Bounding Box Red Blinking
    final boxPaint = Paint()
      ..color = AppTheme.dangerColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    const rect = Rect.fromLTWH(115, 200, 150, 110);
    canvas.drawRect(rect, boxPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}