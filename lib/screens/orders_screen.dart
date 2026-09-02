import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/sample_data.dart';
import '../models/data_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'live_tracker_screen.dart';
import 'digital_warranty_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['Semua', 'Sedang Berjalan', 'Selesai', 'Garansi Aktif'];
  final NumberFormat _currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    final orders = SampleData.getInitialOrders();
    final filtered = orders.where((ord) {
      if (_selectedFilterIndex == 1) return ord.status == OrderStatus.enRoute || ord.status == OrderStatus.inProgress;
      if (_selectedFilterIndex == 2) return ord.status == OrderStatus.completed;
      if (_selectedFilterIndex == 3) return ord.warrantyUntil.isNotEmpty;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Daftar Pesanan & Riwayat Treatment'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_filters.length, (i) {
                final isSelected = _selectedFilterIndex == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(_filters[i]),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _selectedFilterIndex = i),
                    selectedColor: AppColors.emerald600,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    backgroundColor: AppColors.surfaceLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? AppColors.emerald600 : AppColors.borderColor,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),

          ...filtered.map((ord) {
            final isEnRoute = ord.status == OrderStatus.enRoute;
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderColor),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ord.orderNumber,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          color: AppColors.emerald600,
                        ),
                      ),
                      StatusBadge(
                        text: isEnRoute ? 'TEKNISI MENUJU LOKASI' : 'SELESAI (TERLINDUNGI)',
                        backgroundColor: isEnRoute ? AppColors.emerald50 : AppColors.emerald100.withOpacity(0.5),
                        textColor: isEnRoute ? AppColors.emerald700 : AppColors.emerald900,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    ord.serviceTitle,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.darkSlate900),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Jadwal: ${ord.date} • ${ord.time}',
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Alamat: ${ord.address}',
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total Pembayaran', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                          Text(
                            _currencyFormat.format(ord.price),
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.darkSlate900),
                          ),
                        ],
                      ),
                      if (isEnRoute)
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const LiveTrackerScreen()),
                            );
                          },
                          icon: const Icon(Icons.navigation, size: 14, color: Colors.white),
                          label: const Text('Live GPS Tracking', style: TextStyle(fontSize: 11, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.emerald600,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                        )
                      else
                        OutlinedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const DigitalWarrantyScreen()),
                            );
                          },
                          icon: const Icon(Icons.verified, size: 14, color: AppColors.emerald600),
                          label: const Text('E-Garansi 12 Bln', style: TextStyle(fontSize: 11, color: AppColors.emerald600)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.emerald600),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
