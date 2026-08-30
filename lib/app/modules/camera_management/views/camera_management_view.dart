import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/camera_management_controller.dart';

class CameraManagementView extends GetView<CameraManagementController> {
  const CameraManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Camera Setup & Calibration'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Konfigurasi Stream & Batas Steril', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Atur RTSP stream dan posisikan garis batas virtual Y=550 untuk deteksi AI E-Tilang', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            const SizedBox(height: 16),

            // Form Inputs
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        labelText: 'Nama Kamera CCTV',
                        prefixIcon: const Icon(Icons.videocam_outlined, color: AppTheme.primaryColor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: controller.rtspController,
                      decoration: InputDecoration(
                        labelText: 'RTSP Stream URL',
                        prefixIcon: const Icon(Icons.link, color: AppTheme.primaryColor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Interactive Canvas Preview Box (16:9 Ratio with Draggable Line Y=550)
            const Text('Interactive Virtual Boundary Calibration (Drag Y Line)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),

            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primaryColor, width: 2),
                ),
                child: Stack(
                  children: [
                    // Mock Stream Feed Viewport
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.videocam, color: Colors.white24, size: 48),
                          SizedBox(height: 8),
                          Text('LIVE RTSP CAMERA FEED PREVIEW', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                    // Draggable Virtual Boundary Line (Y=550)
                    Obx(
                      () => Positioned(
                        top: controller.lineYPosition.value,
                        left: 0,
                        right: 0,
                        child: GestureDetector(
                          onVerticalDragUpdate: (details) {
                            controller.updateLinePosition(controller.lineYPosition.value + details.delta.dy);
                          },
                          child: Container(
                            height: 26,
                            color: AppTheme.dangerColor.withOpacity(0.3),
                            child: Row(
                              children: const [
                                Icon(Icons.unfold_more, color: Colors.white, size: 18),
                                SizedBox(width: 6),
                                Text(
                                  '🔴 STERILE BOUNDARY ZONE Y=550 (DRAG TO CALIBRATE)',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Save CTA Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.saveCameraSetup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.save, color: Colors.white, size: 20),
                label: const Text('💾 Simpan & Aktifkan Monitoring AI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
