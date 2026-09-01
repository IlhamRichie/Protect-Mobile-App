import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;
            final double horizontalPadding = isTablet ? 32.0 : 24.0;

            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 20.0,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Top Centered Official Logo Banner
                      _buildLogoBanner(),
                      const SizedBox(height: 20),

                      // Header Title & Subtitle
                      _buildHeader(),
                      const SizedBox(height: 24),

                      // Main Form Card Container
                      _buildFormCard(),
                      const SizedBox(height: 20),

                      // Register Link
                      _buildRegisterLink(),
                      const SizedBox(height: 12),

                      // Field Tech Mode Navigation Button
                      _buildTechModeButton(),
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

  Widget _buildLogoBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Image.asset(
        'assets/logo_protect.png',
        height: 54,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.shield,
          size: 50,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: const [
        Text(
          'Masuk ke Akun Anda',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkSlate,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Text(
          'Kelola proteksi lingkungan & B2B AI CCTV anda',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
      ],
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email / Phone Field
          TextField(
            controller: controller.corporateEmailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              labelText: 'Email atau Nomor HP',
              hintText: 'user@example.com / 081234567890',
              hintStyle: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
              prefixIcon: const Icon(Icons.person_outline, color: AppTheme.primaryColor),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 14),

          // Password Field with Eye Toggle
          Obx(
            () => TextField(
              controller: controller.passwordController,
              obscureText: controller.isPasswordObscured.value,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                labelText: 'Kata Sandi',
                prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.primaryColor),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordObscured.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppTheme.textSecondary,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),

          // Lupa Kata Sandi Link
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Get.snackbar(
                  'Reset Password',
                  'Link reset kata sandi telah dikirim ke email Anda.',
                  snackPosition: SnackPosition.TOP,
                );
              },
              child: const Text(
                'Lupa Kata Sandi?',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Main Login Button
          ElevatedButton(
            onPressed: controller.loginB2cWhatsApp,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Masuk',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Divider "atau"
          Row(
            children: const [
              Expanded(child: Divider(color: AppTheme.borderColor)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'atau',
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                ),
              ),
              Expanded(child: Divider(color: AppTheme.borderColor)),
            ],
          ),
          const SizedBox(height: 16),

          // Outlined Google Auth Button
          OutlinedButton.icon(
            onPressed: controller.loginB2cGoogle,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: const BorderSide(color: AppTheme.borderColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.g_mobiledata, size: 28, color: Colors.red),
            label: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Lanjutkan dengan Google',
                style: TextStyle(
                  color: AppTheme.darkSlate,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Belum punya akun? ',
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
        ),
        GestureDetector(
          onTap: () {
            Get.snackbar(
              'Daftar Baru',
              'Membuka formulir pendaftaran akun baru.',
              snackPosition: SnackPosition.TOP,
            );
          },
          child: const Text(
            'Daftar Baru',
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTechModeButton() {
    return TextButton.icon(
      onPressed: controller.openFieldTechMode,
      icon: const Icon(
        Icons.engineering_outlined,
        size: 16,
        color: AppTheme.textSecondary,
      ),
      label: const Text(
        'Mode Teknisi Lapangan',
        style: TextStyle(
          color: AppTheme.textSecondary,
          fontSize: 12,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}