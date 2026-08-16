import 'package:get/get.dart';
import '../modules/login/views/login_view.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/live_feed/views/live_feed_view.dart';
import '../modules/incident/views/incident_log_view.dart';
import '../modules/incident/views/incident_detail_view.dart';
import '../modules/analytics/views/haccp_analytics_view.dart';
import '../modules/camera/views/camera_management_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardView(),
    ),
    GetPage(
      name: Routes.LIVE_FEED,
      page: () => const LiveFeedView(),
    ),
    GetPage(
      name: Routes.INCIDENT_LOG,
      page: () => const IncidentLogView(),
    ),
    GetPage(
      name: Routes.INCIDENT_DETAIL,
      page: () => const IncidentDetailView(),
    ),
    GetPage(
      name: Routes.HACCP_ANALYTICS,
      page: () => const HaccpAnalyticsView(),
    ),
    GetPage(
      name: Routes.CAMERA_MANAGEMENT,
      page: () => const CameraManagementView(),
    ),
  ];
}
