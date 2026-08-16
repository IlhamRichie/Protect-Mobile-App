import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/export_haccp_controller.dart';

class ExportHaccpView extends GetView<ExportHaccpController> {
  const ExportHaccpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExportHaccpView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ExportHaccpView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
