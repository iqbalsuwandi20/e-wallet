import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/topup_screen_controller.dart';

class TopupScreenView extends GetView<TopupScreenController> {
  const TopupScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TopupScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TopupScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
