import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../profile_screen/controllers/profile_screen_controller.dart';

class EditpScreenController extends GetxController {
  final ProfileScreenController profileController =
      Get.find<ProfileScreenController>();

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
    emailController.text = profileController.emailController.text;
    firstNameController.text = profileController.firstNameController.text;
    lastNameController.text = profileController.lastNameController.text;
  }

  Future<void> saveEdit() async {
    isLoading.value = true;

    final String apiUrl =
        "https://take-home-test-api.nutech-integrasi.com/profile/update";

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
        }),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 0) {
          print("Update Profile berhasil: ${responseBody['message']}");
          profileController.firstName.value = firstNameController.text;
          profileController.lastName.value = lastNameController.text;
          Get.back();

          Get.snackbar(
            'Sukses',
            "Anda berhasil update profile",
            backgroundColor: Colors.orange[900],
            colorText: Colors.white,
          );
        } else {
          print("Gagal mengupdate profil: ${responseBody['message']}");
        }
      } else {
        print("Error: ${response.body}");
      }
    } catch (e) {
      print("Error saat update profile: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
