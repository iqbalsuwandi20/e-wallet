import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_screen/views/home_screen_view.dart';
import '../../profile_screen/views/profile_screen_view.dart';
import '../../topup_screen/views/topup_screen_view.dart';
import '../../transaction_screen/views/transaction_screen_view.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  Widget getCurrentView() {
    switch (selectedIndex.value) {
      case 0:
        return HomeScreenView();
      case 1:
        return TopupScreenView();
      case 2:
        return TransactionScreenView();
      case 3:
        return ProfileScreenView();
      default:
        return HomeScreenView();
    }
  }
}
