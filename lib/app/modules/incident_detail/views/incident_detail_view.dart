import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/incident_detail_controller.dart';

class IncidentDetailView extends GetView<IncidentDetailController> {
  const IncidentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Incident Breach Detail'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Alert Banner (Soft Red Card #FFF1F2, border #F43F5E)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.dangerBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.dangerColor),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: AppTheme.dangerColor, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text('🚨 BREACH INCIDENT DETECTED (${controller.incidentId.value})', style: const TextStyle(color: AppTheme.dangerColor, fontWeight: FontWeight.bold, fontSize: 13))),
                        const SizedBox(height: 2),
                        const Text('Terdeteksi objek hama melintasi Virtual Line Y=550 (<1s E-Tilang Alert)', style: TextStyle(fontSize: 11, color: AppTheme.darkSlate)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Captured Snapshot Frame
            const Text('Captured Snapshot Crop Evidence', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),

            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.crop, color: Colors.white38, size: 48),
                      SizedBox(height: 8),
                      Text('HIGH-RES CROP IMAGE EVIDENCE', style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.dangerColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Obx(() => Text('AI Confidence: ${controller.confidence.value}%', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Data Grid Table
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildDataRow('Timestamp Insiden', controller.timestamp.value),
                    const Divider(height: 20),
                    _buildDataRow('Zona / Area', controller.zone.value),
                    const Divider(height: 20),
                    _buildDataRow('Sumber Kamera', controller.camera.value),
                    const Divider(height: 20),
                    _buildDataRow('AI Model Confidence', '${controller.confidence.value}% (High Accuracy)'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: controller.dispatchWaShiftJaga,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppTheme.primaryColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.send_outlined, size: 18, color: AppTheme.primaryColor),
                    label: const Text('Dispatch WA Shift', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: controller.openResolveTicket,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: const Icon(Icons.build_outlined, size: 18),
                    label: const Text('Mark as Resolved', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.darkSlate),
          ),
        ),
      ],
    );
  }
}
