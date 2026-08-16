import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/camera_management_controller.dart';

class CameraManagementView extends GetView<CameraManagementController> {
  const CameraManagementView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CameraManagementView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CameraManagementView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
