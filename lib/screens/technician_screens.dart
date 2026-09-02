import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/data_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

// 1. Technician Job Board
class TechnicianJobBoardScreen extends StatefulWidget {
  const TechnicianJobBoardScreen({super.key});

  @override
  State<TechnicianJobBoardScreen> createState() => _TechnicianJobBoardScreenState();
}

class _TechnicianJobBoardScreenState extends State<TechnicianJobBoardScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['Semua', 'Tugas Baru (Assigned)', 'Sedang Dikerjakan', 'Selesai'];

  @override
  Widget build(BuildContext context) {
    final jobs = SampleData.getInitialJobs();
    final filtered = jobs.where((j) {
      if (_selectedFilter == 1) return j.status == JobStatus.assigned;
      if (_selectedFilter == 2) return j.status == JobStatus.inProgress;
      if (_selectedFilter == 3) return j.status == JobStatus.completed;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Papan Tugas Lapangan Teknisi'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const InfoBanner(
            text: 'Mode Teknisi Aktif: Doni Pratama (ID: TECH-09). Pastikan pengisian SOP keselamatan APD & pencatatan chemical log lengkap sebelum meminta tanda tangan digital.',
            icon: Icons.engineering,
          ),
          const SizedBox(height: 16),

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_filters.length, (i) {
                final isSelected = _selectedFilter == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(_filters[i]),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _selectedFilter = i),
                    selectedColor: AppColors.emerald600,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                    backgroundColor: AppColors.surfaceLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: isSelected ? AppColors.emerald600 : AppColors.borderColor),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),

          ...filtered.map((job) => Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => TechnicianJobDetailScreen(job: job)),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            job.code,
                            style: const TextStyle(fontSize: 12, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: AppColors.emerald600),
                          ),
                          StatusBadge(
                            text: job.status == JobStatus.assigned
                                ? 'ASSIGNED'
                                : job.status == JobStatus.inProgress
                                    ? 'IN PROGRESS'
                                    : 'COMPLETED',
                            backgroundColor: job.status == JobStatus.assigned
                                ? AppColors.warningBackground
                                : job.status == JobStatus.inProgress
                                    ? AppColors.emerald50
                                    : AppColors.emerald100,
                            textColor: job.status == JobStatus.assigned
                                ? AppColors.warning
                                : job.status == JobStatus.inProgress
                                    ? AppColors.emerald700
                                    : AppColors.emerald900,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(job.clientName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.darkSlate900)),
                      const SizedBox(height: 4),
                      Text('Layanan: ${job.serviceType}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      Text('Target Hama: ${job.pestType}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.darkSlate800)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.schedule, size: 13, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(job.scheduleTime, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 13, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(job.address, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('Buka Prosedur & SOP', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.emerald600)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.emerald600),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

// 2. Technician Job Detail
class TechnicianJobDetailScreen extends StatelessWidget {
  final TechnicianJob job;

  const TechnicianJobDetailScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Detail Penugasan Lapangan'),
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
                MaterialPageRoute(builder: (_) => TechnicianSopScreen(job: job)),
              );
            },
            icon: const Icon(Icons.play_arrow, color: Colors.white),
            label: const Text('Mulai Checklist SOP & APD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(job.code, style: const TextStyle(fontSize: 13, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: AppColors.emerald600)),
                    StatusBadge(
                      text: job.status.name.toUpperCase(),
                      backgroundColor: AppColors.emerald50,
                      textColor: AppColors.emerald700,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(job.clientName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkSlate900)),
                const SizedBox(height: 2),
                Text(job.address, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone, size: 14, color: AppColors.emerald600),
                    const SizedBox(width: 6),
                    Text(job.phone, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.emerald600)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          const SectionHeader(title = 'Parameter Pekerjaan'),
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
                _buildRow('Jenis Layanan', job.serviceType),
                const SizedBox(height: 8),
                _buildRow('Target Spesies', job.pestType),
                const SizedBox(height: 8),
                _buildRow('Tingkat Keparahan', job.severity),
                const SizedBox(height: 8),
                _buildRow('Jadwal', job.scheduleTime),
                const Divider(height: 20),
                const Text('Catatan Khusus Klien:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.darkSlate900)),
                const SizedBox(height: 4),
                Text(job.notes, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          const SectionHeader(title = 'Akses Cepat Tahapan'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => TechnicianChemicalLogScreen(job: job)),
                    );
                  },
                  icon: const Icon(Icons.science, size: 16),
                  label: const Text('Chemical Log', style: TextStyle(fontSize: 11)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.emerald600,
                    side: const BorderSide(color: AppColors.emerald600),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => TechnicianSignoffScreen(job: job)),
                    );
                  },
                  icon: const Icon(Icons.draw, size: 16),
                  label: const Text('E-Sign TTD', style: TextStyle(fontSize: 11)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.emerald600,
                    side: const BorderSide(color: AppColors.emerald600),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.darkSlate900)),
      ],
    );
  }
}

// 3. Technician SOP Checklist
class TechnicianSopScreen extends StatefulWidget {
  final TechnicianJob job;

