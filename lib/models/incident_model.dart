class Incident {
  final String id;
  final String title;
  final String type; // e.g., 'Rodent', 'Insect'
  final String zone;
  final double accuracy;
  final DateTime timestamp;
  final String status; // 'Unresolved', 'Resolved'
  final String imageUrl; // Mock URL or local asset

  Incident({
    required this.id,
    required this.title,
    required this.type,
    required this.zone,
    required this.accuracy,
    required this.timestamp,
    required this.status,
    required this.imageUrl,
  });
}
