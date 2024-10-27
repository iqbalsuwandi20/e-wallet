import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/modules/home_screen/controllers/home_screen_controller.dart';
import 'app/modules/profile_screen/controllers/profile_screen_controller.dart';
import 'app/modules/topup_screen/controllers/topup_screen_controller.dart';
import 'app/modules/transaction_screen/controllers/transaction_screen_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initializeDateFormatting('id_ID', null);

  Get.put(HomeScreenController());
  Get.put(TopupScreenController());
  Get.put(TransactionScreenController());
  Get.put(ProfileScreenController());

  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH_SCREEN,
      getPages: AppPages.routes,
    ),
  );
}
