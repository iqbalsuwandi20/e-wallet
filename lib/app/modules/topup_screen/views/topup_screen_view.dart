import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/topup_screen_controller.dart';

class TopupScreenView extends GetView<TopupScreenController> {
  const TopupScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Top Up',
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                "Silahkan masukan",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "nominal Top Up",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              Obx(() {
                return TextField(
                  controller: controller.nominalController,
                  autocorrect: false,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.orange[900],
                  decoration: InputDecoration(
                    labelText: "masukan nominal nilai Top Up",
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.attach_money_outlined,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: controller.errorMessage.value.isNotEmpty
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: controller.errorMessage.value.isNotEmpty
                            ? Colors.red
                            : Colors.orange[900]!,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                );
              }),
              SizedBox(height: 5),
              Obx(() {
                return Text(
                  controller.errorMessage.value,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                );
              }),
              SizedBox(height: 30),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updateNominal("10000");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Rp10.000",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updateNominal("20000");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Rp20.000",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updateNominal("50000");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Rp50.000",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updateNominal("100000");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Rp100.000",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updateNominal("250000");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Rp250.000",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updateNominal("500000");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Rp500.000",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Obx(
                () {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isFieldEmpty.value
                            ? Colors.grey
                            : Colors.orange[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: controller.isFieldEmpty.value
                          ? null
                          : () async {
                              if (controller.isLoading.isFalse) {
                                await controller.topup();
                              }
                            },
                      child: Text(
                        controller.isLoading.isFalse ? "Top Up" : "Tunggu ya..",
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
        ],
      ),
    );
  }
}
