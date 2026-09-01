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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;
            final double horizontalPadding = isTablet ? 24.0 : 16.0;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16.0,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 850),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Action: Large Button GPS Lock Check-In
                      _buildGpsCheckInButton(),
                      const SizedBox(height: 20),

                      // SOP Digital Inspection Form Checklist Card
                      const Text(
                        'Formulir SOP Inspeksi Digital',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkSlate,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildSopChecklistCard(),
                      const SizedBox(height: 20),

                      // Media Upload Boxes (Before & After Photo Upload)
                      const Text(
                        'Foto Dokumentasi Penanganan',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkSlate,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildPhotoUploadGrid(),
                      const SizedBox(height: 28),

                      // Proceed to Client Sign-Off CTA
                      _buildProceedButton(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGpsCheckInButton() {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: controller.isGpsCheckedIn.value
              ? null
              : controller.doGpsCheckIn,
          style: ElevatedButton.styleFrom(
            backgroundColor: controller.isGpsCheckedIn.value
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
          label: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              controller.isGpsCheckedIn.value
                  ? 'Check-In Lokasi Verifikasi (GPS Lock Active)'
                  : 'Check-In Lokasi (GPS Lock)',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSopChecklistCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppTheme.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          children: [
            Obx(
              () => CheckboxListTile(
                value: controller.sopApdChecked.value,
                onChanged: (v) =>
                    controller.sopApdChecked.value = v ?? false,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: const Text(
                  'Penggunaan APD Lengkap (Masker, Sarung Tangan, Safety Glasses)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkSlate,
                  ),
                ),
                activeColor: AppTheme.primaryColor,
              ),
            ),
            Obx(
              () => CheckboxListTile(
                value: controller.sopMoistureChecked.value,
                onChanged: (v) =>
                    controller.sopMoistureChecked.value = v ?? false,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: const Text(
                  'Pengukuran Kelembapan Kayu dengan Moisture Meter',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkSlate,
                  ),
                ),
                activeColor: AppTheme.primaryColor,
              ),
            ),
            Obx(
              () => CheckboxListTile(
                value: controller.sopBaitChecked.value,
                onChanged: (v) =>
                    controller.sopBaitChecked.value = v ?? false,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: const Text(
                  'Injeksi / Pemasangan Umpan Rayap Exterra (Fipronil 2.5L)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkSlate,
                  ),
                ),
                activeColor: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoUploadGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildUploadBox(
            title: 'Foto Before Treatment',
            onTap: () {
              Get.snackbar(
                'Foto Uploaded',
                'Foto Before Treatment tersimpan.',
                snackPosition: SnackPosition.TOP,
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildUploadBox(
            title: 'Foto After Treatment',
            onTap: () {
              Get.snackbar(
                'Foto Uploaded',
                'Foto After Treatment tersimpan.',
                snackPosition: SnackPosition.TOP,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUploadBox({required String title, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.primaryColor,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_a_photo,
                color: AppTheme.primaryColor,
                size: 28,
              ),
              const SizedBox(height: 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProceedButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: controller.goToSignOff,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.draw, color: Colors.white, size: 20),
        label: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Lanjut Ke Tanda Tangan Klien',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}