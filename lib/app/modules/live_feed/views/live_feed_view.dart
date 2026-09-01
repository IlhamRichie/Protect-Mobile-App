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
        elevation: 0,
        title: const Text(
          'Live Stream & AI Vision Overlay',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Full Video Viewport with AI Vision Overlay
            _buildStreamViewport(),

            // Top HUD Metric Bar Overlay
            _buildTopHudMetricBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildStreamViewport() {
    return Center(
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

            // Custom Painter AI Overlay Bounding Box & Boundary Line
            CustomPaint(
              size: Size.infinite,
              painter: _AiVisionOverlayPainter(),
            ),

            // Bounding Box Label Overlay
            _buildAiBoundingBoxLabel(),
          ],
        ),
      ),
    );
  }

  Widget _buildAiBoundingBoxLabel() {
    return Positioned(
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
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Obx(
          () => Text(
            '[ID #${controller.detectedId.value}] ${controller.detectedSpecies.value} (${controller.confidence.value}%)',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopHudMetricBar() {
    return Positioned(
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
              _buildHudItem(
                label: 'FPS',
                value: '${controller.fps.value}',
                color: AppTheme.secondaryColor,
              ),
              _buildHudItem(
                label: 'Latency',
                value: controller.latency.value,
                color: AppTheme.warningColor,
              ),
              _buildHudItem(
                label: 'Model',
                value: controller.model.value,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHudItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '$label: $value',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
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

    // AI Bounding Box
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