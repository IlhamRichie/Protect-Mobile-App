import 'dart:math';
import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'roi_editor_screen.dart';
import 'camera_management_screen.dart';

class LiveFeedScreen extends StatefulWidget {
  const LiveFeedScreen({super.key});

  @override
  State<LiveFeedScreen> createState() => _LiveFeedScreenState();
}

class _LiveFeedScreenState extends State<LiveFeedScreen> with SingleTickerProviderStateMixin {
  int _selectedCameraIndex = 0;
  bool _showBoundingBox = true;
  bool _isSnapshotExported = false;

  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cameras = SampleData.getInitialCameras();
    final currentCam = cameras[_selectedCameraIndex];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Live CCTV Edge AI Vision'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.darkSlate900),
            tooltip: 'Kelola Kamera',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CameraManagementScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.crop, color: AppColors.emerald600),
            tooltip: 'Editor Polygon ROI',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const RoiEditorScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Camera Switcher Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(cameras.length, (idx) {
                final isSelected = _selectedCameraIndex == idx;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cameras[idx].name),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _selectedCameraIndex = idx),
                    selectedColor: AppColors.emerald600,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    backgroundColor: AppColors.surfaceLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? AppColors.emerald600 : AppColors.borderColor,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 14),

          // High-Tech CCTV Viewport Container with AI Overlay
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.darkSlate900,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.emerald600, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  // Animated Scanning Grid
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _animController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: CctvOverlayPainter(
                            showBox: _showBoundingBox,
                            animValue: _animController.value,
                          ),
                        );
                      },
                    ),
                  ),

                  // Top HUD Overlay
                  Positioned(
                    top: 12,
                    left: 12,
                    right: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.danger,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'REC • LIVE RTSP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.emerald900.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.emerald500),
                          ),
                          child: const Text(
                            'AI YOLO-Pest: AKTIF',
                            style: TextStyle(
                              color: AppColors.emerald300,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom HUD Overlay
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${currentCam.location} | 30 FPS | 18ms',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                            fontFamily: 'monospace',
                          ),
                        ),
                        InkWell(
                          onTap: () => setState(() => _showBoundingBox = !_showBoundingBox),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _showBoundingBox ? 'Hide AI BBox' : 'Show AI BBox',
                              style: const TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Telemetry Cards
          Row(
            children: [
              Expanded(
                child: _buildTelemetryCard('Spesies Terdeteksi', 'Rattus Norvegicus', Icons.bug_report, AppColors.danger),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildTelemetryCard('Confidence AI', '98.4%', Icons.auto_awesome, AppColors.emerald600),
              ),
            ],
          ),
          const SizedBox(height: 14),

          if (_isSnapshotExported) ...[
            const InfoBanner(
              text: 'Snapshot beresolusi tinggi dengan metadata E-Tilang berhasil diunduh ke galeri.',
              icon: Icons.check_circle,
            ),
            const SizedBox(height: 14),
          ],

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RoiEditorScreen()),
                    );
                  },
                  icon: const Icon(Icons.crop, size: 16),
                  label: const Text('Ubah Poligon ROI'),
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
                    setState(() => _isSnapshotExported = true);
                  },
                  icon: const Icon(Icons.camera, size: 16, color: Colors.white),
                  label: const Text('Export Bukti Foto', style: TextStyle(color: Colors.white)),
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
    );
  }

  Widget _buildTelemetryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CctvOverlayPainter extends CustomPainter {
  final bool showBox;
  final double animValue;

  CctvOverlayPainter({required this.showBox, required this.animValue});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw subtle grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double j = 0; j < size.height; j += 40) {
      canvas.drawLine(Offset(0, j), Offset(size.width, j), gridPaint);
    }

    // Draw tripwire intrusion boundary line
    final tripwirePaint = Paint()
      ..color = AppColors.warning.withOpacity(0.8)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.7),
      Offset(size.width * 0.9, size.height * 0.7),
      tripwirePaint,
    );

    if (showBox) {
      final boxRect = Rect.fromLTWH(
        size.width * 0.35,
        size.height * 0.38,
        size.width * 0.30,
        size.height * 0.32,
      );

      final boxPaint = Paint()
        ..color = AppColors.danger
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawRect(boxRect, boxPaint);

      // Label background
      final labelPaint = Paint()..color = AppColors.danger;
      canvas.drawRect(
        Rect.fromLTWH(boxRect.left, boxRect.top - 18, 140, 18),
        labelPaint,
      );

      final textSpan = const TextSpan(
        text: ' [#89] Rattus Norv. 98% ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(boxRect.left + 2, boxRect.top - 16));
    }
  }

  @override
  bool shouldRepaint(covariant CctvOverlayPainter oldDelegate) => true;
}
