import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class RoiEditorScreen extends StatefulWidget {
  const RoiEditorScreen({super.key});

  @override
  State<RoiEditorScreen> createState() => _RoiEditorScreenState();
}

class _RoiEditorScreenState extends State<RoiEditorScreen> {
  List<Offset> _points = [
    const Offset(0.20, 0.25),
    const Offset(0.80, 0.25),
    const Offset(0.85, 0.75),
    const Offset(0.15, 0.75),
  ];

  bool _isSaved = false;

  void _resetPoints() {
    setState(() {
      _points = [
        const Offset(0.20, 0.25),
        const Offset(0.80, 0.25),
        const Offset(0.85, 0.75),
        const Offset(0.15, 0.75),
      ];
      _isSaved = false;
    });
  }

  void _savePolygon() {
    setState(() => _isSaved = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Konfigurasi Poligon ROI berhasil disimpan dan disinkronkan ke gateway CCTV!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Editor Poligon ROI AI Vision'),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          border: const Border(top: BorderSide(color: AppColors.borderColor)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _resetPoints,
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Reset Default'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkSlate900,
                    side: const BorderSide(color: AppColors.borderColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _savePolygon,
                  icon: const Icon(Icons.save, color: Colors.white, size: 16),
                  label: const Text('Simpan Poligon', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.emerald600,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const InfoBanner(
              text: 'Ketuk pada kanvas video di bawah untuk menambahkan atau menyesuaikan titik batas deteksi zona kritis (ROI). AI hanya akan membunyikan alarm saat hama melintasi area ini.',
              icon: Icons.touch_app,
            ),
            const SizedBox(height: 14),

            if (_isSaved) ...[
              const InfoBanner(
                text: 'Zona Poligon Baru Telah Aktif pada model YOLO-Pest!',
                icon: Icons.check_circle,
              ),
              const SizedBox(height: 14),
            ],

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.darkSlate900,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.emerald600, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return GestureDetector(
                            onTapDown: (details) {
                              if (_points.length < 8) {
                                final localPos = details.localPosition;
                                final normX = (localPos.dx / constraints.maxWidth).clamp(0.0, 1.0);
                                final normY = (localPos.dy / constraints.maxHeight).clamp(0.0, 1.0);
                                setState(() {
                                  _points.add(Offset(normX, normY));
                                  _isSaved = false;
                                });
                              }
                            },
                            child: CustomPaint(
                              size: Size(constraints.maxWidth, constraints.maxHeight),
                              painter: PolygonRoiPainter(points: _points),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Titik Sudut Aktif: ${_points.length} (Maks 8)',
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PolygonRoiPainter extends CustomPainter {
  final List<Offset> points;

  PolygonRoiPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final path = Path();
    final first = Offset(points[0].dx * size.width, points[0].dy * size.height);
    path.moveTo(first.dx, first.dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx * size.width, points[i].dy * size.height);
    }
    path.close();

    // Fill translucent area
    final fillPaint = Paint()
      ..color = AppColors.emerald500.withOpacity(0.25)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // Stroke border
    final strokePaint = Paint()
      ..color = AppColors.emerald400
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, strokePaint);

    // Draw anchor points
    for (final pt in points) {
      final pos = Offset(pt.dx * size.width, pt.dy * size.height);
      canvas.drawCircle(pos, 8, Paint()..color = AppColors.emerald300);
      canvas.drawCircle(pos, 4, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant PolygonRoiPainter oldDelegate) => true;
}
