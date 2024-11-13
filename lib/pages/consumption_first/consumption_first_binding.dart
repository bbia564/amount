import 'package:get/get.dart';

import 'consumption_first_logic.dart';

class ConsumptionFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConsumptionFirstLogic());
  }
}
