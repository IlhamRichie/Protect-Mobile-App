import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../../../widgets/status_badge.dart';
import '../../../widgets/section_header.dart';
import '../controllers/technician_controller.dart';
import '../../../routes/app_pages.dart';

/// TechnicianSopView — Halaman SOP Digital Teknisi Lapangan.
///
/// Flow: TechnicianJobDetail → TechnicianSopView → TechChemicalLog → TechnicianSignoff
///
/// Fitur:
/// - Checklist APD (Alat Pelindung Diri) sebelum tindakan
/// - Pemeriksaan kondisi area/lingkungan
/// - Konfirmasi prosedur keselamatan kerja
/// - Tombol "Mulai Tindakan" yang hanya aktif jika semua checklist dicentang
class TechnicianSopView extends GetView<TechnicianController> {
  const TechnicianSopView({super.key});

  @override
  Widget build(BuildContext context) {
    // Checklist state lokal — dalam produksi bisa dipindah ke controller
    final RxList<bool> apdChecked = List.generate(5, (_) => false).obs;
    final RxList<bool> inspectionChecked = List.generate(4, (_) => false).obs;

    final apdItems = [
      'Masker N95 / Respirator terpasang',
      'Sarung tangan kimia (nitril) dipakai',
      'Kacamata pelindung / goggles aktif',
      'Baju hazmat / wearpack bersih',
      'Sepatu safety & boot pelindung',
    ];

    final inspectionItems = [
      'Area kerja bebas dari penghuni / tamu',
      'Ventilasi udara mencukupi (>3 ACH)',
      'Sumber air dan makanan sudah diamankan',
      'Titik evakuasi terdekat sudah diidentifikasi',
    ];

    bool allChecked() =>
        apdChecked.every((v) => v) && inspectionChecked.every((v) => v);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('SOP Digital Lapangan'),
        actions: [
          const StatusBadge(text: 'Pre-Treatment'),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;
            final double horizontalPadding = isTablet ? 24.0 : 16.0;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 850),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Info Banner
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppTheme.emerald50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.primaryColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.info_outline,
                                color: AppTheme.primaryColor, size: 18),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Pastikan SEMUA item checklist dicentang sebelum memulai tindakan penanganan hama.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ── Section 1: APD Checklist ──────────────────────────
                      SectionHeader(
                        title: '1. Alat Pelindung Diri (APD)',
                        actionTitle: 'Reset',
                        onActionTap: () {
                          for (var i = 0; i < apdChecked.length; i++) {
                            apdChecked[i] = false;
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      Card(
                        child: Obx(
                          () => Column(
                            children: List.generate(apdItems.length, (index) {
                              return CheckboxListTile(
                                value: apdChecked[index],
                                activeColor: AppTheme.primaryColor,
                                onChanged: (val) => apdChecked[index] = val ?? false,
                                title: Text(
                                  apdItems[index],
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: apdChecked[index]
                                        ? AppTheme.primaryColor
                                        : AppTheme.darkSlate,
                                    decoration: apdChecked[index]
                                        ? TextDecoration.none
                                        : null,
                                  ),
                                ),
                                secondary: Icon(
                                  Icons.safety_check_outlined,
                                  color: apdChecked[index]
                                      ? AppTheme.primaryColor
                                      : AppTheme.textSecondary,
                                  size: 20,
                                ),
                                shape: index < apdItems.length - 1
                                    ? const Border(
                                        bottom: BorderSide(
                                          color: AppTheme.borderColor,
                                        ),
                                      )
                                    : null,
                              );
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ── Section 2: Inspeksi Lokasi ───────────────────────
                      const SectionHeader(
                        title: '2. Pemeriksaan Kondisi Lokasi',
                      ),
                      const SizedBox(height: 12),
                      Card(
                        child: Obx(
                          () => Column(
                            children: List.generate(
                              inspectionItems.length,
                              (index) {
                                return CheckboxListTile(
                                  value: inspectionChecked[index],
                                  activeColor: AppTheme.primaryColor,
                                  onChanged: (val) =>
                                      inspectionChecked[index] = val ?? false,
                                  title: Text(
                                    inspectionItems[index],
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: inspectionChecked[index]
                                          ? AppTheme.primaryColor
                                          : AppTheme.darkSlate,
                                    ),
                                  ),
                                  secondary: Icon(
                                    Icons.search_outlined,
                                    color: inspectionChecked[index]
                                        ? AppTheme.primaryColor
                                        : AppTheme.textSecondary,
                                    size: 20,
                                  ),
                                  shape: index < inspectionItems.length - 1
                                      ? const Border(
                                          bottom: BorderSide(
                                            color: AppTheme.borderColor,
                                          ),
                                        )
                                      : null,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // ── Tombol Mulai Tindakan ────────────────────────────
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: (apdChecked.every((v) => v) &&
                                    inspectionChecked.every((v) => v))
                                ? () => Get.toNamed(Routes.TECH_CHEMICAL_LOG)
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              disabledBackgroundColor: Colors.grey.shade200,
                              disabledForegroundColor: AppTheme.textSecondary,
                            ),
                            icon: const Icon(Icons.arrow_forward, size: 18),
                            label: Text(
                              (apdChecked.every((v) => v) &&
                                      inspectionChecked.every((v) => v))
                                  ? 'Lanjut → Log Bahan Kimia'
                                  : 'Selesaikan Semua Checklist',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
