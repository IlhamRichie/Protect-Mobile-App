import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/live_feed_controller.dart';

class LiveFeedView extends GetView<LiveFeedController> {
  const LiveFeedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LiveFeedView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LiveFeedView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
