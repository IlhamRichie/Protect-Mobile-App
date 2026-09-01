import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/app_models.dart';
import '../../../routes/app_pages.dart';

class TechnicianController extends GetxController {
  final RxString techName = 'Doni Prasetyo'.obs;
  final RxBool isReadyForDuty = true.obs;
  final RxInt selectedJobTab = 0.obs;

  final RxBool isGpsCheckedIn = false.obs;
  final RxBool sopApdChecked = true.obs;
  final RxBool sopMoistureChecked = true.obs;
  final RxBool sopBaitChecked = true.obs;

  // 1. Dynamic Active Job State
  final Rxn<TechJob> currentJob = Rxn<TechJob>();

  // 2. ESG Chemical & Bait Usage Logger States
  final RxString selectedChemical = 'Exterra Termite Baiting Agent'.obs;
  final TextEditingController chemicalDosageController = TextEditingController(text: '2.5');
  final RxString chemicalUnit = 'Liter'.obs;

  final List<String> availableChemicals = [
    'Exterra Termite Baiting Agent',
    'Fipronil Eco-Shield 2.5 EC',
    'Biorational Rodenticide Block',
  ];

  final RxList<TechJob> todayJobs = <TechJob>[
    TechJob(
      jobId: 'JOB-901',
      title: 'Free On-Site Survey Rayap',
      jobType: 'FREE SURVEY',
      clientName: 'Bpk. Hendra Kurniawan',
      address: 'Jl. Raya Kebayoran Baru No. 45, Jakarta Selatan',
      phone: '0812-9988-7766',
      scheduledTime: DateTime.now().add(const Duration(hours: 1)),
      status: 'Pending',
      zone: '3.2 km',
    ),
    TechJob(
      jobId: 'JOB-902',
      title: 'Treatment Routine Anti Rayap',
      jobType: 'TREATMENT RUTIN',
      clientName: 'Ibu Siska Pratama',
      address: 'Jl. Tebet Raya No. 12, Jakarta Selatan',
      phone: '0813-1122-3344',
      scheduledTime: DateTime.now().add(const Duration(hours: 3)),
      status: 'Pending',
      zone: '1.8 km',
    ),
    TechJob(
      jobId: 'JOB-903',
      title: 'B2B Incident Escalation',
      jobType: 'B2B ESCALATION',
      clientName: 'Gudang Cikarang Plant 01',
      address: 'Kawasan Industri Jababeka V, Cikarang',
      phone: '0811-5544-3322',
      scheduledTime: DateTime.now().add(const Duration(hours: 5)),
      status: 'Pending',
      zone: '14.5 km',
    ),
  ].obs;

  void toggleReadyStatus() {
    isReadyForDuty.value = !isReadyForDuty.value;
  }

  void startNavigation(TechJob job) {
    currentJob.value = job;
    Get.snackbar(
      'Mulai Navigasi',
      'Membuka rute GPS Maps ke lokasi ${job.clientName}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
    Get.toNamed(Routes.TECHNICIAN_JOB_DETAIL, arguments: job);
  }

  void doGpsCheckIn() {
    isGpsCheckedIn.value = true;
    Get.snackbar(
      'Check-In GPS Berhasil',
      'Lokasi terverifikasi presisi di lokasi klien.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
  }

  // 3. Method Pencatatan Dosis Bahan Kimia Ramah Lingkungan
  void saveChemicalLog() {
    Get.snackbar(
      'Penggunaan Bahan Tercatat',
      'Tercatat: ${chemicalDosageController.text} ${chemicalUnit.value} ${selectedChemical.value}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
  }

  void goToSignOff() {
    Get.toNamed(Routes.TECHNICIAN_SIGNOFF);
  }

  void completeJobAndIssueCertificate() {
    if (currentJob.value != null) {
      currentJob.value!.status = 'Completed';
    }
    Get.snackbar(
      'Pekerjaan Selesai!',
      'E-Sertifikat Bebas Hama & Garansi 12 Bulan berhasil diterbitkan untuk klien.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
    Get.offAllNamed(Routes.TECHNICIAN_JOB_BOARD);
  }

  @override
  void onClose() {
    chemicalDosageController.dispose();
    super.onClose();
  }
}