import 'package:get/get.dart';

import 'consumption_run_logic.dart';

class ConsumptionRunBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
