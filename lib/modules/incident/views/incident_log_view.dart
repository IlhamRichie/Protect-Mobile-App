import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../controllers/incident_log_controller.dart';
import 'package:intl/intl.dart';

class IncidentLogView extends StatelessWidget {
  const IncidentLogView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IncidentLogController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Tilang Feed'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            color: AppTheme.cardColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Obx(() => Row(
                  children: ['All', 'Unresolved', 'Resolved'].map((filter) {
                    final isSelected = controller.selectedFilter.value == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (_) => controller.setFilter(filter),
                        selectedColor: AppTheme.secondaryColor.withOpacity(0.2),
                        checkmarkColor: AppTheme.secondaryColor,
                      ),
                    );
                  }).toList(),
                )),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.filteredIncidents.isEmpty) {
          return const Center(child: Text('No incidents found.'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.filteredIncidents.length,
          itemBuilder: (context, index) {
            final incident = controller.filteredIncidents[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(incident.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  incident.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('${incident.zone} • ${DateFormat('HH:mm - dd MMM').format(incident.timestamp)}'),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: incident.status == 'Resolved' ? AppTheme.accentColor : AppTheme.dangerColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        incident.status,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Get.toNamed(Routes.INCIDENT_DETAIL, arguments: incident);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
