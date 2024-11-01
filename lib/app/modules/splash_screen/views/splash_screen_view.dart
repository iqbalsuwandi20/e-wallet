import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.startSplash();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Text(
            "SIMS PPOB",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.1,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Text(
            "Iqbal Suwandi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.05,
            ),
          ),
        ],
      ),
    );
  }
}
