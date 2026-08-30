import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/booking_controller.dart';

class SelectAddressView extends GetView<BookingController> {
  const SelectAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Pilih Alamat (Step 2 of 3)'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stepper Progress
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Row(
                children: [
                  _buildStepperNode('1. Layanan', isActive: true),
                  const Expanded(child: Divider(color: AppTheme.primaryColor, thickness: 1.5)),
                  _buildStepperNode('2. Alamat', isActive: true, isCurrent: true),
                  const Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                  _buildStepperNode('3. Jadwal', isActive: false),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Saved Addresses Tiles
            const Text('Pilih Alamat Tersimpan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkSlate)),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    final isSelected = controller.selectedSavedAddress.value == 'Rumah';
                    return GestureDetector(
                      onTap: () => controller.selectedSavedAddress.value = 'Rumah',
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryColor.withOpacity(0.08) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor, width: isSelected ? 2 : 1),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.home, color: isSelected ? AppTheme.primaryColor : Colors.grey, size: 20),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Rumah', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                Text('Tebet, Jakarta', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(() {
                    final isSelected = controller.selectedSavedAddress.value == 'Kantor';
                    return GestureDetector(
                      onTap: () => controller.selectedSavedAddress.value = 'Kantor',
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryColor.withOpacity(0.08) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor, width: isSelected ? 2 : 1),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.business, color: isSelected ? AppTheme.primaryColor : Colors.grey, size: 20),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Kantor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                Text('Kuningan, Jakarta', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Form New Address / Map Pin Point Preview
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Detail Alamat & Map Pin Point', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 10),

                    // Map Preview Box
                    Container(
                      height: 110,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.borderColor),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on, color: AppTheme.primaryColor, size: 32),
                              const SizedBox(height: 4),
                              Obx(() => Text(controller.mapPinLocation.value, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.darkSlate))),
                            ],
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                              child: const Text('Ubah Pinpoint', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    TextField(
                      controller: controller.fullAddressController,
                      decoration: InputDecoration(
                        labelText: 'Alamat Lengkap Bangunan',
                        prefixIcon: const Icon(Icons.map_outlined, color: AppTheme.primaryColor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.unitNoController,
                            decoration: InputDecoration(
                              labelText: 'No. Unit / Blok',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: controller.postalCodeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Kode Pos',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: controller.notesController,
                      decoration: InputDecoration(
                        labelText: 'Instruksi Khusus Teknisi (Opsional)',
                        hintText: 'Contoh: Pagar warna hitam, ada hewan peliharaan...',
                        prefixIcon: const Icon(Icons.note_alt_outlined, color: AppTheme.primaryColor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Navigation Buttons (Kembali & Lanjutkan)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppTheme.primaryColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('← Kembali', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.goToScheduleStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Lanjutkan (Pilih Jadwal) →', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperNode(String title, {required bool isActive, bool isCurrent = false}) {
    return Row(
      children: [
        Icon(
          isActive ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isActive ? AppTheme.primaryColor : Colors.grey,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isCurrent || isActive ? FontWeight.bold : FontWeight.normal,
            color: isCurrent || isActive ? AppTheme.primaryColor : Colors.grey,
          ),
        ),
      ],
    );
  }
}
