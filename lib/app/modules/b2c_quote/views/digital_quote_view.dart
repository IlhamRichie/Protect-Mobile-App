import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/digital_quote_controller.dart';

class DigitalQuoteView extends GetView<DigitalQuoteController> {
  const DigitalQuoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Digital Quotation & Inspection'),
      ),
      body: Obx(() {
        final q = controller.quote.value;
        if (q == null) return const Center(child: CircularProgressIndicator());

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Visual Stepper: [ Pengajuan ] -> [ Survei Lapangan 🟢 ] -> [ Penawaran ] -> [ Action ]
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStepperItem('Pengajuan', isDone: true),
                    const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                    _buildStepperItem('Survei 🟢', isDone: true, isCurrent: true),
                    const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                    _buildStepperItem('Penawaran', isDone: false),
                    const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                    _buildStepperItem('Action', isDone: false),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Surveyor Profile Card (Bpk. Doni + Rating 4.9)
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: AppTheme.primaryColor,
                        child: Icon(Icons.person, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text('Bpk. Doni Prasetyo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                SizedBox(width: 6),
                                Icon(Icons.star, color: Colors.amber, size: 16),
                                Text(' 4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const Text('Senior Pest Surveyor Specialist', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                          ],
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.primaryColor),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        icon: const Icon(Icons.phone, size: 14, color: AppTheme.primaryColor),
                        label: const Text('Hubungi', style: TextStyle(fontSize: 11, color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Moisture Meter Findings & Photo Grid
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.water_drop, color: Colors.amber, size: 20),
                          SizedBox(width: 6),
                          Text('Hasil Moisture Meter & Temuan Survey', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sensor Reading: ${q.moistureMeterReading}% Kelembaban (Zona Kritis). ${q.findings}',
                        style: const TextStyle(fontSize: 12, height: 1.4, color: AppTheme.textSecondary),
                      ),
                      const SizedBox(height: 12),

                      // Findings Photo Grid
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppTheme.borderColor),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo, color: AppTheme.primaryColor, size: 24),
                                  SizedBox(height: 4),
                                  Text('Fondasi Kayu Kosen', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppTheme.borderColor),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo, color: AppTheme.primaryColor, size: 24),
                                  SizedBox(height: 4),
                                  Text('Jalur Koloni Dapur', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Itemized Price Breakdown Table Card
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
                          const Text('Itemized Quotation Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text('Luas: 120 m²', style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Divider(height: 20),

                      ...q.items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                    const SizedBox(height: 2),
                                    Text(item.description, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                                  ],
                                ),
                              ),
                              Text(currencyFormatter.format(item.price), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                            ],
                          ),
                        ),
                      ),

                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                          Text(currencyFormatter.format(q.subtotal), style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Diskon Promo Referral', style: TextStyle(color: AppTheme.primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('- ${currencyFormatter.format(q.discountAmount)}', style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(
                            currencyFormatter.format(q.grandTotal),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Bottom Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.approveQuoteAndPay,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  label: const Text('Setujui Penawaran & Bayar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStepperItem(String label, {required bool isDone, bool isCurrent = false}) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDone ? AppTheme.primaryColor : Colors.grey.shade300,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isCurrent || isDone ? FontWeight.bold : FontWeight.normal,
            color: isCurrent || isDone ? AppTheme.primaryColor : Colors.grey,
          ),
        ),
      ],
    );
  }
}
