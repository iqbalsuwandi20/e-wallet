import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../routes/app_pages.dart';

class RegisterScreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;

  RxString emailError = ''.obs;
  RxString firstNameError = ''.obs;
  RxString lastNameError = ''.obs;
  RxString passwordError = ''.obs;
  RxString confirmPasswordError = ''.obs;
  RxString errorMessage = ''.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> register() async {
    emailError.value = '';
    firstNameError.value = '';
    lastNameError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';

    if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = "Parameter email tidak sesuai format";
    }
    if (firstNameController.text.isEmpty) {
      firstNameError.value = "Nama depan tidak boleh kosong";
    }
    if (lastNameController.text.isEmpty) {
      lastNameError.value = "Nama belakang tidak boleh kosong";
    }
    if (passwordController.text.length < 8) {
      passwordError.value = "Password minimal 8 karakter";
    }
    if (passwordController.text != confirmPasswordController.text) {
      confirmPasswordError.value = "Konfirmasi password tidak sesuai";
    }

    if (emailError.value.isNotEmpty ||
        firstNameError.value.isNotEmpty ||
        lastNameError.value.isNotEmpty ||
        passwordError.value.isNotEmpty ||
        confirmPasswordError.value.isNotEmpty) {
      return;
    }

    isLoading.value = true;

    final String apiUrl =
        "https://take-home-test-api.nutech-integrasi.com/registration";

    final Map<String, dynamic> requestBody = {
      "email": emailController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "password": passwordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestBody),
      );

      print("Kode status respons: ${response.statusCode}");
      print("Body respons: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        Get.toNamed(Routes.LOGIN_SCREEN);
        Get.snackbar(
          "Sukses",
          responseBody['message'],
          backgroundColor: Colors.orange[900],
          colorText: Colors.white,
        );
      } else {
        final responseBody = jsonDecode(response.body);
        errorMessage.value = responseBody['message'] ?? "Terjadi kesalahan";
      }
    } catch (e) {
      print("Error: $e");
      errorMessage.value = "Terjadi kesalahan: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
