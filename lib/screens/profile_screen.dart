import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'alert_settings_screen.dart';
import 'roi_editor_screen.dart';
import 'esg_metrics_screen.dart';
import 'export_haccp_screen.dart';
import 'camera_management_screen.dart';
import 'technician_screens.dart';
import 'cs_chat_screen.dart';
import 'digital_warranty_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Akun & Pengaturan Enterprise'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: AppColors.emerald600,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'BH',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Budi Hartono',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkSlate900),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Facility & QA Manager • PT Boga Lestari',
                        style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                      SizedBox(height: 4),
                      StatusBadge(
                        text: 'ENTERPRISE TIER V.IP',
                        backgroundColor: AppColors.emerald50,
                        textColor: AppColors.emerald700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Menu Sections
          const SectionHeader(title: 'Konfigurasi Sistem AI & Alert'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  icon: Icons.notifications_active,
                  title: 'Pengaturan Notifikasi & Webhook Alert',
                  subtitle: 'Telegram, Slack, Email & REST Webhook',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AlertSettingsScreen()),
                  ),
                ),
                const Divider(height: 1),
                _buildMenuItem(
                  icon: Icons.crop,
                  title: 'Editor Poligon ROI AI Vision',
                  subtitle: 'Atur koordinat zona kritis deteksi hama',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RoiEditorScreen()),
                  ),
                ),
                const Divider(height: 1),
                _buildMenuItem(
                  icon: Icons.videocam,
                  title: 'Kelola Kamera Edge RTSP',
                  subtitle: 'Daftar CCTV dan kalibrasi sensitivitas',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CameraManagementScreen()),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const SectionHeader(title: 'Audit, Laporan & ESG'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  icon: Icons.picture_as_pdf,
                  title: 'Ekspor Laporan Audit HACCP',
                  subtitle: 'Unduh PDF, Excel, dan sertifikasi digital',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ExportHaccpScreen()),
                  ),
                ),
                const Divider(height: 1),
                _buildMenuItem(
                  icon: Icons.eco,
                  title: 'Skor Keberlanjutan & Metrik ESG',
                  subtitle: 'Reduksi jejak kimia dan emisi karbon',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const B2bEsgMetricsScreen()),
                  ),
                ),
                const Divider(height: 1),
                _buildMenuItem(
                  icon: Icons.verified,
                  title: 'Sertifikat E-Garansi 12 Bulan',
                  subtitle: 'Klaim inspeksi dan perlindungan ulang',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const DigitalWarrantyScreen()),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const SectionHeader(title: 'Operasional Lapangan & Bantuan'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  icon: Icons.engineering,
                  title: 'Portal Teknisi Lapangan (PCO)',
                  subtitle: 'Checklist APD, Chemical Log & E-Sign TTD',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const TechnicianJobBoardScreen()),
                  ),
                ),
                const Divider(height: 1),
                _buildMenuItem(
                  icon: Icons.chat_bubble_outline,
                  title: 'Bantuan Customer Service 24/7',
                  subtitle: 'Hubungi konsultan entomologi & support',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CsChatScreen()),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Logout Button
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Anda tetap masuk dalam sesi aman PROTECT Enterprise.')),
              );
            },
            icon: const Icon(Icons.logout, color: AppColors.danger, size: 18),
            label: const Text('Keluar dari Sesi', style: TextStyle(color: AppColors.danger)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.danger),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'PROTECT Enterprise Mobile v1.2.0 • Build 2026',
              style: TextStyle(fontSize: 11, color: AppColors.textMuted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppColors.emerald50,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: AppColors.emerald600),
      ),
      title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.darkSlate900)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textMuted),
    );
  }
}
