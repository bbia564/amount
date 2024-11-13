import 'dart:math';

import 'package:consumption_record/Utils/consumption_text_field.dart';
import 'package:consumption_record/db_consumption/consumption_entity.dart';
import 'package:consumption_record/db_consumption/db_consumption.dart';
import 'package:consumption_record/main.dart';
import 'package:consumption_record/pages/consumption_first/consumption_first_logic.dart';
import 'package:consumption_record/pages/consumption_second/consumption_second_logic.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../pages/consumption_first/star_widget.dart';

class Utils {
  static showFloatAddWidget(BuildContext context, {ConsumptionEntity? entity}) {
    String amount = '';
    String remark = '';
    double star = 0.0;
    if (entity != null) {
      amount = entity.amount;
      remark = entity.remark;
      star = entity.star.toDouble();
    }
    Get.bottomSheet(Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      height: 400,
      child: GetBuilder<ConsumptionFirstLogic>(
          id: 'bottomSheetRefresh',
          init: ConsumptionFirstLogic(),
          builder: (logic) {
            return SafeArea(
                child: <Widget>[
              <Widget>[
                const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ).gestures(onTap: () {
                  Get.back();
                }),
                Text(
                  entity == null ? 'Add record' : 'Modify details',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Commit',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ).gestures(onTap: () async {
                  if (amount.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please enter the amount');
                    return;
                  }
                  if (remark.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please enter remarks');
                    return;
                  }
                  final amountNum = num.tryParse(amount) ?? 0.0;
                  if (amountNum.toString().contains('.')) {
                    amount = amountNum.toStringAsFixed(2);
                  } else {
                    amount = amountNum.toString();
                  }
                  logic.update(['bottomSheetRefresh']);
                  if (amountNum <= 0) {
                    Fluttertoast.showToast(msg: 'The amount must be greater than 0');
                    return;
                  }
                  FocusScope.of(context).requestFocus(FocusNode());
                  DBConsumption dbConsumption = Get.find<DBConsumption>();
                  if (entity == null) {
                    final currentEntity = ConsumptionEntity(
                        id: 0,
                        createdTime: DateTime.now(),
                        amount: amount,
                        remark: remark,
                        star: star.toInt());
                   await dbConsumption.insertData(currentEntity);
                  } else {
                    final currentEntity = ConsumptionEntity(
                        id: entity!.id,
                        createdTime: entity!.createdTime,
                        amount: amount,
                        remark: remark,
                        star: star.toInt());
                    await dbConsumption.updateData(currentEntity);
                  }
                  Get.put(ConsumptionFirstLogic()).getData();
                  Get.put(ConsumptionSecondLogic()).getData();
                  Fluttertoast.showToast(msg: 'Success');
                  Get.back();
                }),
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
              Divider(
                height: 25,
                color: Colors.grey.withOpacity(0.3),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: <Widget>[
                    const Text(
                      'Amount',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ConsumptionTextField(
                          padding: EdgeInsets.zero,
                          hintText: 'Input amount',
                          isNumber: true,
                          maxLength: 4,
                          value: amount,
                          onChange: (value) {
                            amount = value;
                          }),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.grey.withOpacity(0.3),
                    ).marginOnly(bottom: 10),
                    const Text(
                      'Remark',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ConsumptionTextField(
                          padding: EdgeInsets.zero,
                          hintText: 'Enter remarks',
                          maxLength: 20,
                          value: remark,
                          onChange: (value) {
                            remark = value;
                          }),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.grey.withOpacity(0.3),
                    ).marginOnly(bottom: 10),
                    <Widget>[
                      const Text(
                        'Mark',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      StarWidget(
                        value: star,
                        onChange: (value) {
                          star = value;
                          logic.update(['bottomSheetRefresh']);
                        },
                      )
                    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                  ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                ),
              )
            ].toColumn());
          }),
    ).decorated(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12))));
  }
}
