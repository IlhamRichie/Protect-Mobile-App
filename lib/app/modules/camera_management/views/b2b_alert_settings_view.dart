import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/b2b_alert_settings_controller.dart';

class B2bAlertSettingsView extends GetView<B2bAlertSettingsController> {
  const B2bAlertSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(B2bAlertSettingsController());

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Integrasi WhatsApp & Alert Settings'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Konfigurasi Notifikasi E-Tilang (<1s Latency)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.darkSlate)),
            const SizedBox(height: 4),
            const Text('Atur penerima notifikasi insiden hama real-time via WhatsApp dan Webhook.', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
            const SizedBox(height: 16),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Obx(
                      () => SwitchListTile(
                        value: controller.isWaAlertEnabled.value,
                        onChanged: (v) => controller.isWaAlertEnabled.value = v,
                        activeColor: AppTheme.primaryColor,
                        title: const Text('Sub-Second WhatsApp Alert', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        subtitle: const Text('Kirim pesan snapshot insiden langsung ke WhatsApp Manager Jaga', style: TextStyle(fontSize: 11)),
                      ),
                    ),
                    const Divider(),
                    TextField(
                      controller: controller.waNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Nomor WhatsApp Manajer Jaga',
                        prefixIcon: const Icon(Icons.phone_android, color: AppTheme.primaryColor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton.icon(
                        onPressed: controller.testWaAlert,
                        icon: const Icon(Icons.send, size: 14, color: AppTheme.primaryColor),
                        label: const Text('Uji Coba WA Alert', style: TextStyle(fontSize: 11, color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Obx(
                      () => SwitchListTile(
                        value: controller.isAutoDispatchEnabled.value,
                        onChanged: (v) => controller.isAutoDispatchEnabled.value = v,
                        activeColor: AppTheme.primaryColor,
                        title: const Text('Auto-Dispatch Penugasan Teknisi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        subtitle: const Text('Terbitkan tiket penanganan otomatis ke teknisi terdekat saat insiden terdeteksi', style: TextStyle(fontSize: 11)),
                      ),
                    ),
                    const Divider(),
                    TextField(
                      controller: controller.webhookUrlController,
                      decoration: InputDecoration(
                        labelText: 'Enterprise Webhook URL',
                        prefixIcon: const Icon(Icons.code, color: AppTheme.primaryColor),
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
                onPressed: controller.saveAlertSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.check_circle, color: Colors.white, size: 20),
                label: const Text('Simpan Konfigurasi Integrasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}