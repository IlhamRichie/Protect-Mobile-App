import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/data_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'resolve_ticket_screen.dart';
import 'roi_editor_screen.dart';

class IncidentDetailScreen extends StatelessWidget {
  final String incidentId;

  const IncidentDetailScreen({super.key, required this.incidentId});

  @override
  Widget build(BuildContext context) {
    final incidents = SampleData.getInitialIncidents();
    final incident = incidents.firstWhere(
      (i) => i.id == incidentId || i.code == incidentId,
      orElse: () => incidents.first,
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Detail Analisa Temuan Hama'),
        actions: [
          IconButton(
            icon: const Icon(Icons.crop, color: AppColors.emerald600),
            tooltip: 'Edit Polygon ROI',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const RoiEditorScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          border: const Border(top: BorderSide(color: AppColors.borderColor)),
        ),
        child: SafeArea(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ResolveTicketScreen(incidentId: incident.id),
                ),
              );
            },
            icon: const Icon(Icons.assignment_turned_in, color: Colors.white),
            label: const Text('Tindak Lanjuti & Tutup Tiket HACCP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.emerald600,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Thermal / Snapshot Preview Container
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.darkSlate900,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.danger, width: 2),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bug_report, size: 54, color: AppColors.danger.withOpacity(0.8)),
                      const SizedBox(height: 8),
                      Text(
                        'SNAPSHOT TERMAL AI VISION (#${incident.code})',
                        style: const TextStyle(color: Colors.white70, fontSize: 11, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: StatusBadge(
                    text: 'AKURASI ${incident.confidence}%',
                    backgroundColor: AppColors.danger,
                    textColor: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      incident.timestamp,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Incident Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      incident.code,
                      style: const TextStyle(fontSize: 12, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: AppColors.emerald600),
                    ),
                    const StatusBadge(
                      text: 'PERLU TINDAKAN (HACCP CCP-1)',
                      backgroundColor: AppColors.dangerBackground,
                      textColor: AppColors.danger,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  incident.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkSlate900),
                ),
                const Divider(height: 24),
                _buildInfoRow('Spesies Taksonomi', incident.species),
                const SizedBox(height: 8),
                _buildInfoRow('Kamera Sumber', incident.cameraName),
                const SizedBox(height: 8),
                _buildInfoRow('Zona Deteksi (ROI)', incident.detectionZone),
                const SizedBox(height: 8),
                _buildInfoRow('Lokasi Fasilitas', incident.location),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // SOP Corrective Action
          const SectionHeader(title: 'Rekomendasi Tindakan Korektif (SOP)'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.lightbulb, size: 18, color: Color(0xFFD97706)),
                    SizedBox(width: 8),
                    Text(
                      'Rekomendasi AI IPM Standar 2026',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.darkSlate900),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  incident.recommendedAction,
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.darkSlate900)),
      ],
    );
  }
}
