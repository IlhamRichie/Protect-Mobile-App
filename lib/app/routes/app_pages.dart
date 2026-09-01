import 'package:get/get.dart';

import '../modules/analytics_report/views/b2b_esg_metrics_view.dart';
import '../modules/camera_management/views/b2b_alert_settings_view.dart';
import '../modules/camera_management/views/b2b_roi_editor_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

import '../modules/b2c_home/bindings/b2c_home_binding.dart';
import '../modules/b2c_home/views/b2c_home_view.dart';
import '../modules/b2c_chat/bindings/cs_chat_binding.dart';
import '../modules/b2c_chat/views/cs_chat_view.dart';
import '../modules/b2c_quote/bindings/digital_quote_binding.dart';
import '../modules/b2c_quote/views/digital_quote_view.dart';
import '../modules/b2c_payment/bindings/payment_binding.dart';
import '../modules/b2c_payment/views/payment_view.dart';
import '../modules/b2c_tracker/bindings/live_tracker_binding.dart';
import '../modules/b2c_tracker/views/live_tracker_view.dart';
import '../modules/b2c_warranty/bindings/digital_warranty_binding.dart';
import '../modules/b2c_warranty/views/digital_warranty_view.dart';

import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/views/select_service_view.dart';
import '../modules/booking/views/select_address_view.dart';
import '../modules/booking/views/select_schedule_view.dart';

import '../modules/b2c_orders/bindings/orders_binding.dart';
import '../modules/b2c_orders/views/orders_view.dart';

import '../modules/articles/bindings/articles_binding.dart';
import '../modules/articles/views/article_list_view.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/camera_management/bindings/camera_management_binding.dart';
import '../modules/camera_management/views/camera_management_view.dart';
import '../modules/live_feed/bindings/live_feed_binding.dart';
import '../modules/live_feed/views/live_feed_view.dart';
import '../modules/incident_detail/bindings/incident_detail_binding.dart';
import '../modules/incident_detail/views/incident_detail_view.dart';
import '../modules/incident_resolve/bindings/resolve_ticket_binding.dart';
import '../modules/incident_resolve/views/resolve_ticket_view.dart';
import '../modules/export_haccp/bindings/export_haccp_binding.dart';
import '../modules/export_haccp/views/export_haccp_view.dart';

import '../modules/technician/bindings/technician_binding.dart';
import '../modules/technician/views/technician_chemical_log_view.dart';
import '../modules/technician/views/technician_job_board_view.dart';
import '../modules/technician/views/technician_job_detail_view.dart';
import '../modules/technician/views/technician_signoff_view.dart';

import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.B2C_HOME,
      page: () => const B2cHomeView(),
      binding: B2cHomeBinding(),
    ),
    GetPage(
      name: _Paths.B2C_CHAT,
      page: () => const CsChatView(),
      binding: CsChatBinding(),
    ),
    GetPage(
      name: _Paths.B2C_QUOTE,
      page: () => const DigitalQuoteView(),
      binding: DigitalQuoteBinding(),
    ),
    GetPage(
      name: _Paths.B2C_PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.B2C_TRACKER,
      page: () => const LiveTrackerView(),
      binding: LiveTrackerBinding(),
    ),
    GetPage(
      name: _Paths.B2C_WARRANTY,
      page: () => const DigitalWarrantyView(),
      binding: DigitalWarrantyBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_SERVICE,
      page: () => const SelectServiceView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_ADDRESS,
      page: () => const SelectAddressView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_SCHEDULE,
      page: () => const SelectScheduleView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.B2C_ORDERS,
      page: () => const OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLES,
      page: () => const ArticleListView(),
      binding: ArticlesBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA_SETUP,
      page: () => const CameraManagementView(),
      binding: CameraManagementBinding(),
    ),
    GetPage(
      name: _Paths.LIVE_FEED,
      page: () => const LiveFeedView(),
      binding: LiveFeedBinding(),
    ),
    GetPage(
      name: _Paths.INCIDENT_DETAIL,
      page: () => const IncidentDetailView(),
      binding: IncidentDetailBinding(),
    ),
    GetPage(
      name: _Paths.INCIDENT_RESOLVE,
      page: () => const ResolveTicketView(),
      binding: ResolveTicketBinding(),
    ),
    GetPage(
      name: _Paths.EXPORT_HACCP,
      page: () => const ExportHaccpView(),
      binding: ExportHaccpBinding(),
    ),
    GetPage(
      name: _Paths.TECHNICIAN_JOB_BOARD,
      page: () => const TechnicianJobBoardView(),
      binding: TechnicianBinding(),
    ),
    GetPage(
      name: _Paths.TECHNICIAN_JOB_DETAIL,
      page: () => const TechnicianJobDetailView(),
      binding: TechnicianBinding(),
    ),
    GetPage(
      name: _Paths.TECHNICIAN_SIGNOFF,
      page: () => const TechnicianSignoffView(),
      binding: TechnicianBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.B2B_ROI_EDITOR,
      page: () => const B2bRoiEditorView(),
      binding: CameraManagementBinding(),
    ),
    GetPage(
      name: _Paths.B2B_ESG_METRICS,
      page: () => const B2bEsgMetricsView(),
    ),
    GetPage(
      name: _Paths.TECH_CHEMICAL_LOG,
      page: () => const TechnicianChemicalLogView(),
    ),
    GetPage(
      name: _Paths.B2B_ALERT_SETTINGS,
      page: () => const B2bAlertSettingsView(),
    ),
  ];
}
