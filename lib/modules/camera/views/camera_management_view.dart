import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class CameraManagementView extends StatelessWidget {
  const CameraManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Management'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CAM ${index + 1}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Switch(
                        value: true,
                        onChanged: (val) {},
                        activeColor: AppTheme.accentColor,
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: 'rtsp://admin:admin123@192.168.1.${10 + index}:554/cam/realmonitor?channel=1&subtype=0',
                    decoration: const InputDecoration(
                      labelText: 'RTSP Stream URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: '550',
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Virtual Boundary Line (Y Coordinate)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Configuration Saved')),
                        );
                      },
                      child: const Text('Save Config'),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
