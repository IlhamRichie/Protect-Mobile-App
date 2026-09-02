import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/data_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'roi_editor_screen.dart';
import 'alert_settings_screen.dart';

class CameraManagementScreen extends StatefulWidget {
  const CameraManagementScreen({super.key});

  @override
  State<CameraManagementScreen> createState() => _CameraManagementScreenState();
}

class _CameraManagementScreenState extends State<CameraManagementScreen> {
  late List<CameraItem> _cameras;

  @override
  void initState() {
    super.initState();
    _cameras = SampleData.getInitialCameras();
  }

  void _showAddCameraDialog() {
    final nameController = TextEditingController();
    final rtspController = TextEditingController(text: 'rtsp://192.168.1.104:554/live/stream1');
    final locController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Tambah Kamera RTSP Edge AI', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Kamera (ex: CCTV-04)'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: rtspController,
                decoration: const InputDecoration(labelText: 'RTSP Stream URL'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: locController,
                decoration: const InputDecoration(labelText: 'Lokasi Area / Ruangan'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal')),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    _cameras.add(CameraItem(
                      id: 'cam_${DateTime.now().millisecondsSinceEpoch}',
                      name: nameController.text,
                      rtspUrl: rtspController.text,
                      location: locController.text.isEmpty ? 'Area Baru' : locController.text,
                      status: 'Online • 30 FPS',
                      fps: 30,
                      resolution: '1080p FHD',
                      sensitivity: 0.85,
                      isAiActive: true,
                    ));
                  });
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.emerald600),
              child: const Text('Tambah Kamera', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Manajemen Kamera & RTSP Edge'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active, color: AppColors.darkSlate900),
            tooltip: 'Pengaturan Alert',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AlertSettingsScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCameraDialog,
        backgroundColor: AppColors.emerald600,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Tambah CCTV', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const InfoBanner(
            text: 'Kelola streaming CCTV lokal onvif/RTSP Anda untuk integrasi model YOLO-Pest sub-second boundary detection.',
            icon: Icons.videocam,
          ),
          const SizedBox(height: 16),

          ..._cameras.map((cam) => Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cam.name,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.darkSlate900),
                    ),
                    StatusBadge(
                      text: cam.status,
                      backgroundColor: AppColors.emerald50,
                      textColor: AppColors.emerald700,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Lokasi: ${cam.location}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                Text('Stream: ${cam.rtspUrl}', style: const TextStyle(fontSize: 11, fontFamily: 'monospace', color: AppColors.textMuted)),
                const Divider(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('AI Object Detection', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Switch(
                      value: cam.isAiActive,
                      onChanged: (val) => setState(() => cam.isAiActive = val),
                      activeColor: AppColors.emerald600,
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sensitivitas AI: ${(cam.sensitivity * 100).toInt()}%', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const RoiEditorScreen()),
                        );
                      },
                      icon: const Icon(Icons.crop, size: 14),
                      label: const Text('Edit ROI', style: TextStyle(fontSize: 11)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.emerald600,
                        side: const BorderSide(color: AppColors.emerald600),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
