import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/b2b_alert_settings_controller.dart';

class B2bAlertSettingsView extends GetView<B2bAlertSettingsController> {
  const B2bAlertSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Integrasi WhatsApp & Alert Settings'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;
            final double horizontalPadding = isTablet ? 24.0 : 16.0;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16.0,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 850),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      const Text(
                        'Konfigurasi Notifikasi E-Tilang (<1s Latency)',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkSlate,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Atur penerima notifikasi insiden hama real-time via WhatsApp dan Webhook.',
                        style: TextStyle(fontSize: 11, color: AppTheme.textSecondary),
                      ),
                      const SizedBox(height: 16),

                      // WhatsApp Integration Card
                      _buildWaIntegrationCard(),
                      const SizedBox(height: 16),

                      // Auto-Dispatch & Webhook Card
                      _buildAutoDispatchCard(),
                      const SizedBox(height: 24),

                      // Save Action Button
                      _buildSaveButton(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWaIntegrationCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppTheme.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(
              () => SwitchListTile(
                value: controller.isWaAlertEnabled.value,
                onChanged: (v) => controller.isWaAlertEnabled.value = v,
                activeColor: AppTheme.primaryColor,
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Sub-Second WhatsApp Alert',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppTheme.darkSlate,
                  ),
                ),
                subtitle: const Text(
                  'Kirim pesan snapshot insiden langsung ke WhatsApp Manager Jaga',
                  style: TextStyle(fontSize: 11, color: AppTheme.textSecondary),
                ),
              ),
            ),
            const Divider(height: 24),
            TextField(
              controller: controller.waNumberController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                labelText: 'Nomor WhatsApp Manajer Jaga',
                prefixIcon: const Icon(Icons.phone_android, color: AppTheme.primaryColor),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: controller.testWaAlert,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.primaryColor),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.send, size: 14, color: AppTheme.primaryColor),
                label: const Text(
                  'Uji Coba WA Alert',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoDispatchCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppTheme.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(
              () => SwitchListTile(
                value: controller.isAutoDispatchEnabled.value,
                onChanged: (v) => controller.isAutoDispatchEnabled.value = v,
                activeColor: AppTheme.primaryColor,
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Auto-Dispatch Penugasan Teknisi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppTheme.darkSlate,
                  ),
                ),
                subtitle: const Text(
                  'Terbitkan tiket penanganan otomatis ke teknisi terdekat saat insiden terdeteksi',
                  style: TextStyle(fontSize: 11, color: AppTheme.textSecondary),
                ),
              ),
            ),
            const Divider(height: 24),
            TextField(
              controller: controller.webhookUrlController,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                labelText: 'Enterprise Webhook URL',
                prefixIcon: const Icon(Icons.code, color: AppTheme.primaryColor),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: controller.saveAlertSettings,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.check_circle, color: Colors.white, size: 20),
        label: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Simpan Konfigurasi Integrasi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
    );
  }
}