import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/incident_detail_controller.dart';

class IncidentDetailView extends GetView<IncidentDetailController> {
  const IncidentDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IncidentDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'IncidentDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
