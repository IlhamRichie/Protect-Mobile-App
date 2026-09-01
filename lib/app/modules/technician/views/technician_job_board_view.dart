import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../../../routes/app_pages.dart';
import '../controllers/technician_controller.dart';

class TechnicianJobBoardView extends GetView<TechnicianController> {
  const TechnicianJobBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: _buildAppBarTitle(),
        actions: [
          _buildStatusToggle(),
          IconButton(
            icon: const Icon(Icons.person_outline, color: AppTheme.darkSlate),
            onPressed: () => Get.toNamed(Routes.PROFILE),
            tooltip: 'Profil Saya',
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 850),
                child: Column(
                  children: [
                    // Tab Navigation Switcher
                    _buildTabSwitcher(),

                    // Job Card List View
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 24.0 : 16.0,
                            vertical: 16.0,
                          ),
                          itemCount: controller.todayJobs.length,
                          itemBuilder: (context, index) {
                            final job = controller.todayJobs[index];
                            return _buildJobCard(job);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: AppTheme.primaryColor,
          radius: 18,
          child: Icon(Icons.engineering, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Text(
                  'Teknisi: ${controller.techName.value}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkSlate,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 1),
              const Text(
                'ID: TECH-8821 • Senior Specialist',
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusToggle() {
    return Obx(
      () => GestureDetector(
        onTap: controller.toggleReadyStatus,
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: controller.isReadyForDuty.value
                ? AppTheme.emerald50
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: controller.isReadyForDuty.value
                  ? AppTheme.primaryColor
                  : Colors.grey,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.isReadyForDuty.value
                      ? AppTheme.primaryColor
                      : Colors.grey,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                controller.isReadyForDuty.value ? 'Siap Tugas' : 'Off Duty',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: controller.isReadyForDuty.value
                      ? AppTheme.primaryColor
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Obx(
        () => Row(
          children: [
            _buildTabPill(0, 'Kunjungan Hari Ini (${controller.todayJobs.length})'),
            const SizedBox(width: 8),
            _buildTabPill(1, 'Terjadwal'),
            const SizedBox(width: 8),
            _buildTabPill(2, 'Riwayat'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabPill(int index, String label) {
    final isSelected = controller.selectedJobTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectedJobTab.value = index,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.primaryColor.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? AppTheme.primaryColor
                      : AppTheme.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJobCard(dynamic job) {
    final isFreeSurvey = job.jobType == 'FREE SURVEY';
    final String formattedTime =
        'Jam ${job.scheduledTime.hour.toString().padLeft(2, '0')}:${job.scheduledTime.minute.toString().padLeft(2, '0')} WIB';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppTheme.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Type & Zone Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isFreeSurvey
                        ? Colors.blue.shade50
                        : AppTheme.emerald50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    job.jobType,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isFreeSurvey
                          ? Colors.blue.shade700
                          : AppTheme.primaryColor,
                    ),
                  ),
                ),
                Text(
                  job.zone,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Job Title
            Text(
              job.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppTheme.darkSlate,
              ),
            ),
            const SizedBox(height: 4),

            // Client Name & Address
            Text(
              'Klien: ${job.clientName}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              job.address,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary,
              ),
            ),
            const Divider(height: 20),

            // Schedule Time & Navigation Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      formattedTime,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => controller.startNavigation(job),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.navigation, size: 14),
                  label: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Mulai Navigasi',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}