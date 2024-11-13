import 'package:get/get.dart';

import '../consumption_first/consumption_first_logic.dart';
import '../consumption_second/consumption_second_logic.dart';
import '../consumption_third/consumption_third_logic.dart';
import 'consumption_tab_logic.dart';

class ConsumptionTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConsumptionTabLogic());
    Get.lazyPut(() => ConsumptionFirstLogic());
    Get.lazyPut(() => ConsumptionSecondLogic());
    Get.lazyPut(() => ConsumptionThirdLogic());
  }
}
