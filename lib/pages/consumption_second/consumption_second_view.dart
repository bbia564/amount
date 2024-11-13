import 'package:consumption_record/Utils/consumption_text_field.dart';
import 'package:consumption_record/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../Utils/Utils.dart';
import 'consumption_second_logic.dart';

class ConsumptionSecondPage extends GetView<ConsumptionSecondLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
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
              GetBuilder<ConsumptionSecondLogic>(
                      id: 'timeSelect',
                      init: ConsumptionSecondLogic(),
                      builder: (_) {
                        return Container(
                          height: 60,
                          padding: const EdgeInsets.all(12),
                          child: <Widget>[
                            const Text(
                              'Date:',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            <Widget>[
                              Container(
                                width: 96,
                                height: 30,
                                child: IgnorePointer(
                                  child: ConsumptionTextField(
                                      hintText: 'Start time',
                                      value: controller.startTimeString,
                                      textAlign: TextAlign.center,
                                      hintTextStyle: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      textStyle: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      onChange: (value) {}),
                                ),
                              )
                                  .decorated(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8))
                                  .gestures(onTap: () {
                                controller.selectTime(context);
                              }),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 6,
                                height: 2,
                              ).decorated(color: primaryColor),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 96,
                                height: 30,
                                child: IgnorePointer(
                                  child: ConsumptionTextField(
                                      hintText: 'End time',
                                      value: controller.endTimeString,
                                      textAlign: TextAlign.center,
                                      hintTextStyle: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      textStyle: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      onChange: (value) {}),
                                ),
                              )
                                  .decorated(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8))
                                  .gestures(onTap: () {
                                controller.selectTime(context,
                                    isStartTime: false);
                              }),
                            ].toRow(mainAxisAlignment: MainAxisAlignment.end)
                          ].toRow(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween),
                        );
                      })
                  .decorated(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 220,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  const Text(
                    'Consumption amount statistics',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    height: 15,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                      child: GetBuilder<ConsumptionSecondLogic>(
                          id: 'chart',
                          init: ConsumptionSecondLogic(),
                          builder: (_) {
                            return controller.dateList.isEmpty
                                ? const Center(
                                    child: Text('No data'),
                                  )
                                : GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            mainAxisSpacing: 10,
                                            childAspectRatio: 3.5),
                                    itemCount: controller.dateList.length,
                                    itemBuilder: (_, index) {
                                      final date = controller.dateList[index];
                                      final amount =
                                          controller.amountList[index];
                                      return Container(
                                        child: <Widget>[
                                          Text(
                                            amount,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: primaryColor),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          LayoutBuilder(builder: (_, c) {
                                            return Container(
                                              width: 8,
                                              height: (c.maxWidth * 4 - 85) / controller.maxAmount * (double.parse(amount)),
                                            ).decorated(
                                                color: primaryColor,
                                                borderRadius: const BorderRadius
                                                    .only(
                                                    topLeft: Radius.circular(4),
                                                    topRight:
                                                        Radius.circular(4)));
                                          }),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            date,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ].toColumn(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end),
                                      );
                                    });
                          }))
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ).decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 220,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  const Text(
                    'Consumption frequency',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    height: 15,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                      child: GetBuilder<ConsumptionSecondLogic>(
                          id: 'chart',
                          init: ConsumptionSecondLogic(),
                          builder: (_) {
                            return controller.dateList.isEmpty
                                ? const Center(
                              child: Text('No data'),
                            )
                                : GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3.5),
                                itemCount: controller.dateList.length,
                                itemBuilder: (_, index) {
                                  final date = controller.dateList[index];
                                  final num =
                                  controller.numList[index];
                                  return Container(
                                    child: <Widget>[
                                      Text(
                                        num,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      LayoutBuilder(builder: (_, c) {
                                        return Container(
                                          width: 8,
                                          height: (c.maxWidth * 4 - 85) / controller.maxNum * (double.parse(num)),
                                        ).decorated(
                                            color: primaryColor,
                                            borderRadius: const BorderRadius
                                                .only(
                                                topLeft: Radius.circular(4),
                                                topRight:
                                                Radius.circular(4)));
                                      }),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        date,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ),
                                    ].toColumn(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end),
                                  );
                                });
                          }))
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ).decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ].toColumn(),
          ).marginAll(12),
        ),
      ),
    );
  }
}
