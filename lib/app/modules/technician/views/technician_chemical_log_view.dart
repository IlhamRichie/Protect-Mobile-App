import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/technician_chemical_log_controller.dart';

class TechnicianChemicalLogView extends GetView<TechnicianChemicalLogController> {
  const TechnicianChemicalLogView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TechnicianChemicalLogController());

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Log Penggunaan Bahan & Umpan'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pencatatan Dosis Bahan Ramah Lingkungan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.darkSlate)),
            const SizedBox(height: 4),
            const Text('Data ini langsung tersinkronisasi ke Dashboard ESG Audit HACCP.', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
            const SizedBox(height: 16),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pilih Jenis Agent / Bahan Eco-Friendly', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 8),
                    Obx(
                      () => DropdownButtonFormField<String>(
                        value: controller.selectedAgent.value,
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                        items: controller.ecoAgents.map((agent) {
                          return DropdownMenuItem(value: agent, child: Text(agent, style: const TextStyle(fontSize: 12)));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) controller.selectedAgent.value = val;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: controller.dosageController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Takaran / Dosis',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: Obx(
                            () => DropdownButtonFormField<String>(
                              value: controller.selectedUnit.value,
                              decoration: InputDecoration(
                                labelText: 'Satuan',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              items: controller.units.map((u) {
                                return DropdownMenuItem(value: u, child: Text(u, style: const TextStyle(fontSize: 12)));
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) controller.selectedUnit.value = val;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: controller.notesController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Catatan Titik Penempatan / Aplikasi',
                        hintText: 'Contoh: Dipasang pada station underground sudut utara gudang...',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.submitChemicalLog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.save_alt, color: Colors.white, size: 20),
                label: const Text('Simpan Log & Verifikasi ESG', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}