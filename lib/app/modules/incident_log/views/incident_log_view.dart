import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/incident_log_controller.dart';

class IncidentLogView extends GetView<IncidentLogController> {
  const IncidentLogView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IncidentLogView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'IncidentLogView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
