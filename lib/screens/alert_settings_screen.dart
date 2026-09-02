import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class AlertSettingsScreen extends StatefulWidget {
  const AlertSettingsScreen({super.key});

  @override
  State<AlertSettingsScreen> createState() => _AlertSettingsScreenState();
}

class _AlertSettingsScreenState extends State<AlertSettingsScreen> {
  final TextEditingController _webhookController = TextEditingController(
    text: 'https://api.protect-ai.cloud/v1/webhooks/haccp-alerts',
  );

  bool _telegram = true;
  bool _slack = true;
  bool _email = true;
  bool _sms = false;
  double _threshold = 0.85;
  bool _isSaved = false;

  @override
  void dispose() {
    _webhookController.dispose();
    super.dispose();
  }

  void _saveSettings() {
    setState(() => _isSaved = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Konfigurasi Webhook & Alert Notifikasi berhasil diperbarui!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Pengaturan Notifikasi & Webhook'),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          border: const Border(top: BorderSide(color: AppColors.borderColor)),
        ),
        child: SafeArea(
          child: ElevatedButton.icon(
            onPressed: _saveSettings,
            icon: const Icon(Icons.save, color: Colors.white),
            label: const Text('Simpan Konfigurasi Alert', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
            text: 'Ketika AI mendeteksi intrusi hama melebihi ambang batas sensitivitas, sinyal HTTP POST webhook instan akan dikirimkan ke endpoint sistem pabrik Anda.',
            icon: Icons.notifications_active,
          ),
          const SizedBox(height: 16),

          if (_isSaved) ...[
            const InfoBanner(
              text: 'Konfigurasi aktif: Saluran Telegram & Slack siap menerima telemetry E-Tilang.',
              icon: Icons.check_circle,
            ),
            const SizedBox(height: 16),
          ],

          // Webhook Endpoint Card
          const SectionHeader(title: '1. Enterprise Webhook URL Endpoint'),
          const SizedBox(height: 8),
          TextField(
            controller: _webhookController,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.surfaceLight,
              labelText: 'Webhook URL (HTTPS POST)',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderColor)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderColor)),
            ),
          ),
          const SizedBox(height: 16),

          // Notification Channels
          const SectionHeader(title: '2. Saluran Notifikasi Darurat'),
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
                  value: _telegram,
                  onChanged: (val) => setState(() => _telegram = val),
                  title: const Text('Telegram Bot Alert (@ProtectHaccpBot)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  activeColor: AppColors.emerald600,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: _slack,
                  onChanged: (val) => setState(() => _slack = val),
                  title: const Text('Slack Channel Integration (#haccp-alerts)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  activeColor: AppColors.emerald600,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: _email,
                  onChanged: (val) => setState(() => _email = val),
                  title: const Text('Email Broadcast ke Tim QA & Sanitasi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  activeColor: AppColors.emerald600,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: _sms,
                  onChanged: (val) => setState(() => _sms = val),
                  title: const Text('SMS Broadcast Gateway Darurat', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  activeColor: AppColors.emerald600,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Sensitivity Threshold Slider
          SectionHeader(title: '3. Ambang Batas Sensitivitas AI: ${(_threshold * 100).toInt()}%'),
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
                Slider(
                  value: _threshold,
                  min: 0.50,
                  max: 0.99,
                  divisions: 49,
                  activeColor: AppColors.emerald600,
                  onChanged: (val) => setState(() => _threshold = val),
                ),
                const Text(
                  'Nilai lebih tinggi mengurangi false positive pada pantulan bayangan atau perubahan cahaya lampu pabrik.',
                  style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
