import 'package:get/get.dart';

import 'consumption_third_logic.dart';

class ConsumptionThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConsumptionThirdLogic());
  }
}
