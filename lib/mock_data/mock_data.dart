import '../app/data/models/incident_model.dart';

class MockData {
  static List<Incident> getIncidents() {
    return [
      Incident(
        id: 'INC-20231024-001',
        title: 'Rodent Detected at High-Care Storage',
        type: 'Rodent',
        zone: 'High-Care Storage',
        accuracy: 94.8,
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        status: 'Unresolved',
        imageUrl: 'https://via.placeholder.com/600x400/EF4444/FFFFFF?text=Rodent+Detected',
      ),
      Incident(
        id: 'INC-20231024-002',
        title: 'Insect Activity near Loading Dock',
        type: 'Insect',
        zone: 'Loading Dock B',
        accuracy: 88.5,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        status: 'Resolved',
        imageUrl: 'https://via.placeholder.com/600x400/10B981/FFFFFF?text=Insect+Detected',
      ),
      Incident(
        id: 'INC-20231024-003',
        title: 'Unidentified Movement in Corridor',
        type: 'Unknown',
        zone: 'Corridor A',
        accuracy: 72.1,
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        status: 'Resolved',
        imageUrl: 'https://via.placeholder.com/600x400/3B82F6/FFFFFF?text=Movement+Detected',
      ),
    ];
  }
}
