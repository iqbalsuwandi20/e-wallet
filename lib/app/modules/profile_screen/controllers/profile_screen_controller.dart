import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class ProfileScreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  RxBool isLoading = false.obs;

  final box = GetStorage();
  late String token;

  @override
  void onInit() {
    super.onInit();
    token = box.read('token') ?? '';
  }

  Future<void> logout() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    box.erase();
    Get.offAllNamed(Routes.LOGIN_SCREEN);

    isLoading.value = false;
  }
}
