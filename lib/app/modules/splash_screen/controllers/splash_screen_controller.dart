import 'dart:async';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  void startSplash() {
    Future.delayed(
      Duration(seconds: 5),
      () {
        Get.offAllNamed(Routes.LOGIN_SCREEN);
      },
    );
  }
}
