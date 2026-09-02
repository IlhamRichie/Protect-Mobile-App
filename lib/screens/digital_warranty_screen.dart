import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'cs_chat_screen.dart';

class DigitalWarrantyScreen extends StatelessWidget {
  const DigitalWarrantyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Sertifikat E-Garansi Digital 12 Bulan'),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          border: const Border(top: BorderSide(color: AppColors.borderColor)),
        ),
        child: SafeArea(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CsChatScreen()),
              );
            },
            icon: const Icon(Icons.verified_user, color: Colors.white),
            label: const Text('Klaim Re-Treatment Garansi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.emerald600,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Certificate Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFD97706), width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD97706).withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.emerald600,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.shield, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'PROTECT PCO',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.darkSlate900),
                        ),
                      ],
                    ),
                    const StatusBadge(
                      text: 'GOLD WARRANTY',
                      backgroundColor: Color(0xFFFEF3C7),
                      textColor: Color(0xFFB45309),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'SERTIFIKAT JAMINAN PROTEKSI RESMI',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: Color(0xFF92400E),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                const Text(
                  'No. Sertifikat: PRT-GAR-2026-9921',
                  style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                ),
                const Divider(height: 24),

                _buildCertRow('Penerima Sertifikat', 'PT. Boga Lestari Prima (Senopati Hub)'),
                const SizedBox(height: 8),
                _buildCertRow('Jenis Layanan', 'Termite Barrier & Rodent Control'),
                const SizedBox(height: 8),
                _buildCertRow('Tanggal Perlakuan', '02 September 2026'),
                const SizedBox(height: 8),
                _buildCertRow('Masa Berlaku Garansi', '02 Sep 2026 s/d 02 Sep 2027 (12 Bulan)'),
                const SizedBox(height: 8),
                _buildCertRow('Teknisi Penanggung Jawab', 'Doni Pratama (ID: TECH-09)'),
                const Divider(height: 24),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.qr_code_2, size: 48, color: AppColors.darkSlate900),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'SHA-256 Digital Verification Hash:',
                              style: TextStyle(fontSize: 9, color: AppColors.textSecondary),
                            ),
                            Text(
                              'a9f82c3...7e1b4028 (Verified Active)',
                              style: TextStyle(fontSize: 10, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: AppColors.emerald700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Warranty Terms
          const SectionHeader(title: 'Ketentuan Jaminan Re-Treatment'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: const [
                _WarrantyTermItem(
                  number: '1',
                  text: 'Jika ditemukan kembali aktivitas hama target selama masa garansi aktif, teknisi akan melakukan re-treatment gratis tanpa biaya tambahan.',
                ),
                SizedBox(height: 10),
                _WarrantyTermItem(
                  number: '2',
                  text: 'Pengendalian menggunakan formula ramah lingkungan berstandar HACCP dan aman bagi area pengolahan makanan.',
                ),
                SizedBox(height: 10),
                _WarrantyTermItem(
                  number: '3',
                  text: 'Klaim dapat diajukan secara instan melalui aplikasi atau hotline CS 24/7 dengan waktu respon maksimal 4 jam kerja.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.darkSlate900),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class _WarrantyTermItem extends StatelessWidget {
  final String number;
  final String text;

  const _WarrantyTermItem({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: const BoxDecoration(
            color: AppColors.emerald50,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.emerald700),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
        ),
      ],
    );
  }
}
