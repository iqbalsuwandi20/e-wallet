import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/topup_screen_controller.dart';

class TopupScreenView extends GetView<TopupScreenController> {
  const TopupScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
        padding: EdgeInsets.all(screenWidth * 0.05),
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
                "Silahkan masukan",
                style: TextStyle(fontSize: screenWidth * 0.05),
              ),
              Text(
                "nominal Top Up",
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
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
              SizedBox(height: screenHeight * 0.02),
              Obx(() {
                return Text(
                  controller.errorMessage.value,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                );
              }),
              SizedBox(height: screenHeight * 0.05),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                children: [
                  for (var nominal in [
                    "10000",
                    "20000",
                    "50000",
                    "100000",
                    "250000",
                    "500000"
                  ])
                    Container(
                      margin: EdgeInsets.all(screenWidth * 0.02),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.updateNominal(nominal);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02),
                        ),
                        child: Text(
                          "Rp$nominal",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.04),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
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
