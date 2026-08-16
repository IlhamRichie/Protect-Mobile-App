import 'package:get/get.dart';
import '../../../mock_data/mock_data.dart';
import '../../../models/incident_model.dart';

class IncidentLogController extends GetxController {
  final RxList<Incident> allIncidents = <Incident>[].obs;
  final RxList<Incident> filteredIncidents = <Incident>[].obs;
  
  final RxString selectedFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadIncidents();
  }

  void _loadIncidents() {
    allIncidents.value = MockData.getIncidents();
    _applyFilter();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    _applyFilter();
  }

  void _applyFilter() {
    if (selectedFilter.value == 'All') {
      filteredIncidents.value = allIncidents;
    } else {
      filteredIncidents.value = allIncidents
          .where((i) => i.status == selectedFilter.value)
          .toList();
    }
  }

  void markAsResolved(String id, String notes) {
    final index = allIncidents.indexWhere((i) => i.id == id);
    if (index != -1) {
      final old = allIncidents[index];
      allIncidents[index] = Incident(
        id: old.id,
        title: old.title,
        type: old.type,
        zone: old.zone,
        accuracy: old.accuracy,
        timestamp: old.timestamp,
        status: 'Resolved',
        imageUrl: old.imageUrl,
      );
      _applyFilter();
      Get.back(); // Go back from detail screen
      Get.snackbar('Success', 'Incident marked as resolved.');
    }
  }
}
