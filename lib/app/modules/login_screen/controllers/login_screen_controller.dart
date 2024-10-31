import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../routes/app_pages.dart';
import '../../home_screen/controllers/home_screen_controller.dart';
import '../../profile_screen/controllers/profile_screen_controller.dart';
import '../../topup_screen/controllers/topup_screen_controller.dart';
import '../../transaction_screen/controllers/transaction_screen_controller.dart';

class LoginScreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;
  RxString errorMessage = ''.obs;

  final box = GetStorage();

  Future<void> login() async {
    errorMessage.value = '';

    if (emailController.text.isEmpty) {
      errorMessage.value = "masukan email anda";
      return;
    }
    if (passwordController.text.isEmpty) {
      errorMessage.value = "masukan password anda";
      return;
    }

    isLoading.value = true;

    try {
      var body = jsonEncode({
        "email": emailController.text,
        "password": passwordController.text,
      });

      var response = await http.post(
        Uri.parse('https://take-home-test-api.nutech-integrasi.com/login'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print("Kode status respons: ${response.statusCode}");
      print("Body respons: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var token = data['data']['token'];

        print("Token: $token");

        box.write('token', token);

        final homeController = Get.find<HomeScreenController>();
        homeController.token = token;

        final topupController = Get.find<TopupScreenController>();
        topupController.token = token;

        final transactionController = Get.find<TransactionScreenController>();
        transactionController.token = token;

        final profileController = Get.find<ProfileScreenController>();
        profileController.token = token;

        Get.offAllNamed(Routes.HOME);
        Get.snackbar(
          'Sukses',
          'Login berhasil!',
          backgroundColor: Colors.orange[900],
          colorText: Colors.white,
        );
      } else if (response.statusCode == 400) {
        errorMessage.value = "Password tidak valid";
      } else if (response.statusCode == 401) {
        errorMessage.value = "password yang anda masukan salah";
      } else {
        errorMessage.value = "Mohon cek kembali";
      }
    } catch (e) {
      print("Error: $e");
      errorMessage.value = "Tidak dapat terhubung ke server";
    } finally {
      isLoading.value = false;
    }
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
}
