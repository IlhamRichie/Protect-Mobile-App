import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ExportHaccpScreen extends StatefulWidget {
  const ExportHaccpScreen({super.key});

  @override
  State<ExportHaccpScreen> createState() => _ExportHaccpScreenState();
}

class _ExportHaccpScreenState extends State<ExportHaccpScreen> {
  String _selectedPeriod = 'Bulan Ini (September 2026)';
  String _selectedFormat = 'PDF Formal (Audit Ready)';
  bool _includeThermalSnapshots = true;
  bool _includeChemicalLog = true;
  bool _includeCryptographicHash = true;
  bool _isExported = false;

  final List<String> _periods = [
    'Bulan Ini (September 2026)',
    'Kuartal III 2026',
    'Tahun Berjalan 2026',
    'Kustom 30 Hari Terakhir',
  ];

  final List<String> _formats = [
    'PDF Formal (Audit Ready)',
    'Excel Spreadsheet (.xlsx)',
    'Raw CSV Data Stream',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Ekspor Laporan Audit HACCP'),
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
              setState(() => _isExported = true);
            },
            icon: const Icon(Icons.file_download, color: Colors.white),
            label: Text(
              _isExported ? 'Laporan Berhasil Diunduh' : 'Download Laporan Resmi',
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
            text: 'Dokumen audit ini memenuhi persyaratan sertifikasi keamanan pangan ISO 22000, FSSC 22000, BRCGS, dan standar sanitasi BPOM.',
            icon: Icons.verified,
          ),
          const SizedBox(height: 16),

          if (_isExported) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.emerald50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.emerald500),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'File Laporan Terunduh:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.emerald900),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'HACCP_Audit_Report_Sep2026_PT_Boga_Lestari.pdf (2.4 MB)',
                    style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: AppColors.emerald800),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'SHA-256: 7d94f288...3e01bc (Tersertifikasi)',
                    style: TextStyle(fontSize: 9, fontFamily: 'monospace', color: AppColors.emerald700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Period Selector
          const SectionHeader(title: '1. Pilih Periode Audit'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedPeriod,
                isExpanded: true,
                items: _periods.map((p) => DropdownMenuItem(value: p, child: Text(p, style: const TextStyle(fontSize: 13)))).toList(),
                onChanged: (val) => setState(() => _selectedPeriod = val!),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Format Selector
          const SectionHeader(title: '2. Format Dokumen'),
          const SizedBox(height: 8),
          ..._formats.map((fmt) {
            final isSelected = fmt == _selectedFormat;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.emerald50 : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isSelected ? AppColors.emerald600 : AppColors.borderColor, width: isSelected ? 2 : 1),
              ),
              child: ListTile(
                onTap: () => setState(() => _selectedFormat = fmt),
                leading: Radio<String>(
                  value: fmt,
                  groupValue: _selectedFormat,
                  onChanged: (val) => setState(() => _selectedFormat = fmt),
                  activeColor: AppColors.emerald600,
                ),
                title: Text(fmt, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            );
          }),
          const SizedBox(height: 16),

          // Inclusions
          const SectionHeader(title: '3. Lampiran Bukti'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  value: _includeThermalSnapshots,
                  onChanged: (val) => setState(() => _includeThermalSnapshots = val),
                  title: const Text('Foto Snapshot Deteksi AI & Bounding Box', style: TextStyle(fontSize: 13)),
                  activeColor: AppColors.emerald600,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: _includeChemicalLog,
                  onChanged: (val) => setState(() => _includeChemicalLog = val),
                  title: const Text('Catatan Dosis & Formulasi Bahan Kimia', style: TextStyle(fontSize: 13)),
                  activeColor: AppColors.emerald600,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: _includeCryptographicHash,
                  onChanged: (val) => setState(() => _includeCryptographicHash = val),
                  title: const Text('Stempel Hash Kriptografi Audit Trail', style: TextStyle(fontSize: 13)),
                  activeColor: AppColors.emerald600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
