import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class TransactionScreenController extends GetxController {
  RxDouble balance = 0.0.obs;
  RxBool isLoading = false.obs;

  final box = GetStorage();
  late String token;

  @override
  void onInit() {
    super.onInit();
    token = box.read('token') ?? '';
    getBalance();
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

  Stream<List<Map<String, dynamic>>> getTransactionHistory() async* {
    final String apiUrl =
        "https://take-home-test-api.nutech-integrasi.com/transaction/history";

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
        final transactions = responseBody['data']['records'] as List;
        yield transactions
            .map((transaction) => {
                  'total_amount': transaction['total_amount'],
                  'transaction_type': transaction['transaction_type'],
                  'description': transaction['description'],
                  'created_on': transaction['created_on'],
                })
            .toList();
      } else {
        yield [];
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
      yield [];
    } finally {
      isLoading.value = false;
    }
  }
}
