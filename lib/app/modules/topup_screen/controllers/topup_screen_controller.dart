import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../home_screen/controllers/home_screen_controller.dart';

class TopupScreenController extends GetxController {
  TextEditingController nominalController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isFieldEmpty = true.obs;
  RxDouble balance = 0.0.obs;

  RxString errorMessage = ''.obs;

  final int minTopup = 10000;
  final int maxTopup = 1000000;

  final box = GetStorage();
  late String token;

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

      print("Kode status respons: ${response.statusCode}");
      print("Body respons: ${response.body}");

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

  Future<void> topup() async {
    if (isFieldEmpty.value || isLoading.value) return;

    isLoading.value = true;
    errorMessage.value = '';

    final token = GetStorage().read('token');
    String inputText =
        nominalController.text.replaceAll('.', '').replaceAll('Rp ', '');
    int topUpAmount = int.parse(inputText);

    if (topUpAmount < minTopup || topUpAmount > maxTopup) {
      errorMessage.value = 'Nilai harus antara Rp$minTopup dan Rp$maxTopup';
      isLoading.value = false;
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('https://take-home-test-api.nutech-integrasi.com/topup'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"top_up_amount": topUpAmount}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Get.find<HomeScreenController>().getBalance();

        print(data);

        Get.snackbar(
          'Sukses',
          'Anda berhasil Top Up!',
          backgroundColor: Colors.orange[900],
          colorText: Colors.white,
        );
      } else {
        var errorData = jsonDecode(response.body);
        errorMessage.value = errorData['message'];
      }
    } catch (e) {
      errorMessage.value = "Tidak dapat terhubung ke server";
    } finally {
      isLoading.value = false;
    }
  }

  void updateNominal(String nominal) {
    nominalController.text = formatRupiah(int.parse(nominal));
    nominalController.selection = TextSelection.fromPosition(
      TextPosition(offset: nominalController.text.length),
    );
  }

  String formatRupiah(int amount) {
    var formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount).replaceAll(',', '.');
  }

  @override
  void onInit() {
    super.onInit();
    token = box.read('token') ?? '';
    getBalance();
    nominalController.addListener(() {
      String inputText =
          nominalController.text.replaceAll('.', '').replaceAll('Rp ', '');
      isFieldEmpty.value = inputText.isEmpty;
      if (inputText.isNotEmpty) {
        int? value = int.tryParse(inputText);
        if (value != null && (value < minTopup || value > maxTopup)) {
          errorMessage.value = 'Nilai harus antara Rp$minTopup dan Rp$maxTopup';
        } else {
          errorMessage.value = '';
        }
      } else {
        errorMessage.value = '';
      }
    });
  }

  @override
  void onClose() {
    nominalController.dispose();
    super.onClose();
  }
}
