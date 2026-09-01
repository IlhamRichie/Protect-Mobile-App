import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme.dart';
import '../../../routes/app_pages.dart';

class IncidentModel {
  final String id;
  final String cameraLabel;
  final String location;
  final String timestamp;
  final String zone;
  final String confidence;
  final String status; // 'Need Action' | 'Resolved'

  IncidentModel({
    required this.id,
    required this.cameraLabel,
    required this.location,
    required this.timestamp,
    required this.zone,
    required this.confidence,
    required this.status,
  });
}

class IncidentLogController extends GetxController {
  final searchQuery = ''.obs;
  final selectedFilter = 'Semua'.obs;

  final RxList<IncidentModel> allIncidents = <IncidentModel>[
    IncidentModel(
      id: 'INC-2026-089',
      cameraLabel: 'CCTV-04',
      location: 'CAM-04 Storage Tepung',
      timestamp: '01 Ags 2026 • 02:14:05 WIB',
      zone: 'Zone A2 Steril Boundary (Y=550)',
      confidence: '96%',
      status: 'Need Action',
    ),
    IncidentModel(
      id: 'INC-2026-088',
      cameraLabel: 'CCTV-02',
      location: 'CAM-02 Loading Dock B',
      timestamp: '31 Jul 2026 • 18:30:12 WIB',
      zone: 'Zone B1 Perimeter Gate',
      confidence: '94%',
      status: 'Resolved',
    ),
    IncidentModel(
      id: 'INC-2026-087',
      cameraLabel: 'CCTV-01',
      location: 'CAM-01 Processing Line A',
      timestamp: '30 Jul 2026 • 11:15:40 WIB',
      zone: 'Zone A1 Packaging Area',
      confidence: '98%',
      status: 'Resolved',
    ),
  ].obs;

  /// Computed reactive list for filtered incident data
  List<IncidentModel> get filteredIncidents {
    return allIncidents.where((incident) {
      final matchesFilter = selectedFilter.value == 'Semua' ||
          incident.status.toLowerCase() == selectedFilter.value.toLowerCase();

      final query = searchQuery.value.toLowerCase().trim();
      final matchesSearch = query.isEmpty ||
          incident.id.toLowerCase().contains(query) ||
          incident.location.toLowerCase().contains(query) ||
          incident.zone.toLowerCase().contains(query) ||
          incident.cameraLabel.toLowerCase().contains(query);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  int get filteredIncidentCount => filteredIncidents.length;

  void openIncidentDetail(String incidentId) {
    Get.toNamed(
      Routes.INCIDENT_DETAIL,
      arguments: {'incidentId': incidentId},
    );
  }

  void openFilterModal() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Insiden',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkSlate,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            const Divider(),
            ListTile(
              title: const Text('Semua Status'),
              trailing: selectedFilter.value == 'Semua'
                  ? const Icon(Icons.check, color: AppTheme.primaryColor)
                  : null,
              onTap: () {
                selectedFilter.value = 'Semua';
                Get.back();
              },
            ),
            ListTile(
              title: const Text('Need Action'),
              trailing: selectedFilter.value == 'Need Action'
                  ? const Icon(Icons.check, color: AppTheme.primaryColor)
                  : null,
              onTap: () {
                selectedFilter.value = 'Need Action';
                Get.back();
              },
            ),
            ListTile(
              title: const Text('Resolved'),
              trailing: selectedFilter.value == 'Resolved'
                  ? const Icon(Icons.check, color: AppTheme.primaryColor)
                  : null,
              onTap: () {
                selectedFilter.value = 'Resolved';
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}