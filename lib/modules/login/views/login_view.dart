import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_theme.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller locally if not using bindings yet
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or Icon
                const Icon(
                  Icons.security,
                  size: 80,
                  color: AppTheme.accentColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'PROTECT',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'ProViewAI Companion',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
                const SizedBox(height: 48),
                
                // Login Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Select Your Role',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      
                      Obx(() => Column(
                            children: controller.roles.map((role) {
                              final isSelected = controller.selectedRole.value == role;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: InkWell(
                                  onTap: () => controller.selectRole(role),
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isSelected
                                            ? AppTheme.secondaryColor
                                            : Colors.grey.shade300,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      color: isSelected
                                          ? AppTheme.secondaryColor.withOpacity(0.05)
                                          : Colors.transparent,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          _getRoleIcon(role),
                                          color: isSelected
                                              ? AppTheme.secondaryColor
                                              : AppTheme.textSecondary,
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            role,
                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                  fontWeight: isSelected
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  color: isSelected
                                                      ? AppTheme.secondaryColor
                                                      : AppTheme.textPrimary,
                                                ),
                                          ),
                                        ),
                                        if (isSelected)
                                          const Icon(
                                            Icons.check_circle,
                                            color: AppTheme.secondaryColor,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          )),
                          
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => controller.login(),
                        child: const Text('Access Command Center'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case 'QA Manager':
        return Icons.admin_panel_settings;
      case 'Warehouse Field QA':
        return Icons.verified_user;
      case 'Pest Control Operator':
        return Icons.visibility;
      default:
        return Icons.person;
    }
  }
}
