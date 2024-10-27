import 'package:get/get.dart';

import '../controllers/transaction_screen_controller.dart';

class TransactionScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionScreenController>(
      () => TransactionScreenController(),
    );
  }
}
