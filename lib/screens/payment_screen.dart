import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/data_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'live_tracker_screen.dart';
import 'digital_warranty_screen.dart';

class PaymentScreen extends StatefulWidget {
  final ServiceItem service;
  final String address;
  final String date;
  final String time;

  const PaymentScreen({
    super.key,
    required this.service,
    required this.address,
    required this.date,
    required this.time,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _voucherController = TextEditingController();
  int _discount = 0;
  bool _voucherApplied = false;
  String _selectedPaymentMethod = 'QRIS Instant Settlement (GOPAY/OVO/BCA)';
  bool _isProcessing = false;
  bool _isSuccess = false;
  int _progressStep = 1;

  final List<String> _paymentMethods = [
    'QRIS Instant Settlement (GOPAY/OVO/BCA)',
    'Virtual Account BCA / Mandiri',
    'Kartu Kredit / Debit Online (Visa/Mastercard)',
    'Bayar Tunai ke Teknisi Lapangan',
  ];

  final NumberFormat _currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  void _applyVoucher() {
    final code = _voucherController.text.trim().toUpperCase();
    if (code == 'PROTECTFREE' || code == 'DISKON50' || code == 'PROTECT50') {
      setState(() {
        _discount = 50000;
        _voucherApplied = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Voucher Berhasil! Diskon Rp 50.000 telah diterapkan.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kode voucher tidak valid. Coba gunakan PROTECTFREE')),
      );
    }
  }

  void _processPayment() {
    setState(() => _isProcessing = true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isProcessing = false;
          _isSuccess = true;
          _progressStep = 2;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = (widget.service.price - _discount).clamp(0, 9999999);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Pembayaran & Konfirmasi Order'),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          border: const Border(top: BorderSide(color: AppColors.borderColor)),
        ),
        child: SafeArea(
          child: _isSuccess
              ? Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const DigitalWarrantyScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.emerald600),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Lihat E-Garansi', style: TextStyle(color: AppColors.emerald600, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const LiveTrackerScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.emerald600,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Lacak Teknisi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total Pembayaran:', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        Text(
                          _currencyFormat.format(totalPrice),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.emerald600),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _isProcessing ? null : _processPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.emerald600,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: _isProcessing
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Bayar Sekarang', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_isSuccess) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.emerald50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.emerald500),
              ),
              child: Column(
                children: [
                  const Icon(Icons.check_circle, size: 48, color: AppColors.emerald600),
                  const SizedBox(height: 8),
                  const Text(
                    'Pembayaran & Booking Berhasil!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.emerald900),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Order #ORD-8821-JKT telah dijadwalkan. Teknisi Doni Pratama siap menuju lokasi.',
                    style: TextStyle(fontSize: 12, color: AppColors.emerald800),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Order Details
          const SectionHeader(title = 'Ringkasan Layanan'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.service.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Jadwal: ${widget.date} • ${widget.time}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                Text('Lokasi: ${widget.address}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal Layanan', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    Text(_currencyFormat.format(widget.service.price), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                if (_discount > 0) ...[
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Diskon Promo Voucher', style: TextStyle(fontSize: 12, color: AppColors.emerald600)),
                      Text('- ${_currencyFormat.format(_discount)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.emerald600)),
                    ],
                  ),
                ],
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Pembayaran', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Text(_currencyFormat.format(totalPrice), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.emerald600)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Voucher Input
          const SectionHeader(title = 'Kode Promo / Voucher'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _voucherController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan voucher (ex: PROTECTFREE)',
                    filled: true,
                    fillColor: AppColors.surfaceLight,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderColor)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderColor)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _applyVoucher,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkSlate900,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Gunakan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Payment Methods
          const SectionHeader(title = 'Metode Pembayaran'),
          const SizedBox(height: 8),
          ..._paymentMethods.map((method) {
            final isSelected = method == _selectedPaymentMethod;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.emerald50 : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColors.emerald600 : AppColors.borderColor,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: ListTile(
                onTap: () => setState(() => _selectedPaymentMethod = method),
                leading: Radio<String>(
                  value: method,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (val) => setState(() => _selectedPaymentMethod = method),
                  activeColor: AppColors.emerald600,
                ),
                title: Text(method, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              ),
            );
          }),
        ],
      ),
    );
  }
}
