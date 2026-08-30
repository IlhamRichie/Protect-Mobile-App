import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/export_haccp_controller.dart';

class ExportHaccpView extends GetView<ExportHaccpController> {
  const ExportHaccpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('HACCP & ESG Audit Export Center'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pusat Pelaporan Kepatuhan Audit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Ekspor berkas laporan audit resmi berstandar HACCP, ISO 22000, dan metrik lingkungan ESG.', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            const SizedBox(height: 16),

            // Date Range Picker Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.calendar_month, color: AppTheme.primaryColor, size: 22),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rentang Tanggal Audit', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                            SizedBox(height: 2),
                            Text('01 Ags 2026 - 31 Ags 2026', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.darkSlate)),
                          ],
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_drop_down, color: AppTheme.primaryColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Format Checkboxes Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text('Komponen Berkas Yang Diikutsertakan:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        value: controller.isHaccpChecked.value,
                        onChanged: (v) => controller.isHaccpChecked.value = v ?? false,
                        title: const Text('HACCP Standard Compliance Metric', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        subtitle: const Text('Tingkat kepatuhan area steril & log insiden AI', style: TextStyle(fontSize: 11)),
                        activeColor: AppTheme.primaryColor,
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        value: controller.isIsoChecked.value,
                        onChanged: (v) => controller.isIsoChecked.value = v ?? false,
                        title: const Text('ISO 22000 Food Safety Audit Log', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        subtitle: const Text('Laporan verifikasi penanganan & bukti foto perangkap', style: TextStyle(fontSize: 11)),
                        activeColor: AppTheme.primaryColor,
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        value: controller.isEsgChecked.value,
                        onChanged: (v) => controller.isEsgChecked.value = v ?? false,
                        title: const Text('ESG Chemical Reduction Metric', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        subtitle: const Text('Reduksi 62% penggunaan bahan kimia racun', style: TextStyle(fontSize: 11)),
                        activeColor: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Live Report Preview Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.emerald50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.primaryColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Live Audit Summary Preview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.primaryColor)),
                      Text('STATISTIK LENGKAP', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                    ],
                  ),
                  const Divider(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: const [
                          Text('Compliance Rate', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                          Text('98.5%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.primaryColor)),
                        ],
                      ),
                      Column(
                        children: const [
                          Text('Total Incidents', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                          Text('1 Resolved', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.darkSlate)),
                        ],
                      ),
                      Column(
                        children: const [
                          Text('Avg Response', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                          Text('4.2 Min', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.primaryColor)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Export Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.exportOfficialPdf,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white, size: 20),
                label: const Text('📥 Export Official HACCP PDF Report', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
