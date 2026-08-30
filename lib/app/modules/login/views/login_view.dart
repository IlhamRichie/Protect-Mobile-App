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
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Centered Official Rectangular Logo Banner
                Container(
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
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.shield, size: 50, color: AppTheme.primaryColor),
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Masuk ke Akun Anda',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkSlate,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Kelola proteksi lingkungan & B2B AI CCTV anda',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 24),

                // Main Form Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.borderColor),
                    boxShadow: const [
                      BoxShadow(color: Color(0x0A000000), blurRadius: 16, offset: Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email / Phone Field
                      TextField(
                        controller: controller.corporateEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email atau Nomor HP',
                          hintText: 'user@example.com / 081234567890',
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
                          decoration: InputDecoration(
                            labelText: 'Kata Sandi',
                            prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.primaryColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordObscured.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
                            Get.snackbar('Reset Password', 'Link reset kata sandi telah dikirim ke email Anda.');
                          },
                          child: const Text(
                            'Lupa Kata Sandi?',
                            style: TextStyle(color: AppTheme.primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Main Green Login Button
                      ElevatedButton(
                        onPressed: controller.loginB2cWhatsApp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Masuk', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      const SizedBox(height: 16),

                      // Divider "atau"
                      Row(
                        children: const [
                          Expanded(child: Divider(color: AppTheme.borderColor)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('atau', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: const Icon(Icons.g_mobiledata, size: 28, color: Colors.red),
                        label: const Text(
                          'Lanjutkan dengan Google',
                          style: TextStyle(color: AppTheme.darkSlate, fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Register Link & Field Tech Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun? ', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                    GestureDetector(
                      onTap: () {
                        Get.snackbar('Daftar Baru', 'Membuka formulir pendaftaran akun baru.');
                      },
                      child: const Text(
                        'Daftar Baru',
                        style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                TextButton.icon(
                  onPressed: controller.openFieldTechMode,
                  icon: const Icon(Icons.engineering_outlined, size: 16, color: AppTheme.textSecondary),
                  label: const Text(
                    'Mode Teknisi Lapangan',
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 12, decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
