import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/incident_model.dart';
import '../../../theme/app_theme.dart';
import '../controllers/incident_log_controller.dart';
import 'package:intl/intl.dart';

class IncidentDetailView extends StatelessWidget {
  const IncidentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Incident incident = Get.arguments;
    final IncidentLogController controller = Get.find();
    final TextEditingController noteController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Incident Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Evidence Image
            Hero(
              tag: 'incident_image_${incident.id}',
              child: Image.network(
                incident.imageUrl,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        incident.id,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: incident.status == 'Resolved' ? AppTheme.accentColor : AppTheme.dangerColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          incident.status,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    incident.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  
                  // Metadata Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _buildMetaRow('Type / Species', incident.type, Icons.pest_control),
                        const Divider(),
                        _buildMetaRow('Detection Accuracy', '${incident.accuracy}%', Icons.analytics),
                        const Divider(),
                        _buildMetaRow('Zone / Location', incident.zone, Icons.location_on),
                        const Divider(),
                        _buildMetaRow('Timestamp', DateFormat('HH:mm:ss - dd MMM yyyy').format(incident.timestamp), Icons.access_time),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Action Buttons
                  if (incident.status == 'Unresolved') ...[
                    TextField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        labelText: 'Corrective Action Notes',
                        border: OutlineInputBorder(),
                        hintText: 'e.g., Deployed glue trap, sealed gap.',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentColor),
                            onPressed: () {
                              if (noteController.text.isEmpty) {
                                Get.snackbar('Error', 'Please enter action notes');
                                return;
                              }
                              controller.markAsResolved(incident.id, noteController.text);
                            },
                            child: const Text('Mark as Resolved'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.back(),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.textSecondary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('False Alarm'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.back(),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.secondaryColor,
                              side: const BorderSide(color: AppTheme.secondaryColor),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Dispatch Vendor'),
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppTheme.textSecondary),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: AppTheme.textSecondary)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
