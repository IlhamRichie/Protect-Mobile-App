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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;

            if (isTablet) {
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildMapView(context, isTablet),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(24),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: _buildBottomSheetContent(context, isTablet: true),
                      ),
                    ),
                  ),
                ],
              );
            }

            return Stack(
              children: [
                // Top Map Layer (Full Background)
                Positioned.fill(
                  child: _buildMapView(context, isTablet),
                ),

                // Floating Bottom Sheet Panel (Mobile)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildMobileBottomSheet(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMapView(BuildContext context, bool isTablet) {
    return Container(
      color: const Color(0xFFE5E7EB),
      child: LayoutBuilder(
        builder: (context, mapConstraints) {
          final w = mapConstraints.maxWidth;
          final h = mapConstraints.maxHeight;

          return Stack(
            children: [
              // Grid Line Custom Painter
              CustomPaint(
                size: Size.infinite,
                painter: _MapGridPainter(),
              ),

              // Destination House Marker (Relative Percent Positioning)
              Positioned(
                top: h * 0.18,
                right: w * 0.15,
                child: _buildMapMarker(
                  icon: Icons.home_rounded,
                  iconBgColor: AppTheme.primaryColor,
                  label: 'Rumah Klien',
                  labelBgColor: Colors.white,
                  textColor: AppTheme.darkSlate,
                ),
              ),

              // Technician Moving Marker (Relative Percent Positioning)
              Positioned(
                bottom: isTablet ? h * 0.25 : h * 0.42,
                left: w * 0.15,
                child: _buildMapMarker(
                  icon: Icons.two_wheeler_rounded,
                  iconBgColor: AppTheme.emerald600,
                  label: 'Bpk. Doni (ETA 12 Min)',
                  labelBgColor: AppTheme.primaryColor,
                  textColor: Colors.white,
                  showShadow: true,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMapMarker({
    required IconData icon,
    required Color iconBgColor,
    required String label,
    required Color labelBgColor,
    required Color textColor,
    bool showShadow = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
            boxShadow: showShadow
                ? const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: labelBgColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileBottomSheet(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            _buildBottomSheetContent(context, isTablet: false),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetContent(BuildContext context, {required bool isTablet}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Technician Profile & License Plate Header
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
                  Obx(
                    () => Text(
                      controller.techName.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppTheme.darkSlate,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Obx(
                    () => Text(
                      'Plat Motor: ${controller.licensePlate.value} • Honda Vario',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: controller.callTechnician,
                  icon: const Icon(Icons.call, color: AppTheme.primaryColor),
                  tooltip: 'Telepon Teknisi',
                ),
                IconButton(
                  onPressed: controller.openWhatsApp,
                  icon: const Icon(Icons.chat_bubble_outline, color: AppTheme.primaryColor),
                  tooltip: 'Chat WhatsApp',
                ),
              ],
            ),
          ],
        ),
        const Divider(height: 24),

        // Timeline Progress Section Header
        const Text(
          'Timeline Penugasan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: AppTheme.darkSlate,
          ),
        ),
        const SizedBox(height: 12),

        // Timeline Nodes Row
        Row(
          children: [
            Expanded(child: _buildStatusNode('Di Jalan (ETA 12m)', isActive: true)),
            const Expanded(child: Divider(color: AppTheme.primaryColor, thickness: 2)),
            Expanded(child: _buildStatusNode('Tiba', isActive: false)),
            const Expanded(child: Divider(color: Colors.grey, thickness: 1)),
            Expanded(child: _buildStatusNode('Tindakan', isActive: false)),
          ],
        ),
        const SizedBox(height: 24),

        // Action Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: controller.goToWarranty,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.workspace_premium_outlined, color: Colors.white, size: 18),
            label: const Text(
              'Buka E-Sertifikat Garansi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusNode(String title, {required bool isActive}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isActive ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isActive ? AppTheme.primaryColor : Colors.grey,
          size: 18,
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? AppTheme.primaryColor : Colors.grey,
            ),
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