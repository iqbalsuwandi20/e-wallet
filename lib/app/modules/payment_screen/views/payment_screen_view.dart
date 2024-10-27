import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/payment_screen_controller.dart';

class PaymentScreenView extends GetView<PaymentScreenController> {
  const PaymentScreenView({super.key});

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.all(20),
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
                  padding: EdgeInsets.all(20),
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
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Rp. ${controller.balance.value.toStringAsFixed(0)}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
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
          SizedBox(height: 50),
          Text(
            "PemBayaran",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(10),
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
              SizedBox(width: 10),
              Text(
                controller.serviceName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
          SizedBox(
            height: 50,
          ),
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
