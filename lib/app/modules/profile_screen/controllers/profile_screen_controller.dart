import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../routes/app_pages.dart';

class ProfileScreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  RxBool isLoading = false.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;

  final box = GetStorage();
  late String token;

  @override
  void onInit() {
    super.onInit();
    token = box.read('token') ?? '';
    getAllProfile();
  }

  Stream<Map<String, String>> getAllProfile() async* {
    final String apiUrl =
        "https://take-home-test-api.nutech-integrasi.com/profile";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['data'] != null) {
          final data = responseBody['data'];

          emailController.text = data['email'];
          firstNameController.text = data['first_name'];
          lastNameController.text = data['last_name'];
          firstName.value = data['first_name'];
          lastName.value = data['last_name'];

          yield {
            "email": data['email'],
            "first_name": data['first_name'],
            "last_name": data['last_name'],
          };
        } else {
          print("Data profil tidak ditemukan.");
          yield {};
        }
      } else {
        print("Gagal mengambil profil: ${response.body}");
        yield {};
      }
    } catch (e) {
      print("Error saat mengambil profil: $e");
      yield {};
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    box.erase();
    Get.offAllNamed(Routes.LOGIN_SCREEN);

    isLoading.value = false;
  }
}
