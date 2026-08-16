import 'package:get/get.dart';

import '../modules/analytics_report/bindings/analytics_report_binding.dart';
import '../modules/analytics_report/views/analytics_report_view.dart';
import '../modules/camera_management/bindings/camera_management_binding.dart';
import '../modules/camera_management/views/camera_management_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/export_haccp/bindings/export_haccp_binding.dart';
import '../modules/export_haccp/views/export_haccp_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/incident_detail/bindings/incident_detail_binding.dart';
import '../modules/incident_detail/views/incident_detail_view.dart';
import '../modules/incident_log/bindings/incident_log_binding.dart';
import '../modules/incident_log/views/incident_log_view.dart';
import '../modules/live_feed/bindings/live_feed_binding.dart';
import '../modules/live_feed/views/live_feed_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_navigation/bindings/main_navigation_binding.dart';
import '../modules/main_navigation/views/main_navigation_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_NAVIGATION,
      page: () => const MainNavigationView(),
      binding: MainNavigationBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.LIVE_FEED,
      page: () => const LiveFeedView(),
      binding: LiveFeedBinding(),
    ),
    GetPage(
      name: _Paths.INCIDENT_LOG,
      page: () => const IncidentLogView(),
      binding: IncidentLogBinding(),
    ),
    GetPage(
      name: _Paths.ANALYTICS_REPORT,
      page: () => const AnalyticsReportView(),
      binding: AnalyticsReportBinding(),
    ),
    GetPage(
      name: _Paths.INCIDENT_DETAIL,
      page: () => const IncidentDetailView(),
      binding: IncidentDetailBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA_MANAGEMENT,
      page: () => const CameraManagementView(),
      binding: CameraManagementBinding(),
    ),
    GetPage(
      name: _Paths.EXPORT_HACCP,
      page: () => const ExportHaccpView(),
      binding: ExportHaccpBinding(),
    ),
  ];
}
