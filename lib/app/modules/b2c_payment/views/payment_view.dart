import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Pembayaran (Checkout)'),
      ),
      body: Obx(() {
        if (controller.treatmentStep.value > 0) {
          return _buildTreatmentProgressScreen(context, currencyFormatter);
        }
        return _buildCheckoutScreen(context, currencyFormatter);
      }),
    );
  }

  Widget _buildCheckoutScreen(
    BuildContext context,
    NumberFormat currencyFormatter,
  ) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Ringkasan Pesanan
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Ringkasan Layanan Booking',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppTheme.darkSlate,
                              ),
                            ),
                            Text(
                              'Detail',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        _buildRow('Layanan', 'Termite Control Specialist'),
                        const SizedBox(height: 6),
                        _buildRow('Lokasi', 'Jl. Raya Kebayoran Baru No. 45'),
                        const SizedBox(height: 6),
                        _buildRow('Jadwal', 'Besok • 10:00 WIB'),
                        const Divider(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Subtotal Biaya',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            Obx(
                              () => Text(
                                currencyFormatter.format(
                                  controller.subtotal.value,
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(() {
                          if (controller.discount.value <= 0) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Diskon Voucher Promo',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '- ${currencyFormatter.format(controller.discount.value)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Input Field Kode Promo
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.voucherController,
                            decoration: InputDecoration(
                              hintText: 'Kode Promo (e.g. PROTECTFREE)',
                              prefixIcon: const Icon(
                                Icons.card_giftcard,
                                color: AppTheme.primaryColor,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: controller.applyVoucher,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Terapkan',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Radio Button Selection Payment Methods
                const Text(
                  'Pilih Metode Pembayaran',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkSlate,
                  ),
                ),
                const SizedBox(height: 10),

                ...controller.paymentMethods.map((method) {
                  return Obx(() {
                    final isSelected =
                        controller.selectedPaymentMethod.value == method;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              isSelected
                                  ? AppTheme.primaryColor
                                  : AppTheme.borderColor,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: ListTile(
                        onTap: () => controller.selectPaymentMethod(method),
                        leading: Icon(
                          method.contains('QRIS')
                              ? Icons.qr_code_scanner
                              : method.contains('Tunai')
                              ? Icons.payments_outlined
                              : Icons.account_balance_outlined,
                          color:
                              isSelected
                                  ? AppTheme.primaryColor
                                  : Colors.grey,
                        ),
                        title: Text(
                          method,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        trailing:
                            isSelected
                                ? const Icon(
                                  Icons.radio_button_checked,
                                  color: AppTheme.primaryColor,
                                )
                                : const Icon(
                                  Icons.radio_button_unchecked,
                                  color: Colors.grey,
                                ),
                      ),
                    );
                  });
                }),
              ],
            ),
          ),
        ),

        // Sticky Bottom Button "Bayar Sekarang"
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Total Pembayaran:',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Obx(
                      () => Text(
                        currencyFormatter.format(controller.grandTotal),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: controller.processPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.lock, color: Colors.white, size: 18),
                  label: const Text(
                    'Bayar Sekarang',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTreatmentProgressScreen(
    BuildContext context,
    NumberFormat currencyFormatter,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.emerald50,
              border: Border.all(color: AppTheme.primaryColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppTheme.primaryColor,
                  size: 36,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Pembayaran Berhasil Diverifikasi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Teknisi Bpk. Doni siap menuju lokasi untuk melakukan penanganan.',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Live Treatment Progress Tracker',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildStepTile(
            stepIndex: 1,
            currentStep: controller.treatmentStep.value,
            title: 'Pembayaran Dikonfirmasi',
            subtitle: 'Metode terverifikasi otomatis.',
          ),
          _buildStepTile(
            stepIndex: 2,
            currentStep: controller.treatmentStep.value,
            title: 'Teknisi En Route',
            subtitle: 'Bpk. Doni menuju alamat Anda.',
          ),
          _buildStepTile(
            stepIndex: 3,
            currentStep: controller.treatmentStep.value,
            title: 'E-Sign Garansi',
            subtitle: 'Tanda tangan berita acara garansi 12 bulan.',
          ),

          const SizedBox(height: 28),

          Obx(() {
            final isReady = controller.treatmentStep.value >= 3;
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isReady ? controller.goToSignOffWarranty : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: const Icon(Icons.edit_document, color: Colors.white),
                label: Text(
                  isReady
                      ? 'Buka E-Sertifikat Garansi 12 Bulan'
                      : 'Menunggu Teknisi Selesai...',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStepTile({
    required int stepIndex,
    required int currentStep,
    required String title,
    required String subtitle,
  }) {
    final isDone = currentStep >= stepIndex;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isDone ? AppTheme.primaryColor : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkSlate,
          ),
        ),
      ],
    );
  }
}