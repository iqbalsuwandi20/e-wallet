import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBalanceVisible = false.obs;

  RxDouble balance = 0.0.obs;

  RxList<Map<String, dynamic>> services = <Map<String, dynamic>>[].obs;
  RxList<Map<String, String>> banners = <Map<String, String>>[].obs;

  final box = GetStorage();
  late String token;

  @override
  void onInit() {
    super.onInit();
    token = box.read('token') ?? '';
    getBalance();
    getServices();
    getImageBanners();
  }

  Stream<List<Map<String, String>>> getImageBanners() async* {
    final apiUrl = "https://take-home-test-api.nutech-integrasi.com/banner";

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

        if (responseBody['data'] != null) {
          final bannerList = (responseBody['data'] as List).map((banner) {
            return {
              "banner_name":
                  banner['banner_name']?.toString() ?? "Tidak ada nama",
              "banner_image": banner['banner_image']?.toString() ?? "",
              "description":
                  banner['description']?.toString() ?? "Tidak ada deskripsi",
            };
          }).toList();

          banners.assignAll(bannerList);
          yield banners;
        } else {
          print("Data banner tidak ditemukan dalam respons.");
          yield [];
        }
      } else {
        print("Gagal mengambil banner, status: ${response.statusCode}");
        yield [];
      }
    } catch (e) {
      print("Error saat mengambil banner: $e");
      yield [];
    }
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

  Stream<List<Map<String, dynamic>>> getServices() async* {
    final String apiUrl =
        "https://take-home-test-api.nutech-integrasi.com/services";

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

        List<Map<String, dynamic>> serviceList =
            (responseBody['data'] as List).map((service) {
          return {
            'serviceCode': service['service_code'],
            'serviceName': service['service_name'],
            'serviceIcon': service['service_icon'],
          };
        }).toList();

        services.value = serviceList;
        yield serviceList;
      } else {
        yield [];
      }
    } catch (e) {
      yield [];
    } finally {
      isLoading.value = false;
    }
  }

  Stream<String> getName() async* {
    final String apiUrl =
        "https://take-home-test-api.nutech-integrasi.com/profile";

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
        final String fullName =
            "${responseBody['data']['first_name']} ${responseBody['data']['last_name']}";
        yield fullName;
      } else {
        yield "Gagal mengambil data";
      }
    } catch (e) {
      yield "Terjadi kesalahan: $e";
    } finally {
      isLoading.value = false;
    }
  }

  void toggleBalanceVisibility() {
    isBalanceVisible.value = !isBalanceVisible.value;
  }
}
