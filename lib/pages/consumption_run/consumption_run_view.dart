import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'consumption_run_logic.dart';

class ConsumptionRunView extends GetView<PageLogic> {
  const ConsumptionRunView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.leuschke.value
              ? const CircularProgressIndicator(color: Colors.orange)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.ozsdpv();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
