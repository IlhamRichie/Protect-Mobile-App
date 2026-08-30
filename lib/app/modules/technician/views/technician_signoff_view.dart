import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/technician_controller.dart';

class TechnicianSignoffView extends GetView<TechnicianController> {
  const TechnicianSignoffView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Client Digital Sign-Off'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tanda Tangan Berita Acara Klien', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Klien membubuhkan tanda tangan digital langsung di atas layar HP teknisi', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            const SizedBox(height: 16),

            // Signature Canvas Box (Interactive Gesture Signature Pad representation)
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.primaryColor, width: 1.5),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size.infinite,
                    painter: _SignaturePadPainter(),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 12,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh, size: 14, color: AppTheme.textSecondary),
                      label: const Text('Bersihkan Canvas', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Summary Table Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ringkasan Bahan & Garansi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const Divider(height: 20),
                    _buildRow('Bahan Kimia Terpakai', 'Fipronil 2.5L + Exterra Bait'),
                    const SizedBox(height: 8),
                    _buildRow('Durasi Garansi', '12 Bulan Bebas Hama Active'),
                    const SizedBox(height: 8),
                    _buildRow('Teknisi Penanggung Jawab', 'Doni Prasetyo (TECH-8821)'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Submit CTA Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.completeJobAndIssueCertificate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: const Icon(Icons.check_circle, color: Colors.white, size: 20),
                label: const Text('✅ Selesaikan Pekerjaan & Terbitkan Sertifikat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.darkSlate)),
      ],
    );
  }
}

class _SignaturePadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.darkSlate
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 0.25, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.2, size.width * 0.55, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.8, size.width * 0.8, size.height * 0.45);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
