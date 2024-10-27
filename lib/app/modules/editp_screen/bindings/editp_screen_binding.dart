import 'package:get/get.dart';

import '../controllers/editp_screen_controller.dart';

class EditpScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditpScreenController>(
      () => EditpScreenController(),
    );
  }
}