  const TechnicianSopScreen({super.key, required this.job});

  @override
  State<TechnicianSopScreen> createState() => _TechnicianSopScreenState();
}

class _TechnicianSopScreenState extends State<TechnicianSopScreen> {
  final List<Map<String, dynamic>> _apdList = [
    {'name': 'Masker Respirator N95 / Katrid Kimia', 'checked': true},
    {'name': 'Sarung Tangan Nitril Tahan Kimia', 'checked': true},
    {'name': 'Kacamata Goggles Keselamatan K3', 'checked': true},
    {'name': 'Sepatu Safety Boots Anti-Slip', 'checked': true},
    {'name': 'Wearpack Standar Sanitasi HACCP', 'checked': false},
  ];

  final List<Map<String, dynamic>> _prepList = [
    {'name': 'Identifikasi titik ingress pipa saluran', 'checked': true},
    {'name': 'Kalibrasi alat cold fogger / sprayer', 'checked': true},
    {'name': 'Konfirmasi evakuasi bahan pangan terbuka', 'checked': true},
    {'name': 'Pemberitahuan kepada supervisor area', 'checked': false},
  ];

  bool get _isAllChecked =>
      _apdList.every((item) => item['checked'] == true) &&
      _prepList.every((item) => item['checked'] == true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Checklist Prosedur SOP & APD'),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          border: const Border(top: BorderSide(color: AppColors.borderColor)),
        ),
        child: SafeArea(
          child: ElevatedButton.icon(
            onPressed: _isAllChecked
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => TechnicianChemicalLogScreen(job: widget.job)),
                    );
                  }
                : null,
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            label: const Text('Lanjut ke Log Dosis Bahan Kimia', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
            text: 'Kepatuhan K3 & APD adalah syarat mutlak audit HACCP. Centang seluruh item untuk membuka form pencatatan bahan kimia.',
            icon: Icons.health_and_safety,
          ),
          const SizedBox(height: 16),

          const SectionHeader(title = '1. Kelengkapan Alat Pelindung Diri (APD)'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: List.generate(_apdList.length, (idx) {
                final item = _apdList[idx];
                return CheckboxListTile(
                  value: item['checked'] as bool,
                  onChanged: (val) => setState(() => item['checked'] = val ?? false),
                  title: Text(item['name'] as String, style: const TextStyle(fontSize: 13)),
                  activeColor: AppColors.emerald600,
                );
              }),
            ),
          ),
          const SizedBox(height: 16),

          const SectionHeader(title = '2. Inspeksi Area & Keamanan Pangan'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: List.generate(_prepList.length, (idx) {
                final item = _prepList[idx];
                return CheckboxListTile(
                  value: item['checked'] as bool,
                  onChanged: (val) => setState(() => item['checked'] = val ?? false),
                  title: Text(item['name'] as String, style: const TextStyle(fontSize: 13)),
                  activeColor: AppColors.emerald600,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// 4. Technician Chemical Log
class TechnicianChemicalLogScreen extends StatefulWidget {
  final TechnicianJob job;

  const TechnicianChemicalLogScreen({super.key, required this.job});

  @override
  State<TechnicianChemicalLogScreen> createState() => _TechnicianChemicalLogScreenState();
}

class _TechnicianChemicalLogScreenState extends State<TechnicianChemicalLogScreen> {
  String _selectedAgent = 'Eco-Gel Fipronil 0.05% (Botanical Bio-Bait)';
  final TextEditingController _dosageController = TextEditingController(text: '25');
  String _selectedUnit = 'Gram (g)';
  final TextEditingController _locController = TextEditingController(text: 'Perimeter bawah sink & rak gudang bahan basah.');

  final List<String> _agents = [
    'Eco-Gel Fipronil 0.05% (Botanical Bio-Bait)',
    'Pyrethrum Natural Extract 1.5% Cold Fog',
    'Imidacloprid Eco-Barrier Termiticide',
    'Coumatetralyl IoT Smart Bait Block',
  ];

  final List<String> _units = ['Gram (g)', 'Milliliter (mL)', 'Liter (L)', 'Bait Station Unit'];

  @override
  void dispose() {
    _dosageController.dispose();
    _locController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Pencatatan Dosis Bahan Kimia (HACCP)'),
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
                MaterialPageRoute(builder: (_) => TechnicianSignoffScreen(job: widget.job)),
              );
            },
            icon: const Icon(Icons.draw, color: Colors.white),
            label: const Text('Simpan Log & Lanjut Tanda Tangan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
            text: 'Dosis bahan aktif dicatat untuk pelacakan residu kimia pangan dan perhitungan reduksi jejak karbon pada dashboard ESG klien.',
            icon: Icons.science,
          ),
          const SizedBox(height: 16),

          const SectionHeader(title = '1. Pilih Formula Bahan Aktif'),
          const SizedBox(height: 8),
          ..._agents.map((ag) {
            final isSelected = ag == _selectedAgent;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.emerald50 : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isSelected ? AppColors.emerald600 : AppColors.borderColor, width: isSelected ? 2 : 1),
              ),
              child: ListTile(
                onTap: () => setState(() => _selectedAgent = ag),
                leading: Radio<String>(
                  value: ag,
                  groupValue: _selectedAgent,
                  onChanged: (val) => setState(() => _selectedAgent = ag),
                  activeColor: AppColors.emerald600,
                ),
                title: Text(ag, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            );
          }),
          const SizedBox(height: 16),

          const SectionHeader(title = '2. Jumlah Dosis & Satuan Ukur'),
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
                TextField(
                  controller: _dosageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Jumlah / Volume Dosis'),
                ),
                const SizedBox(height: 12),
                const Text('Satuan Ukur:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.darkSlate900)),
                const SizedBox(height: 6),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _units.map((u) {
                      final isSelected = u == _selectedUnit;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(u),
                          selected: isSelected,
                          onSelected: (val) => setState(() => _selectedUnit = u),
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
              ],
            ),
          ),
          const SizedBox(height: 16),

          const SectionHeader(title = '3. Lokasi Penempatan Spesifik'),
          const SizedBox(height: 8),
          TextField(
            controller: _locController,
            maxLines: 2,
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

// 5. Technician Digital Signature Pad
class TechnicianSignoffScreen extends StatefulWidget {
  final TechnicianJob job;

  const TechnicianSignoffScreen({super.key, required this.job});

  @override
  State<TechnicianSignoffScreen> createState() => _TechnicianSignoffScreenState();
}

class _TechnicianSignoffScreenState extends State<TechnicianSignoffScreen> {
  final List<List<Offset>> _strokes = [];
  List<Offset> _currentStroke = [];
  bool _isSubmitted = false;

  void _clearPad() {
    setState(() {
      _strokes.clear();
      _currentStroke.clear();
    });
  }

  void _submitSignoff() {
    setState(() => _isSubmitted = true);
  }

  @override
  Widget build(BuildContext context) {
    final hasSignature = _strokes.isNotEmpty || _currentStroke.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Tanda Tangan Berita Acara Digital'),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          border: const Border(top: BorderSide(color: AppColors.borderColor)),
        ),
        child: SafeArea(
          child: ElevatedButton.icon(
            onPressed: (_isSubmitted || !hasSignature) ? null : _submitSignoff,
            icon: const Icon(Icons.verified, color: Colors.white),
            label: Text(
              _isSubmitted ? 'Pekerjaan Ditutup & Garansi Terbit' : 'Selesaikan Tugas & Terbitkan Garansi',
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
            text: 'Minta tanda tangan perwakilan klien (Supervisor/QA Facility) di bawah ini sebagai konfirmasi pekerjaan telah selesai sesuai standar HACCP.',
            icon: Icons.draw,
          ),
          const SizedBox(height: 16),

          if (_isSubmitted) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.emerald50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.emerald500),
              ),
              child: Column(
                children: [
                  const Icon(Icons.check_circle, color: AppColors.emerald600, size: 36),
                  const SizedBox(height: 8),
                  const Text(
                    'Berita Acara & Sertifikat E-Garansi 12 Bulan Berhasil Diterbitkan!',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.emerald900),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkSlate900),
                    child: const Text('Kembali ke Beranda', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Interactive Signature Pad
          SectionHeader(
            title = 'Pad Tanda Tangan Klien (E-Sign)',
            actionTitle = 'Hapus / Ulangi',
            onAction: _clearPad,
          ),
          const SizedBox(height: 8),
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.emerald600, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  GestureDetector(
                    onPanStart: (details) {
                      setState(() {
                        _currentStroke = [details.localPosition];
                      });
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        _currentStroke.add(details.localPosition);
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        if (_currentStroke.isNotEmpty) {
                          _strokes.add(List.from(_currentStroke));
                          _currentStroke.clear();
                        }
                      });
                    },
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: SignaturePainter(strokes: _strokes, currentStroke: _currentStroke),
                    ),
                  ),
                  if (!hasSignature)
                    const Center(
                      child: Text(
                        'Goreskan tanda tangan di sini...',
                        style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Signer Info
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
                Text('Penandatangan: ${widget.job.clientName}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                const Text('Waktu: 02 September 2026 • Status: Verified', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final List<Offset> currentStroke;

  SignaturePainter({required this.strokes, required this.currentStroke});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.darkSlate900
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final stroke in strokes) {
      if (stroke.length > 1) {
        final path = Path();
        path.moveTo(stroke[0].dx, stroke[0].dy);
        for (int i = 1; i < stroke.length; i++) {
          path.lineTo(stroke[i].dx, stroke[i].dy);
        }
        canvas.drawPath(path, paint);
      }
    }

    if (currentStroke.length > 1) {
      final path = Path();
      path.moveTo(currentStroke[0].dx, currentStroke[0].dy);
      for (int i = 1; i < currentStroke.length; i++) {
        path.lineTo(currentStroke[i].dx, currentStroke[i].dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SignaturePainter oldDelegate) => true;
}
