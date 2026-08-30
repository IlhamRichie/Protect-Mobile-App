import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/technician_controller.dart';

class TechnicianJobDetailView extends GetView<TechnicianController> {
  const TechnicianJobDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Eksekusi Penanganan Lapangan'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Action: Large Button GPS Lock Check-In
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed:
                      controller.isGpsCheckedIn.value
                          ? null
                          : controller.doGpsCheckIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        controller.isGpsCheckedIn.value
                            ? AppTheme.emerald700
                            : AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: Icon(
                    controller.isGpsCheckedIn.value
                        ? Icons.verified
                        : Icons.location_on,
                    color: Colors.white,
                    size: 22,
                  ),
                  label: Text(
                    controller.isGpsCheckedIn.value
                        ? '📍 Check-In Lokasi Verifikasi (GPS Lock Active)'
                        : '📍 Check-In Lokasi (GPS Lock)',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // SOP Digital Inspection Form Checklist Card
            const Text(
              'Formulir SOP Inspeksi Digital',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Obx(
                      () => CheckboxListTile(
                        value: controller.sopApdChecked.value,
                        onChanged:
                            (v) =>
                                controller.sopApdChecked.value = v ?? false,
                        title: const Text(
                          'Penggunaan APD Lengkap (Masker, Sarung Tangan, Safety Glasses)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        activeColor: AppTheme.primaryColor,
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        value: controller.sopMoistureChecked.value,
                        onChanged:
                            (v) =>
                                controller.sopMoistureChecked.value =
                                    v ?? false,
                        title: const Text(
                          'Pengukuran Kelembapan Kayu dengan Moisture Meter',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        activeColor: AppTheme.primaryColor,
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        value: controller.sopBaitChecked.value,
                        onChanged:
                            (v) =>
                                controller.sopBaitChecked.value = v ?? false,
                        title: const Text(
                          'Injeksi / Pemasangan Umpan Rayap Exterra (Fipronil 2.5L)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        activeColor: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Media Upload Boxes (Before & After Photo Upload Boxes)
            const Text(
              'Foto Dokumentasi Penanganan',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.snackbar(
                          'Foto Uploaded',
                          'Foto Before Treatment tersimpan.',
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add_a_photo,
                            color: AppTheme.primaryColor,
                            size: 28,
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Foto Before Treatment',
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.snackbar(
                          'Foto Uploaded',
                          'Foto After Treatment tersimpan.',
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add_a_photo,
                            color: AppTheme.primaryColor,
                            size: 28,
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Foto After Treatment',
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.goToSignOff,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: const Icon(Icons.draw, color: Colors.white, size: 20),
                label: const Text(
                  'Lanjut Ke Tanda Tangan Klien',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}