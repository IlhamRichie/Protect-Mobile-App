import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/incident_log_controller.dart';

class IncidentLogView extends GetView<IncidentLogController> {
  const IncidentLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Riwayat Log Insiden (Audit Trail)'),
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
                vertical: 16.0,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 850),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Search & Filter Bar
                      _buildSearchAndFilterBar(),
                      const SizedBox(height: 16),

                      // Status Filter Chips
                      _buildFilterChips(),
                      const SizedBox(height: 20),

                      // Audit Log Section Header
                      _buildSectionHeader(),
                      const SizedBox(height: 12),

                      // Incident Feed List
                      _buildIncidentLogList(),
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

  Widget _buildSearchAndFilterBar() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppTheme.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (val) => controller.searchQuery.value = val,
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Cari kamera, zona, atau ID insiden...',
                  hintStyle: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                  prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor, size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            Container(
              height: 24,
              width: 1,
              color: AppTheme.borderColor,
            ),
            IconButton(
              icon: const Icon(Icons.filter_list, color: AppTheme.primaryColor),
              onPressed: controller.openFilterModal,
              tooltip: 'Filter Lanjutan',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['Semua', 'Need Action', 'Resolved'];

    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: filters.map((filter) {
            final isSelected = controller.selectedFilter.value == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FilterChip(
                label: Text(filter),
                selected: isSelected,
                onSelected: (_) => controller.selectedFilter.value = filter,
                selectedColor: AppTheme.primaryColor,
                backgroundColor: Colors.white,
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : AppTheme.darkSlate,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Daftar Insiden Terdeteksi AI',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkSlate,
          ),
        ),
        Obx(
          () => Text(
            '${controller.filteredIncidentCount} Insiden',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIncidentLogList() {
    return Column(
      children: [
        _buildLogCard(
          incidentId: 'INC-2026-089',
          cameraLabel: 'CCTV-04',
          location: 'CAM-04 Storage Tepung',
          timestamp: '01 Ags 2026 • 02:14:05 WIB',
          zone: 'Zone A2 Steril Boundary (Y=550)',
          confidence: '96%',
          badgeText: 'NEED ACTION',
          badgeColor: AppTheme.dangerColor,
          badgeBgColor: AppTheme.dangerBackground,
          isActionNeeded: true,
          onTap: () => controller.openIncidentDetail('INC-2026-089'),
        ),
        const SizedBox(height: 10),
        _buildLogCard(
          incidentId: 'INC-2026-088',
          cameraLabel: 'CCTV-02',
          location: 'CAM-02 Loading Dock B',
          timestamp: '31 Jul 2026 • 18:30:12 WIB',
          zone: 'Zone B1 Perimeter Gate',
          confidence: '94%',
          badgeText: 'RESOLVED',
          badgeColor: AppTheme.primaryColor,
          badgeBgColor: AppTheme.emerald50,
          isActionNeeded: false,
          onTap: () => controller.openIncidentDetail('INC-2026-088'),
        ),
        const SizedBox(height: 10),
        _buildLogCard(
          incidentId: 'INC-2026-087',
          cameraLabel: 'CCTV-01',
          location: 'CAM-01 Processing Line A',
          timestamp: '30 Jul 2026 • 11:15:40 WIB',
          zone: 'Zone A1 Packaging Area',
          confidence: '98%',
          badgeText: 'RESOLVED',
          badgeColor: AppTheme.primaryColor,
          badgeBgColor: AppTheme.emerald50,
          isActionNeeded: false,
          onTap: () => controller.openIncidentDetail('INC-2026-087'),
        ),
      ],
    );
  }

  Widget _buildLogCard({
    required String incidentId,
    required String cameraLabel,
    required String location,
    required String timestamp,
    required String zone,
    required String confidence,
    required String badgeText,
    required Color badgeColor,
    required Color badgeBgColor,
    required bool isActionNeeded,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppTheme.borderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            incidentId,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.darkSlate,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'AI Acc: $confidence',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: badgeBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        badgeText,
                        style: TextStyle(
                          color: badgeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 16),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: badgeBgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isActionNeeded
                              ? badgeColor.withOpacity(0.3)
                              : Colors.transparent,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isActionNeeded
                                ? Icons.warning_amber_rounded
                                : Icons.check_circle_outline,
                            color: badgeColor,
                            size: 20,
                          ),
                          Text(
                            cameraLabel,
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: badgeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: AppTheme.darkSlate,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            zone,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            timestamp,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppTheme.darkSlate,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}