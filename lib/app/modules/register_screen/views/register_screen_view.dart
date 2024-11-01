import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/register_screen_controller.dart';

class RegisterScreenView extends GetView<RegisterScreenController> {
  const RegisterScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
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
                      "Lengkapi data untuk",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.06,
                      ),
                    ),
                    Text(
                      "membuat akun",
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
                    Obx(() {
                      return Text(
                        controller.emailError.value,
                        style: TextStyle(color: Colors.red),
                      );
                    }),
                    SizedBox(height: screenHeight * 0.02),
                    TextField(
                      controller: controller.firstNameController,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      cursorColor: Colors.orange[900],
                      decoration: InputDecoration(
                        labelText: "nama depan",
                        labelStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
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
                    Obx(() {
                      return Text(
                        controller.firstNameError.value,
                        style: TextStyle(color: Colors.red),
                      );
                    }),
                    SizedBox(height: screenHeight * 0.02),
                    TextField(
                      controller: controller.lastNameController,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      cursorColor: Colors.orange[900],
                      decoration: InputDecoration(
                        labelText: "nama belakang",
                        labelStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
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
                    Obx(() {
                      return Text(
                        controller.lastNameError.value,
                        style: TextStyle(color: Colors.red),
                      );
                    }),
                    SizedBox(height: screenHeight * 0.02),
                    Obx(() {
                      return TextField(
                        controller: controller.passwordController,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        obscureText: controller.isPasswordHidden.value,
                        cursorColor: Colors.orange[900],
                        decoration: InputDecoration(
                          labelText: "buat password",
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
                    }),
                    Obx(() {
                      return Text(
                        controller.passwordError.value,
                        style: TextStyle(color: Colors.red),
                      );
                    }),
                    SizedBox(height: screenHeight * 0.02),
                    Obx(() {
                      return TextField(
                        controller: controller.confirmPasswordController,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        obscureText: controller.isPasswordHidden.value,
                        cursorColor: Colors.orange[900],
                        decoration: InputDecoration(
                          labelText: "konfirmasi password",
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
                    }),
                    Obx(() {
                      return Text(
                        controller.confirmPasswordError.value,
                        style: TextStyle(color: Colors.red),
                      );
                    }),
                    SizedBox(height: screenHeight * 0.05),
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
                                await controller.register();
                              }
                            },
                            child: Text(
                              controller.isLoading.isFalse
                                  ? "Registrasi"
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
                        Text("belum punya akun? login"),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.LOGIN_SCREEN),
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
        ],
      ),
    );
  }
}
