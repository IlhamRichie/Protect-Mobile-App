import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/analytics_report_controller.dart';

class AnalyticsReportView extends GetView<AnalyticsReportController> {
  const AnalyticsReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnalyticsReportView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AnalyticsReportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
