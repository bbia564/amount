import 'package:get/get.dart';

import 'consumption_second_logic.dart';

class ConsumptionSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConsumptionSecondLogic());
  }
}
