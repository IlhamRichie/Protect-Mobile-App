import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/booking_controller.dart';

class SelectScheduleView extends GetView<BookingController> {
  const SelectScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Pilih Jadwal (Step 3 of 3)'),
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
                  _buildStepperNode('2. Alamat', isActive: true),
                  const Expanded(child: Divider(color: AppTheme.primaryColor, thickness: 1.5)),
                  _buildStepperNode('3. Jadwal', isActive: true, isCurrent: true),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Date Picker Widget Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.calendar_month, color: AppTheme.primaryColor, size: 20),
                            SizedBox(width: 8),
                            Text('Pilih Tanggal Kedatangan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_calendar, color: AppTheme.primaryColor),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: controller.selectedDate.value,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 60)),
                            );
                            if (picked != null) {
                              controller.selectedDate.value = picked;
                            }
                          },
                        ),
                      ],
                    ),
                    const Divider(height: 16),
                    Obx(
                      () => Text(
                        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(controller.selectedDate.value),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Grid Time Slot Arrival Times
            const Text('Pilih Slot Jam Kedatangan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.darkSlate)),
            const SizedBox(height: 10),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.availableTimeSlots.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.5,
              ),
              itemBuilder: (context, index) {
                final slot = controller.availableTimeSlots[index];
                return Obx(() {
                  final isSelected = controller.selectedTimeSlot.value == slot;
                  return GestureDetector(
                    onTap: () => controller.selectedTimeSlot.value = slot,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor),
                      ),
                      child: Center(
                        child: Text(
                          slot,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isSelected ? Colors.white : AppTheme.darkSlate,
                          ),
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
            const SizedBox(height: 20),

            // Order Summary Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ringkasan Pesanan Booking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const Divider(height: 20),

                    _buildSummaryRow('Kategori Layanan', 'Termite Control Specialist'),
                    const SizedBox(height: 8),
                    Obx(() => _buildSummaryRow('Lokasi Alamat', controller.fullAddressController.text)),
                    const SizedBox(height: 8),
                    Obx(() => _buildSummaryRow('Jadwal Kedatangan', '${DateFormat('dd MMM yyyy').format(controller.selectedDate.value)} • ${controller.selectedTimeSlot.value}')),
                    const Divider(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text(
                          currencyFormatter.format(controller.servicePrice),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Confirm Booking Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.confirmBookingAndProceedPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.check_circle, color: Colors.white, size: 20),
                label: const Text('Konfirmasi Pesanan & Bayar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.darkSlate),
          ),
        ),
      ],
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
