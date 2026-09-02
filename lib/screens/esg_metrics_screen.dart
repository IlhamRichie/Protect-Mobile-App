import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/data_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class B2bEsgMetricsScreen extends StatefulWidget {
  const B2bEsgMetricsScreen({super.key});

  @override
  State<B2bEsgMetricsScreen> createState() => _B2bEsgMetricsScreenState();
}

class _B2bEsgMetricsScreenState extends State<B2bEsgMetricsScreen> {
  bool _isExported = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('ESG & Sustainability Metrics'),
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
              setState(() => _isExported = true);
            },
            icon: const Icon(Icons.file_download, color: Colors.white),
            label: Text(
              _isExported ? 'Laporan ESG Berhasil Diunduh' : 'Export Ringkasan ESG (PDF)',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
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
          const InfoBanner(
            text: 'Perhitungan kuantitatif otomatis pengurangan toksisitas kimia dan emisi karbon penanganan sejalan dengan standar GRI & SDG 12 (Responsible Consumption).',
            icon: Icons.eco,
          ),
          const SizedBox(height: 16),

          if (_isExported) ...[
            const InfoBanner(
              text: 'Dokumen ESG_Sustainability_Scorecard_2026.pdf telah tersimpan di berkas Anda.',
              icon: Icons.check_circle,
            ),
            const SizedBox(height: 16),
          ],

          const SectionHeader(title: 'Indikator Kunci Keberlanjutan Lingkungan'),
          const SizedBox(height: 8),

          ...SampleData.esgMetrics.map((metric) => Container(
            margin: const EdgeInsets.only(bottom: 12),
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
                    Expanded(
                      child: Text(
                        metric.label,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.darkSlate900),
                      ),
                    ),
                    StatusBadge(
                      text: metric.change,
                      backgroundColor: AppColors.emerald50,
                      textColor: AppColors.emerald700,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  metric.value,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.emerald600),
                ),
                const SizedBox(height: 2),
                Text(
                  metric.unit,
                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                ),
              ],
            ),
          )),
          const SizedBox(height: 12),

          // Chemical Breakdown
          const SectionHeader(title: 'Distribusi Agen Pengendali Ramah Lingkungan'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: const [
                _ProgressRow(label: 'Botanical Pyrethrum Extract (Organik)', percentage: 0.45, color: AppColors.emerald600),
                SizedBox(height: 12),
                _ProgressRow(label: 'Eco-Gel Bait (Biodegradable Formula)', percentage: 0.43, color: AppColors.emerald500),
                SizedBox(height: 12),
                _ProgressRow(label: 'Low-Residue Chemical (Controlled)', percentage: 0.12, color: AppColors.warning),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;

  const _ProgressRow({
    required this.label,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.darkSlate900)),
            Text('${(percentage * 100).toInt()}%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 6,
            backgroundColor: AppColors.borderColor,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
