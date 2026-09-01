import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoiEditorController extends GetxController {
  final RxList<Offset> roiNormalizedPoints = <Offset>[
    const Offset(0.15, 0.25),
    const Offset(0.85, 0.25),
    const Offset(0.85, 0.75),
    const Offset(0.15, 0.75),
  ].obs;

  final RxnInt selectedPointIndex = RxnInt();
  final RxBool isAiActive = true.obs;

  void onDragStart(Offset localPos, double w, double h) {
    for (int i = 0; i < roiNormalizedPoints.length; i++) {
      final pointPx = Offset(roiNormalizedPoints[i].dx * w, roiNormalizedPoints[i].dy * h);
      if ((pointPx - localPos).distance < 28) {
        selectedPointIndex.value = i;
        break;
      }
    }
  }

  void onDragUpdate(Offset localPos, double w, double h) {
    if (selectedPointIndex.value != null) {
      final clampedX = (localPos.dx / w).clamp(0.05, 0.95);
      final clampedY = (localPos.dy / h).clamp(0.05, 0.95);
      roiNormalizedPoints[selectedPointIndex.value!] = Offset(clampedX, clampedY);
    }
  }

  void onDragEnd() {
    selectedPointIndex.value = null;
  }

  void resetRoi() {
    roiNormalizedPoints.assignAll(const [
      Offset(0.15, 0.25),
      Offset(0.85, 0.25),
      Offset(0.85, 0.75),
      Offset(0.15, 0.75),
    ]);
  }

  void saveRoiConfig() {
    Get.snackbar(
      'ROI Synchronized',
      'Koordinat Polygon ROI berhasil diperbarui di Engine ProViewAI!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
  }
}