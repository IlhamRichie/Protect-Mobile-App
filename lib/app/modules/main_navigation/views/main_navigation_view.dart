import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../../camera_management/views/b2b_alert_settings_view.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../incident_log/views/incident_log_view.dart';
import '../../live_feed/views/live_feed_view.dart';
import '../controllers/main_navigation_controller.dart';

class MainNavigationView extends GetView<MainNavigationController> {
  const MainNavigationView({super.key});

  static const List<Widget> _pages = [
    DashboardView(),
    LiveFeedView(),
    IncidentLogView(),
    B2bAlertSettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 600;

        if (isTablet) {
          return Scaffold(
            backgroundColor: AppTheme.backgroundColor,
            body: Row(
              children: [
                Obx(
                  () => NavigationRail(
                    selectedIndex: controller.currentIndex.value,
                    onDestinationSelected: controller.changePage,
                    labelType: NavigationRailLabelType.all,
                    backgroundColor: Colors.white,
                    selectedIconTheme: const IconThemeData(color: AppTheme.primaryColor),
                    selectedLabelTextStyle: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    unselectedLabelTextStyle: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 11,
                    ),
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.dashboard_outlined),
                        selectedIcon: Icon(Icons.dashboard),
                        label: Text('Dasbor'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.videocam_outlined),
                        selectedIcon: Icon(Icons.videocam),
                        label: Text('Live Feed'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.receipt_long_outlined),
                        selectedIcon: Icon(Icons.receipt_long),
                        label: Text('Log Insiden'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.notifications_active_outlined),
                        selectedIcon: Icon(Icons.notifications_active),
                        label: Text('Alert Setup'),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: AppTheme.borderColor,
                ),
                Expanded(
                  child: Obx(
                    () => IndexedStack(
                      index: controller.currentIndex.value,
                      children: _pages,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          body: Obx(
            () => IndexedStack(
              index: controller.currentIndex.value,
              children: _pages,
            ),
          ),
          bottomNavigationBar: Obx(
            () => NavigationBar(
              selectedIndex: controller.currentIndex.value,
              onDestinationSelected: controller.changePage,
              backgroundColor: Colors.white,
              indicatorColor: AppTheme.primaryColor.withOpacity(0.12),
              elevation: 8,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard, color: AppTheme.primaryColor),
                  label: 'Dasbor',
                ),
                NavigationDestination(
                  icon: Icon(Icons.videocam_outlined),
                  selectedIcon: Icon(Icons.videocam, color: AppTheme.primaryColor),
                  label: 'Live Feed',
                ),
                NavigationDestination(
                  icon: Icon(Icons.receipt_long_outlined),
                  selectedIcon: Icon(Icons.receipt_long, color: AppTheme.primaryColor),
                  label: 'Log Insiden',
                ),
                NavigationDestination(
                  icon: Icon(Icons.notifications_active_outlined),
                  selectedIcon: Icon(Icons.notifications_active, color: AppTheme.primaryColor),
                  label: 'Alert Setup',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}