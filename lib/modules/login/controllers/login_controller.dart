import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final RxString selectedRole = 'QA Manager'.obs;
  
  final List<String> roles = [
    'QA Manager',
    'Warehouse Field QA',
    'Pest Control Operator'
  ];

  void selectRole(String role) {
    selectedRole.value = role;
  }

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', selectedRole.value);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    Get.offAllNamed(Routes.DASHBOARD);
  }
}
