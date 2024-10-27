import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/editp_screen_controller.dart';

class EditpScreenView extends GetView<EditpScreenController> {
  const EditpScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditpScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditpScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
