import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/payment_screen_controller.dart';

class PaymentScreenView extends GetView<PaymentScreenController> {
  const PaymentScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PemBayaran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        children: [
          StreamBuilder<String>(
            stream: controller.getBalance(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.orange[900],
                  ),
                );
              }
              if (snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.red[700],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Saldo anda",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          Text(
                            "Rp. ${controller.balance.value.toStringAsFixed(0)}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.07,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text(""),
                );
              }
            },
          ),
          SizedBox(height: screenHeight * 0.05),
          Text(
            "PemBayaran",
            style: TextStyle(fontSize: screenWidth * 0.05),
          ),
          SizedBox(height: screenHeight * 0.03),
          Row(
            children: [
              Container(
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipOval(
                  child: Image.network(
                    controller.serviceIcon,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.red,
                        child: Icon(Icons.error, color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Text(
                controller.serviceName,
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.05,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.attach_money_outlined,
                  color: Colors.black,
                ),
                Obx(
                  () {
                    return Text(
                      controller.price.value.toStringAsFixed(0),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
          Obx(
            () {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.payment();
                    }
                  },
                  child: Text(
                    controller.isLoading.isFalse ? "Bayar" : "Tunggu ya..",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
