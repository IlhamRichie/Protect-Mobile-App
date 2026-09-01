import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/b2b_esg_metrics_controller.dart';

class B2bEsgMetricsView extends GetView<B2bEsgMetricsController> {
  const B2bEsgMetricsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(B2bEsgMetricsController());

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('ESG & Sustainability Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf, color: AppTheme.primaryColor),
            onPressed: controller.exportEsgPdfReport,
            tooltip: 'Export ESG Report',
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero ESG Banner Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF047857), Color(0xFF10B981)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, 4))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.eco, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text('ECO-IMPACT CERTIFIED', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const Text('ECOTHON 2026', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => Text(
                      '${controller.pesticideReductionRate.value}%',
                      style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                  ),
                  const Text(
                    'Pesticide Chemical Reduction Rate',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Berhasil dicapai melalui intervensi deteksi dini presisi berbasis ProViewAI.',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Key Sustainability Metrics Grid
            const Text('Metrik Keberlanjutan Lingkungan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.darkSlate)),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.25,
              children: [
                _buildMetricCard(
                  title: 'Racun Kimia Dihemat',
                  value: '${controller.savedChemicalLiters.value} Liter',
                  subtitle: 'Mencegah kontaminasi tanah',
                  icon: Icons.science_outlined,
                  color: AppTheme.primaryColor,
                ),
                _buildMetricCard(
                  title: 'Bahan Pangan Terselamatkan',
                  value: '${controller.foodWasteSavedTons.value} Ton',
                  subtitle: 'Bebas kontaminasi hama',
                  icon: Icons.inventory_2_outlined,
                  color: Colors.amber.shade700,
                ),
                _buildMetricCard(
                  title: 'Reduksi Jejak Karbon',
                  value: '${controller.co2OffsetKg.value} kg CO₂e',
                  subtitle: 'Optimasi rute teknisi',
                  icon: Icons.cloud_done_outlined,
                  color: Colors.blue.shade600,
                ),
                _buildMetricCard(
                  title: 'Kepatuhan HACCP ESG',
                  value: '100% Valid',
                  subtitle: 'Audit Ready 24/7',
                  icon: Icons.verified_user_outlined,
                  color: AppTheme.emerald600,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Target Progress Tracker Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Target Pengurangan Kimia Q3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Text('Target: 60%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppTheme.primaryColor)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: 0.624,
                        minHeight: 12,
                        backgroundColor: AppTheme.emerald50,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(' Target ESG Perusahaan Terlampaui (+2.4%)', style: TextStyle(fontSize: 11, color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
              Icon(icon, color: color, size: 20),
            ],
          ),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text(subtitle, style: const TextStyle(fontSize: 9, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}