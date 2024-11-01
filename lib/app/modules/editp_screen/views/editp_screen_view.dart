import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/editp_screen_controller.dart';

class EditpScreenView extends GetView<EditpScreenController> {
  const EditpScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Akun',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_outlined,
              ),
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: ListView(
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
        children: [
          Column(
            children: [
              ClipOval(
                child: Container(
                  width: screenWidth * 0.25,
                  height: screenWidth * 0.25,
                  color: Colors.white,
                  child: Image.asset(
                    "assets/images/profile.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: screenWidth * 0.05,
              ),
              Obx(() {
                String fullName =
                    "${controller.profileController.firstName.value} ${controller.profileController.lastName.value}";
                return Text(
                  fullName.isNotEmpty ? fullName : "Nama Tidak Ditemukan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,
                  ),
                );
              }),
            ],
          ),
          SizedBox(
            height: screenWidth * 0.1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller.emailController,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                readOnly: true,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.orange[900],
                decoration: InputDecoration(
                  labelText: "email anda",
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
              SizedBox(
                height: screenWidth * 0.05,
              ),
              Text(
                "Nama Depan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller.firstNameController,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.orange[900],
                decoration: InputDecoration(
                  labelText: "nama depan",
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.person_outline_outlined,
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
              SizedBox(
                height: screenWidth * 0.05,
              ),
              Text(
                "Nama Belakang",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller.lastNameController,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.orange[900],
                decoration: InputDecoration(
                  labelText: "nama belakang",
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.person_outline_outlined,
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
              SizedBox(
                height: screenWidth * 0.1,
              ),
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
                          await controller.saveEdit();
                        }
                      },
                      child: Text(
                        controller.isLoading.isFalse ? "Simpan" : "Tunggu ya..",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: screenWidth * 0.05,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.orange[900],
                    side: BorderSide(color: Colors.orange[900]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Kembali",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
