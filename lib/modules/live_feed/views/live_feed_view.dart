import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_theme.dart';
import '../controllers/live_feed_controller.dart';

class LiveFeedView extends StatelessWidget {
  const LiveFeedView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LiveFeedController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Monitoring'),
        actions: [
          Obx(() => SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 1, icon: Icon(Icons.crop_square), label: Text('1')),
                  ButtonSegment(value: 4, icon: Icon(Icons.grid_view), label: Text('4')),
                  ButtonSegment(value: 8, icon: Icon(Icons.grid_on), label: Text('8')),
                ],
                selected: {controller.gridCount.value},
                onSelectionChanged: (Set<int> newSelection) {
                  controller.changeGrid(newSelection.first);
                },
                style: SegmentedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  selectedBackgroundColor: AppTheme.secondaryColor,
                ),
              )),
          const SizedBox(width: 16),
        ],
      ),
      body: Obx(() {
        int crossAxisCount = controller.gridCount.value == 1 ? 1 : (controller.gridCount.value == 4 ? 2 : 4);
        
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 16 / 9,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: controller.gridCount.value,
          itemBuilder: (context, index) {
            return _buildCameraFeed(context, index + 1);
          },
        );
      }),
    );
  }

  Widget _buildCameraFeed(BuildContext context, int camNumber) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryColor),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Placeholder for MediaKit Video Player
          Center(
            child: Icon(
              Icons.videocam_off,
              color: Colors.white.withOpacity(0.3),
              size: 48,
            ),
          ),
          // Y=550 Virtual Line Simulation
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              height: 2,
              color: AppTheme.dangerColor.withOpacity(0.7),
            ),
          ),
          // Camera Label
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppTheme.accentColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'CAM $camNumber - ${['Loading Dock', 'Storage', 'Corridor', 'Entrance'][camNumber % 4]}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
