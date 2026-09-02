import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/data_models.dart';

class AppState extends ChangeNotifier {
  late List<IncidentItem> incidents;
  late List<OrderItem> orders;
  late List<TechnicianJob> jobs;
  late List<CameraItem> cameras;

  ServiceItem selectedService = SampleData.services.first;
  String bookingAddress = 'Jl. Senopati Raya No. 88, Jakarta Selatan';
  String bookingDate = 'Besok, 03 Sep 2026';
  String bookingTime = '10:00 WIB';
  String bookingNotes = '';

  String voucherCode = '';
  int discount = 0;
  String selectedPaymentMethod = 'QRIS Instant Settlement';
  final List<String> paymentMethods = [
    'QRIS Instant Settlement',
    'Virtual Account BCA / Mandiri',
    'Kartu Kredit / Debit Online',
    'Tunai ke Teknisi Lapangan',
  ];
  int treatmentProgressStep = 0;

  int liveFps = 30;
  String liveLatency = '18ms';
  String liveModel = 'YOLO-Pest-v8';
  String detectedSpecies = 'Rattus Norvegicus';
  int detectionConfidence = 98;
  int detectedId = 89;

  double trackerProgress = 0.65;
  int trackerEtaMinutes = 12;
  double trackerDistanceKm = 2.4;
  String trackerStatusText = 'Teknisi Bpk. Doni sedang menuju alamat Anda';

  final List<ChatMessage> chatMessages = [
    const ChatMessage(
      id: 'm1',
      text: 'Halo! Saya Asisten AI PROTECT. Ada yang bisa kami bantu terkait proteksi hama atau audit HACCP hari ini?',
      isUser: false,
      timestamp: '09:30',
    ),
  ];

  List<Offset> roiPoints = [
    const Offset(0.20, 0.25),
    const Offset(0.80, 0.25),
    const Offset(0.85, 0.75),
    const Offset(0.15, 0.75),
  ];

  String alertWebhookUrl = 'https://api.protect-ai.cloud/v1/webhooks/haccp-alerts';
  bool alertTelegramEnabled = true;
  bool alertSlackEnabled = true;
  bool alertEmailEnabled = true;
  bool alertSmsEnabled = false;
  double alertSensitivityThreshold = 0.85;

  String chemicalAgent = 'Eco-Gel Fipronil 0.05% (Botanical Bio-Bait)';
  String chemicalDosage = '25';
  String chemicalUnit = 'Gram (g)';
  String chemicalNotes = 'Dipasang pada station baiting perimeter underground sudut utara.';
  bool chemicalLoggedSuccess = false;

  Timer? _liveTimer;

  AppState() {
    incidents = SampleData.getInitialIncidents();
    orders = SampleData.getInitialOrders();
    jobs = SampleData.getInitialJobs();
    cameras = SampleData.getInitialCameras();
    _startLiveSimulation();
  }

  void _startLiveSimulation() {
    _liveTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      final random = Random();
      liveFps = 28 + random.nextInt(5);
      liveLatency = '${14 + random.nextInt(10)}ms';
      detectionConfidence = 94 + random.nextInt(6);
      notifyListeners();
    });
  }

  bool applyVoucher(String code) {
    voucherCode = code.trim();
    if (voucherCode.toUpperCase() == 'PROTECTFREE' ||
        voucherCode.toUpperCase() == 'DISKON50' ||
        voucherCode.toUpperCase() == 'PROTECT50') {
      discount = 50000;
      notifyListeners();
      return true;
    } else {
      discount = 0;
      notifyListeners();
      return false;
    }
  }

  void processPayment() {
    treatmentProgressStep = 1;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 1500), () {
      treatmentProgressStep = 2;
      notifyListeners();
    });
    Future.delayed(const Duration(milliseconds: 3500), () {
      treatmentProgressStep = 3;
      notifyListeners();
    });
  }

  void resolveIncident(String incidentId, String note) {
    for (var i = 0; i < incidents.length; i++) {
      if (incidents[i].id == incidentId || incidents[i].code == incidentId) {
        incidents[i].status = IncidentStatus.resolved;
        incidents[i].recommendedAction = 'Tindakan Selesai: $note';
        break;
      }
    }
    notifyListeners();
  }

  void updateJobStatus(String jobId, JobStatus newStatus) {
    for (var i = 0; i < jobs.length; i++) {
      if (jobs[i].id == jobId || jobs[i].code == jobId) {
        jobs[i].status = newStatus;
        break;
      }
    }
    notifyListeners();
  }

  void sendChatMessage(String text) {
    if (text.trim().isEmpty) return;
    final userMsg = ChatMessage(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      isUser: true,
      timestamp: 'Sekarang',
    );
    chatMessages.add(userMsg);
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      String replyText;
      final lower = text.toLowerCase();
      if (lower.contains('jadwal') || lower.contains('booking')) {
        replyText = 'Anda dapat memilih layanan dan menjadwalkan kunjungan inspeksi teknisi langsung melalui menu Pesan Layanan di Beranda.';
      } else if (lower.contains('garansi')) {
        replyText = 'Semua layanan kami dilindungi sertifikat garansi digital 12 bulan berstandar HACCP dengan jaminan re-treatment gratis jika hama kembali.';
      } else if (lower.contains('haccp') || lower.contains('audit')) {
        replyText = 'Laporan audit HACCP dapat diunduh dalam format PDF/Excel resmi langsung dari menu Laporan & Audit HACCP.';
      } else {
        replyText = 'Terima kasih atas pesan Anda! Tim CS & Teknisi Siaga PROTECT siap membantu. Tiket konsultasi #TKT-${1000 + Random().nextInt(9000)} telah dibuka.';
      }

      final botMsg = ChatMessage(
        id: 'bot_${DateTime.now().millisecondsSinceEpoch}',
        text: replyText,
        isUser: false,
        timestamp: 'Sekarang',
      );
      chatMessages.add(botMsg);
      notifyListeners();
    });
  }

  void addRoiPoint(Offset pt) {
    if (roiPoints.length < 8) {
      roiPoints.add(pt);
      notifyListeners();
    }
  }

  void resetRoiPoints() {
    roiPoints = [
      const Offset(0.20, 0.25),
      const Offset(0.80, 0.25),
      const Offset(0.85, 0.75),
      const Offset(0.15, 0.75),
    ];
    notifyListeners();
  }

  void addCamera(String name, String rtspUrl, String location) {
    cameras.add(CameraItem(
      id: 'cam-${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      rtspUrl: rtspUrl,
      location: location,
      status: 'Online • 30 FPS',
      fps: 30,
      resolution: '1080p FHD',
      sensitivity: 0.85,
      isAiActive: true,
    ));
    notifyListeners();
  }

  void toggleCameraAi(String camId) {
    for (var cam in cameras) {
      if (cam.id == camId) {
        cam.isAiActive = !cam.isAiActive;
        break;
      }
    }
    notifyListeners();
  }

  void updateCameraSensitivity(String camId, double sens) {
    for (var cam in cameras) {
      if (cam.id == camId) {
        cam.sensitivity = sens;
        break;
      }
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _liveTimer?.cancel();
    super.dispose();
  }
}
