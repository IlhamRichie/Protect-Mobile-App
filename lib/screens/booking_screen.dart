import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/sample_data.dart';
import '../models/data_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'payment_screen.dart';

class BookingScreen extends StatefulWidget {
  final ServiceItem? service;

  const BookingScreen({super.key, this.service});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late ServiceItem _selectedService;
  final TextEditingController _addressController = TextEditingController(text: 'Jl. Senopati Raya No. 88, Jakarta Selatan');
  final TextEditingController _notesController = TextEditingController(text: 'Area dapur basah & gudang penyimpanan tepung.');
  String _selectedDate = 'Besok, 03 Sep 2026';
  String _selectedTime = '10:00 WIB';

  final List<String> _dateOptions = ['Hari Ini, 02 Sep', 'Besok, 03 Sep', 'Lusa, 04 Sep', 'Sabtu, 06 Sep'];
  final List<String> _timeOptions = ['08:30 WIB', '10:00 WIB', '13:30 WIB', '15:30 WIB'];

  final NumberFormat _currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    _selectedService = widget.service ?? SampleData.services.first;
  }

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Pemesanan Layanan Pengendalian'),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          border: const Border(top: BorderSide(color: AppColors.borderColor)),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Estimasi Biaya:', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  Text(
                    _currencyFormat.format(_selectedService.price),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.emerald600),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PaymentScreen(
                        service: _selectedService,
                        address: _addressController.text,
                        date: _selectedDate,
                        time: _selectedTime,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.emerald600,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Lanjut Pembayaran', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const InfoBanner(
            text: 'Semua treatment PROTECT disertai Garansi Digital 12 Bulan, pelacakan teknisi real-time, dan dokumentasi kepatuhan HACCP.',
            icon: Icons.verified_user,
          ),
          const SizedBox(height: 16),

          // Select Service
          const SectionHeader(title: '1. Pilih Paket Layanan'),
          const SizedBox(height: 8),
          ...SampleData.services.map((svc) {
            final isSelected = svc.id == _selectedService.id;
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
                onTap: () => setState(() => _selectedService = svc),
                leading: Radio<String>(
                  value: svc.id,
                  groupValue: _selectedService.id,
                  onChanged: (val) => setState(() => _selectedService = svc),
                  activeColor: AppColors.emerald600,
                ),
                title: Text(svc.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                subtitle: Text(svc.subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                trailing: Text(
                  _currencyFormat.format(svc.price),
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.emerald600),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),

          // Date & Time
          const SectionHeader(title: '2. Pilih Tanggal & Waktu Kunjungan'),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _dateOptions.map((d) {
                final isSelected = d == _selectedDate;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(d),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _selectedDate = d),
                    selectedColor: AppColors.emerald600,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                    backgroundColor: AppColors.surfaceLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: isSelected ? AppColors.emerald600 : AppColors.borderColor),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _timeOptions.map((t) {
                final isSelected = t == _selectedTime;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(t),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _selectedTime = t),
                    selectedColor: AppColors.emerald600,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                    backgroundColor: AppColors.surfaceLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: isSelected ? AppColors.emerald600 : AppColors.borderColor),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Address
          const SectionHeader(title: '3. Alamat Lokasi Treatment'),
          const SizedBox(height: 8),
          TextField(
            controller: _addressController,
            maxLines: 2,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.surfaceLight,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderColor)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderColor)),
            ),
          ),
          const SizedBox(height: 16),

          // Notes
          const SectionHeader(title: '4. Catatan Titik Hama / Masalah'),
          const SizedBox(height: 8),
          TextField(
            controller: _notesController,
            maxLines: 2,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.surfaceLight,
              hintText: 'Misal: Terlihat tanda rayap di plafon lantai 2...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderColor)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderColor)),
            ),
          ),
        ],
      ),
    );
  }
}
