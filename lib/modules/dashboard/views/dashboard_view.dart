import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: controller.selectedFacility.value,
            dropdownColor: AppTheme.primaryColor,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
            onChanged: (String? newValue) {
              if (newValue != null) controller.changeFacility(newValue);
            },
            items: controller.facilities.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        )),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Get.snackbar('Role', 'Logged in as: ${controller.userRole.value}',
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.offAllNamed(Routes.LOGIN),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Alert Banner
            Obx(() {
              if (controller.activeIncidents.isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.dangerColor.withOpacity(0.1),
                    border: Border.all(color: AppTheme.dangerColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: AppTheme.dangerColor),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '${controller.activeIncidents.length} High Alert Incident(s) require verification!',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.dangerColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.dangerColor,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.INCIDENT_LOG);
                        },
                        child: const Text('View All'),
                      )
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            // KPI Grid
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildKpiCard(context, 'CCTVs Online', '8/8', Icons.videocam, AppTheme.secondaryColor),
                _buildKpiCard(context, 'HACCP Score', '100%', Icons.verified, AppTheme.accentColor),
                Obx(() => _buildKpiCard(context, 'Active Incidents', controller.activeIncidents.length.toString(), Icons.bug_report, AppTheme.warningColor)),
                _buildKpiCard(context, 'Bait Reduction', '60%', Icons.eco, AppTheme.accentColor),
              ],
            ),
            const SizedBox(height: 24),

            // Quick Actions
            Text('Quick Actions', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildActionBtn(context, 'Live Feed', Icons.camera_alt, Routes.LIVE_FEED),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionBtn(context, 'Incident Log', Icons.list_alt, Routes.INCIDENT_LOG),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionBtn(context, 'Analytics', Icons.bar_chart, Routes.EXPORT_HACCP),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionBtn(context, 'Cameras', Icons.settings, Routes.CAMERA_SETUP),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 4),
            Text(title, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn(BuildContext context, String title, IconData icon, String route) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: AppTheme.cardColor,
        foregroundColor: AppTheme.textPrimary,
        elevation: 1,
      ),
      onPressed: () {
        Get.toNamed(route);
      },
      icon: Icon(icon, color: AppTheme.secondaryColor),
      label: Text(title),
    );
  }
}
