import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PaymentScreenController extends GetxController {
  RxBool isLoading = false.obs;

  RxDouble balance = 0.0.obs;
  RxDouble price = 0.0.obs;

  final box = GetStorage();

  late String token;
  late String serviceIcon;
  late String serviceName;
  late String serviceCode;

  late double serviceTariff;

  @override
  void onInit() {
    super.onInit();
    token = box.read('token') ?? '';

    final arguments = Get.arguments as Map<String, dynamic>;
    serviceIcon = arguments['serviceIcon'] ?? '';
    serviceName = arguments['serviceName'] ?? '';
    serviceCode = arguments['serviceCode'] ?? '';
    serviceTariff = (arguments['serviceTariff'] ?? 0).toDouble();

    price.value = serviceTariff;
    getBalance();
    // getServicePrice();
  }

  Future<void> payment() async {
    final String apiUrl =
        "https://take-home-test-api.nutech-integrasi.com/transaction";

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "service_code": serviceCode,
          "amount": price.value,
        }),
      );

      print("Kode status respons: ${response.statusCode}");
      print("Body respons: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print("Transaksi berhasil: ${responseBody['data']['invoice_number']}");

        Get.back();

        Get.snackbar(
          "Berhasil",
          "Anda berhasil melakukan pembayaran ${responseBody["data"]["service_name"]}",
          backgroundColor: Colors.orange[900],
          colorText: Colors.white,
        );
      } else {
        final responseBody = jsonDecode(response.body);
        print("Gagal melakukan transaksi: ${responseBody['message']}");

        Get.snackbar(
          "Gagal",
          "Saldo anda tidak cukup",
          backgroundColor: Colors.orange[900],
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error saat melakukan transaksi: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getServicePrice() async {
    price.value = serviceTariff;
  }

  Stream<String> getBalance() async* {
    final String apiUrl =
        "https://take-home-test-api.nutech-integrasi.com/balance";

    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        balance.value = responseBody['data']['balance'].toDouble();
        yield "Saldo: Rp${balance.value}";
      } else {
        yield "Gagal mengambil saldo: ${response.body}";
      }
    } catch (e) {
      yield "Terjadi kesalahan: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
