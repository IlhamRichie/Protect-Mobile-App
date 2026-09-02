import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ResolveTicketScreen extends StatefulWidget {
  final String incidentId;

  const ResolveTicketScreen({super.key, required this.incidentId});

  @override
  State<ResolveTicketScreen> createState() => _ResolveTicketScreenState();
}

class _ResolveTicketScreenState extends State<ResolveTicketScreen> {
  final TextEditingController _notesController = TextEditingController(
    text: 'Telah dilakukan sanitasi mendalam, pemasangan seal stainless pada pipa bawah sink, serta restock bait station #3.',
  );

  bool _checkSanitation = true;
  bool _checkBait = true;
  bool _checkPerimeter = true;
  bool _checkSigned = true;
  bool _isSuccess = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _submitResolution() {
    setState(() => _isSuccess = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Penyelesaian Tiket Temuan (HACCP)'),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          border: const Border(top: BorderSide(color: AppColors.borderColor)),
        ),
        child: SafeArea(
          child: ElevatedButton.icon(
            onPressed: _isSuccess ? null : _submitResolution,
            icon: const Icon(Icons.check_circle, color: Colors.white),
            label: Text(
              _isSuccess ? 'Tiket Berhasil Diselesaikan' : 'Tutup & Simpan Tiket Audit',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
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
          const InfoBanner(
            text: 'Verifikasi seluruh checklist tindakan korektif untuk memastikan integritas kepatuhan audit BPOM & HACCP.',
            icon: Icons.fact_check,
          ),
          const SizedBox(height: 16),

          if (_isSuccess) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.emerald50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.emerald500),
              ),
              child: Row(
                children: const [
                  Icon(Icons.verified, color: AppColors.emerald600, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tiket temuan berhasil ditutup! Data tindakan telah dimasukkan ke dalam log audit HACCP.',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.emerald800),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Checklist
          const SectionHeader(title: '1. Checklist Verifikasi Tindakan'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: [
                CheckboxListTile(
                  value: _checkSanitation,
                  onChanged: (val) => setState(() => _checkSanitation = val ?? false),
                  title: const Text('Pembersihan sisa residu organik & sanitasi area'),
                  activeColor: AppColors.emerald600,
                ),
                const Divider(height: 1),
                CheckboxListTile(
                  value: _checkBait,
                  onChanged: (val) => setState(() => _checkBait = val ?? false),
                  title: const Text('Pemberian Eco-Gel Bait / Stasiun Umpan Baru'),
                  activeColor: AppColors.emerald600,
                ),
                const Divider(height: 1),
                CheckboxListTile(
                  value: _checkPerimeter,
                  onChanged: (val) => setState(() => _checkPerimeter = val ?? false),
                  title: const Text('Penutupan celah ingress struktural dengan mesh'),
                  activeColor: AppColors.emerald600,
                ),
                const Divider(height: 1),
                CheckboxListTile(
                  value: _checkSigned,
                  onChanged: (val) => setState(() => _checkSigned = val ?? false),
                  title: const Text('Persetujuan Supervisor Fasilitas & Teknisi PCO'),
                  activeColor: AppColors.emerald600,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Notes
          const SectionHeader(title: '2. Laporan Tindakan Korektif (Log Catatan)'),
          const SizedBox(height: 8),
          TextField(
            controller: _notesController,
            maxLines: 4,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.surfaceLight,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderColor)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderColor)),
            ),
          ),
        ],
      ),
    );
  }
}
