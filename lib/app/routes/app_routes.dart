part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  
  // Phase 1: Entry & Smart Auth
  static const SPLASH = _Paths.SPLASH;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const LOGIN = _Paths.LOGIN;

  // Phase 2: B2C Retail & Consultative Flow
  static const B2C_HOME = _Paths.B2C_HOME;
  static const B2C_CHAT = _Paths.B2C_CHAT;
  static const B2C_QUOTE = _Paths.B2C_QUOTE;
  static const B2C_PAYMENT = _Paths.B2C_PAYMENT;
  static const B2C_TRACKER = _Paths.B2C_TRACKER;
  static const B2C_WARRANTY = _Paths.B2C_WARRANTY;
  static const B2C_ORDERS = _Paths.B2C_ORDERS;
  static const ARTICLES = _Paths.ARTICLES;

  // 3-Step Booking Wizard Routes
  static const BOOKING_SERVICE = _Paths.BOOKING_SERVICE;
  static const BOOKING_ADDRESS = _Paths.BOOKING_ADDRESS;
  static const BOOKING_SCHEDULE = _Paths.BOOKING_SCHEDULE;

  // Phase 3: B2B Enterprise ProViewAI Flow
  static const DASHBOARD = _Paths.DASHBOARD;
  static const CAMERA_SETUP = _Paths.CAMERA_SETUP;
  static const LIVE_FEED = _Paths.LIVE_FEED;
  static const INCIDENT_LOG = _Paths.INCIDENT_LOG;
  static const INCIDENT_DETAIL = _Paths.INCIDENT_DETAIL;
  static const INCIDENT_RESOLVE = _Paths.INCIDENT_RESOLVE;
  static const CAMERA_MANAGEMENT = _Paths.CAMERA_MANAGEMENT;
  static const EXPORT_HACCP = _Paths.EXPORT_HACCP;

  // Phase 4: Field Technician Mode & Profile
  static const TECHNICIAN_JOB_BOARD = _Paths.TECHNICIAN_JOB_BOARD;
  static const TECHNICIAN_JOB_DETAIL = _Paths.TECHNICIAN_JOB_DETAIL;
  static const TECHNICIAN_SOP = _Paths.TECHNICIAN_SOP;
  static const TECHNICIAN_SIGNOFF = _Paths.TECHNICIAN_SIGNOFF;
  static const PROFILE = _Paths.PROFILE;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const LOGIN = '/login';

  static const B2C_HOME = '/b2c/home';
  static const B2C_CHAT = '/b2c/chat';
  static const B2C_QUOTE = '/b2c/quotation';
  static const B2C_PAYMENT = '/b2c/payment';
  static const B2C_TRACKER = '/b2c/tracker';
  static const B2C_WARRANTY = '/b2c/warranty';
  static const B2C_ORDERS = '/b2c/orders';
  static const ARTICLES = '/b2c/articles';

  static const BOOKING_SERVICE = '/booking/service';
  static const BOOKING_ADDRESS = '/booking/address';
  static const BOOKING_SCHEDULE = '/booking/schedule';

  static const DASHBOARD = '/b2b/dashboard';
  static const CAMERA_SETUP = '/b2b/camera/setup';
  static const LIVE_FEED = '/b2b/camera/live';
  static const INCIDENT_LOG = '/b2b/incidents';
  static const INCIDENT_DETAIL = '/b2b/incidents/detail';
  static const INCIDENT_RESOLVE = '/b2b/incidents/resolve';
  static const CAMERA_MANAGEMENT = '/b2b/camera/management';
  static const EXPORT_HACCP = '/b2b/reports';

  static const TECHNICIAN_JOB_BOARD = '/tech/jobs';
  static const TECHNICIAN_JOB_DETAIL = '/tech/job/detail';
  static const TECHNICIAN_SOP = '/tech/job/sop';
  static const TECHNICIAN_SIGNOFF = '/tech/signoff';
  static const PROFILE = '/profile';
}
