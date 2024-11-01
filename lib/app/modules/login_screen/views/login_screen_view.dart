import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_screen_controller.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: screenWidth * 0.15,
                    height: screenWidth * 0.15,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "SIMS PPOBP",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              Column(
                children: [
                  Text(
                    "Masuk atau buat akun",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.06,
                    ),
                  ),
                  Text(
                    "untuk memulai",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.06,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  TextField(
                    controller: controller.emailController,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.orange[900],
                    decoration: InputDecoration(
                      labelText: "masukan email anda",
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.alternate_email_outlined,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange[900]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.errorMessage.value == "masukan email anda"
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              controller.errorMessage.value,
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Obx(
                    () {
                      return TextField(
                        controller: controller.passwordController,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        obscureText: controller.isPasswordHidden.value,
                        cursorColor: Colors.orange[900],
                        decoration: InputDecoration(
                          labelText: "masukan password anda",
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.togglePasswordVisibility();
                            },
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.orange[900]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
                  Obx(
                    () =>
                        controller.errorMessage.value == "masukan password anda"
                            ? Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  controller.errorMessage.value,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : SizedBox.shrink(),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Obx(
                    () {
                      if (controller.errorMessage.value.isNotEmpty &&
                          controller.errorMessage.value !=
                              "masukan email anda" &&
                          controller.errorMessage.value !=
                              "masukan password anda") {
                        return Text(
                          controller.errorMessage.value,
                          style: TextStyle(color: Colors.red),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  SizedBox(height: screenHeight * 0.1),
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
                              await controller.login();
                            }
                          },
                          child: Text(
                            controller.isLoading.isFalse
                                ? "Masuk"
                                : "Tunggu ya..",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("belum punya akun? registrasi"),
                      TextButton(
                        onPressed: () => Get.toNamed(Routes.REGISTER_SCREEN),
                        child: Text(
                          "di sini",
                          style: TextStyle(color: Colors.orange[900]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
