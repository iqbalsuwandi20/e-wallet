import 'package:get/get.dart';

import '../controllers/topup_screen_controller.dart';

class TopupScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopupScreenController>(
      () => TopupScreenController(),
    );
  }
}
