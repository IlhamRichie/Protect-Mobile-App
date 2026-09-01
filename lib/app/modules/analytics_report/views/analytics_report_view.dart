import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/analytics_report_controller.dart';

class AnalyticsReportView extends GetView<AnalyticsReportController> {
  const AnalyticsReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnalyticsReportController());

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Executive Analytics & Report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppTheme.darkSlate),
            onPressed: () => controller.exportReport('PDF'),
            tooltip: 'Bagikan Laporan',
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive Layout Breakpoint Determination
            final isTablet = constraints.maxWidth >= 600;
            final double horizontalPadding = isTablet ? 24.0 : 16.0;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16.0,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Filter Bar (Responsive Flex / Wrap)
                      _buildFilterHeader(context, isTablet),
                      const SizedBox(height: 20),

                      // KPI Cards (Responsive Grid 2 vs 4 Columns)
                      _buildKpiGrid(isTablet),
                      const SizedBox(height: 24),

                      // Ingress Hotspot Summary Card
                      _buildHotspotSummaryCard(context),
                      const SizedBox(height: 24),

                      // ESG Environmental Impact Section
                      _buildEsgImpactSection(context, isTablet),
                      const SizedBox(height: 28),

                      // Quick Export Action Buttons
                      _buildExportButtons(context, isTablet),
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

  Widget _buildFilterHeader(BuildContext context, bool isTablet) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppTheme.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.business, color: AppTheme.primaryColor, size: 20),
                const SizedBox(width: 8),
                Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedFacility.value,
                      items: controller.facilities.map((f) {
                        return DropdownMenuItem(
                          value: f,
                          child: Text(
                            f,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: AppTheme.darkSlate,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) controller.selectedFacility.value = val;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => SegmentedButton<String>(
                showSelectedIcon: false,
                segments: controller.periods.map((p) {
                  return ButtonSegment<String>(
                    value: p,
                    label: Text(
                      p,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                selected: {controller.selectedPeriod.value},
                onSelectionChanged: (val) {
                  controller.selectedPeriod.value = val.first;
                },
                style: SegmentedButton.styleFrom(
                  selectedBackgroundColor: AppTheme.primaryColor,
                  selectedForegroundColor: Colors.white,
                  backgroundColor: AppTheme.backgroundColor,
                  foregroundColor: AppTheme.textSecondary,
                  side: const BorderSide(color: AppTheme.borderColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiGrid(bool isTablet) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isTablet ? 4 : 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: isTablet ? 1.4 : 1.3,
      children: [
        _buildMetricCard(
          title: 'HACCP Index',
          value: '98.5%',
          subtitle: 'Audit Compliance',
          icon: Icons.verified_user_outlined,
          color: AppTheme.primaryColor,
        ),
        _buildMetricCard(
          title: 'Insiden Deteksi',
          value: '4 Kasus',
          subtitle: '-65% vs bulan lalu',
          icon: Icons.bug_report_outlined,
          color: AppTheme.warningColor,
        ),
        _buildMetricCard(
          title: 'Reduksi Kimia',
          value: '62.4%',
          subtitle: 'ESG Target Exceeded',
          icon: Icons.eco_outlined,
          color: AppTheme.secondaryColor,
        ),
        _buildMetricCard(
          title: 'Avg Response Time',
          value: '3.8 Min',
          subtitle: 'SLA < 15 Min',
          icon: Icons.timer_outlined,
          color: AppTheme.infoColor,
        ),
      ],
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
        color: AppTheme.cardColor,
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
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildHotspotSummaryCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Distribusi Hotspot Resiko Area',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Real-time Heatmap',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildHotspotItem(
              zone: 'Zone A2 - Warehouse Loading Dock',
              riskLevel: 'Tinggi (3 Deteksi)',
              color: AppTheme.dangerColor,
              progress: 0.75,
            ),
            const SizedBox(height: 12),
            _buildHotspotItem(
              zone: 'Zone B1 - Raw Material Storage',
              riskLevel: 'Sedang (1 Deteksi)',
              color: AppTheme.warningColor,
              progress: 0.35,
            ),
            const SizedBox(height: 12),
            _buildHotspotItem(
              zone: 'Zone C4 - Finished Goods Area',
              riskLevel: 'Steril (0 Deteksi)',
              color: AppTheme.primaryColor,
              progress: 0.05,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotspotItem({
    required String zone,
    required String riskLevel,
    required Color color,
    required double progress,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                zone,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              riskLevel,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: AppTheme.backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildEsgImpactSection(BuildContext context, bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.eco, color: Colors.white, size: 22),
              SizedBox(width: 8),
              Text(
                'Dampak ESG Lingkungan & Keberlanjutan',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Dengan penggunaan ProViewAI, fasilitas ini berhasil menghemat 148.5 Liter bahan racun kimia dan menyelamatkan 4.2 Ton bahan baku pangan dari kontaminasi.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportButtons(BuildContext context, bool isTablet) {
    return isTablet
        ? Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => controller.exportReport('Official Audit PDF'),
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Export Laporan PDF HACCP'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => controller.exportReport('Raw CSV Data'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppTheme.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.table_chart, color: AppTheme.primaryColor),
                  label: const Text(
                    'Export Datasets CSV',
                    style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => controller.exportReport('Official Audit PDF'),
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Export Laporan PDF HACCP'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => controller.exportReport('Raw CSV Data'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppTheme.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.table_chart, color: AppTheme.primaryColor),
                  label: const Text(
                    'Export Datasets CSV',
                    style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
  }
}