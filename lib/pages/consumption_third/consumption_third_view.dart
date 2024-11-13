import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../Utils/Utils.dart';
import '../../main.dart';
import 'consumption_third_logic.dart';

class ConsumptionThirdPage extends GetView<ConsumptionThirdLogic> {
  Widget _otherItem(int index, BuildContext context) {
    final titles = ['Clean all records', 'About US'];
    return Container(
      color: Colors.transparent,
      height: 40,
      child: <Widget>[
        Text(titles[index]),
        index == 1 ? const Text('1.0.0').paddingOnly(right: 10) : const Icon(
          Icons.keyboard_arrow_right,
          size: 20,
          color: Colors.grey,
        )
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ).gestures(onTap: () {
      switch (index) {
        case 0:
          controller.cleanConsumptionData();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Other"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Container(
            alignment: Alignment.center,
            child: const Icon(
              Icons.add,
              size: 32,
              color: Colors.white,
            ),
          ).decorated(
              color: primaryColor, borderRadius: BorderRadius.circular(28)),
          onPressed: () {
            Utils.showFloatAddWidget(context);
          }),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: <Widget>[
                _otherItem(0, context),
                _otherItem(1, context),
              ].toColumn(
                  separator: Divider(
                height: 15,
                color: Colors.grey.withOpacity(0.3),
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12))
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
