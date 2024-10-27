import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transaction_screen_controller.dart';

class TransactionScreenView extends GetView<TransactionScreenController> {
  const TransactionScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TransactionScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TransactionScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
