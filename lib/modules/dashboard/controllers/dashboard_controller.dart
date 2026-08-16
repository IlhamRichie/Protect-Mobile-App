import 'package:get/get.dart';
import '../../../mock_data/mock_data.dart';
import '../../../models/incident_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  final RxString userRole = ''.obs;
  final RxList<Incident> activeIncidents = <Incident>[].obs;
  
  final RxString selectedFacility = 'PT Pangan Nusantara - Gudang A'.obs;
  final List<String> facilities = [
    'PT Pangan Nusantara - Gudang A',
    'PT Pangan Nusantara - Gudang B',
  ];

  @override
  void onInit() {
    super.onInit();
    _loadUserRole();
    _loadIncidents();
  }

  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    userRole.value = prefs.getString('user_role') ?? 'Unknown Role';
  }

  void _loadIncidents() {
    final allIncidents = MockData.getIncidents();
    activeIncidents.value = allIncidents.where((i) => i.status == 'Unresolved').toList();
  }

  void changeFacility(String facility) {
    selectedFacility.value = facility;
  }
}
