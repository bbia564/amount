import 'package:consumption_record/db_consumption/db_consumption.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../db_consumption/consumption_entity.dart';

class ConsumptionSecondLogic extends GetxController {

  DBConsumption dbConsumption = Get.find<DBConsumption>();

  DateTime? startTime;
  String startTimeString = '';
  DateTime? endTime;
  String endTimeString = '';

  List<String> dateList = [];
  List<String> amountList = [];
  List<String> numList = [];
  num maxAmount = 0;
  num maxNum = 0;

  void selectTime(BuildContext context, {bool isStartTime = true}) {
    DatePicker.showDatePicker(context, dateFormat: 'yyyy-MM-dd',
        onConfirm: (date, List<int> index) {
      if (isStartTime) {
        if (endTime != null) {
          if (date.isAfter(endTime!)) {
            Fluttertoast.showToast(msg: 'The start time must be smaller than the end time');
            return;
          }
          if (endTime!.difference(date).inDays > 30) {
            Fluttertoast.showToast(msg: 'The time span cannot exceed 30 days');
            return;
          }
        }
        startTime = date;
        startTimeString = DateFormat('yyyy-MM-dd').format(date);
      } else {
        if (startTime != null) {
          if (date.isBefore(startTime!)) {
            Fluttertoast.showToast(msg: 'The start time must be smaller than the end time');
            return;
          }
          if (date!.difference(startTime!).inDays > 30) {
            Fluttertoast.showToast(msg: 'The time span cannot exceed 30 days');
            return;
          }
        }
        endTime = date;
        endTimeString = DateFormat('yyyy-MM-dd').format(date);
      }
      update(['timeSelect']);
      getData();
    });
  }

  Map<String, List<ConsumptionEntity>> groupByDate(List<ConsumptionEntity> entities) {
    Map<String, List<ConsumptionEntity>> grouped = {};

    for (var entity in entities) {
      String date = entity.createdTime.toIso8601String().split('T')[0];
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]?.add(entity);
    }

    return grouped;
  }

  List<List<ConsumptionEntity>> generate2DArrayGroupedByDate(Map<String, List<ConsumptionEntity>> groupedEntities) {
    List<List<ConsumptionEntity>> result = [];

    groupedEntities.forEach((date, entities) {
      result.add(entities);
    });

    return result;
  }

  void getData() async {
    if (startTime == null || endTime == null) {
      return;
    }
    dateList.clear();
    amountList.clear();
    numList.clear();
    update(['chart']);
    final List<ConsumptionEntity> entities = await dbConsumption.queryConsumptionByDateRange(startTime!, endTime!);
    if (entities.isEmpty) {
      return;
    }
    final entitiesGroupedByDate = groupByDate(entities);
    final entities2DArrayGroupedByDate = generate2DArrayGroupedByDate(entitiesGroupedByDate);
    for (var item in entities2DArrayGroupedByDate) {
      final dateString = DateFormat('MM-dd').format(item[0].createdTime);
      dateList.add(dateString);
      amountList.add(item.map((e) => num.parse(e.amount)).reduce((value, element) => value + element).toString());
      numList.add(item.length.toString());
    }
    maxAmount = amountList.map((e) => num.parse(e)).reduce((value, element) => value > element ? value : element);
    maxNum = numList.map((e) => num.parse(e)).reduce((value, element) => value > element ? value : element);

  }


  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
