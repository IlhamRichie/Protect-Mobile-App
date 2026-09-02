import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/sample_data.dart';
import '../models/data_models.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'booking_screen.dart';
import 'live_tracker_screen.dart';
import 'digital_warranty_screen.dart';
import 'cs_chat_screen.dart';
import 'incident_detail_screen.dart';
import 'export_haccp_screen.dart';
import 'camera_management_screen.dart';
import 'esg_metrics_screen.dart';
import 'technician_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isB2bMode = true;
  final NumberFormat _currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    // Look up AppState from ancestor if provided or use sample singleton
    final activeIncidents = SampleData.getInitialIncidents().where((i) => i.status != IncidentStatus.resolved).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.emerald600,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.shield, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PROTECT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    color: AppColors.darkSlate900,
                  ),
                ),
                Text(
                  _isB2bMode ? 'Enterprise HACCP Mode' : 'Residential Care',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.emerald700,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.support_agent, color: AppColors.darkSlate900),
            tooltip: 'Layanan CS 24/7',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CsChatScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.engineering, color: AppColors.emerald600),
            tooltip: 'Mode Teknisi',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const TechnicianJobBoardScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Location and Switcher Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: AppColors.emerald600),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Lokasi Terpilih:',
                          style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                        ),
                        Text(
                          'Central Kitchen - Senopati Hub',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.darkSlate900),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      _isB2bMode ? 'B2B' : 'B2C',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _isB2bMode ? AppColors.emerald700 : AppColors.darkSlate900,
                      ),
                    ),
                    Switch(
                      value: _isB2bMode,
                      onChanged: (val) => setState(() => _isB2bMode = val),
                      activeColor: AppColors.emerald600,
                      activeTrackColor: AppColors.emerald100,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Active Breach Card
          if (activeIncidents.isNotEmpty) ...[
            Container(
              decoration: BoxDecoration(
                color: AppColors.dangerBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.danger.withOpacity(0.4)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.danger.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => IncidentDetailScreen(incidentId: activeIncidents.first.id),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppColors.danger,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'DETEKSI INTRUSI HAMA AKTIF',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.danger,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            StatusBadge(
                              text: 'AKURASI ${activeIncidents.first.confidence}%',
                              backgroundColor: AppColors.danger.withOpacity(0.1),
                              textColor: AppColors.danger,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          activeIncidents.first.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkSlate900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.videocam, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              activeIncidents.first.cameraName,
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              activeIncidents.first.timestamp,
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Buka Analisa Gambar & Tindakan SOP',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.danger,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.danger),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Quick Actions Grid (8 Actions)
          const SectionHeader(title: 'Pusat Operasional & Kontrol'),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              _buildQuickActionButton(
                icon: Icons.location_on,
                label: 'Lacak Teknisi',
                color: AppColors.emerald600,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LiveTrackerScreen()),
                ),
              ),
              _buildQuickActionButton(
                icon: Icons.verified,
                label: 'E-Garansi',
                color: AppColors.emerald700,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DigitalWarrantyScreen()),
                ),
              ),
              _buildQuickActionButton(
                icon: Icons.picture_as_pdf,
                label: 'Audit HACCP',
                color: const Color(0xFF0284C7),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ExportHaccpScreen()),
                ),
              ),
              _buildQuickActionButton(
                icon: Icons.eco,
                label: 'Skor ESG',
                color: const Color(0xFF059669),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const B2bEsgMetricsScreen()),
                ),
              ),
              _buildQuickActionButton(
                icon: Icons.videocam,
                label: 'Kelola CCTV',
                color: const Color(0xFF7C3AED),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CameraManagementScreen()),
                ),
              ),
              _buildQuickActionButton(
                icon: Icons.engineering,
                label: 'Tugas Lapangan',
                color: const Color(0xFFD97706),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TechnicianJobBoardScreen()),
                ),
              ),
              _buildQuickActionButton(
                icon: Icons.chat_bubble_outline,
                label: 'Tanya CS',
                color: const Color(0xFF2563EB),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CsChatScreen()),
                ),
              ),
              _buildQuickActionButton(
                icon: Icons.add_task,
                label: 'Pesan Jasa',
                color: AppColors.emerald600,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BookingScreen(service: SampleData.services.first),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Active Order Preview
          const SectionHeader(title: 'Pesanan Sedang Berjalan'),
          const SizedBox(height: 8),
          Container(
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
                    const Text(
                      'ORD-8821-JKT',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        color: AppColors.emerald600,
                      ),
                    ),
                    const StatusBadge(
                      text: 'TEKNISI MENUJU LOKASI',
                      backgroundColor: AppColors.emerald50,
                      textColor: AppColors.emerald700,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Termite Control Specialist',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.darkSlate900),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Teknisi: Doni Pratama (Senior PCO Specialist)',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const LiveTrackerScreen()),
                          );
                        },
                        icon: const Icon(Icons.map, size: 16),
                        label: const Text('Buka Live GPS'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.emerald600,
                          side: const BorderSide(color: AppColors.emerald600),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Services Catalog
          const SectionHeader(title: 'Katalog Layanan Unggulan'),
          const SizedBox(height: 8),
          ...SampleData.services.map((service) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          service.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkSlate900,
                          ),
                        ),
                      ),
                      Text(
                        _currencyFormat.format(service.price),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.emerald600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    service.subtitle,
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const StatusBadge(
                        text: 'GARANSI 12 BULAN',
                        backgroundColor: AppColors.emerald50,
                        textColor: AppColors.emerald700,
                        icon: Icons.verified_user,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => BookingScreen(service: service)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.emerald600,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        ),
                        child: const Text('Pesan Layanan', style: TextStyle(fontSize: 12, color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.darkSlate900,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
