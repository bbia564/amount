import 'package:consumption_record/db_consumption/consumption_entity.dart';
import 'package:consumption_record/db_consumption/db_consumption.dart';
import 'package:get/get.dart';

class ConsumptionFirstLogic extends GetxController {
  DBConsumption dbConsumption = Get.find<DBConsumption>();

  var list = <ConsumptionEntity>[].obs;
  var consumptionNum = 0.obs;
  var consumptionSum = '0'.obs;
  var consumptionAvg = '0'.obs;

  var dateItemType = 0;
  var dateItemImageSrc = 'assets/filtGreyDown.webp';
  var evaluateItemType = 0;
  var evaluateItemImageSrc = 'assets/filtGreyDown.webp';
  var amountItemType = 0;
  var amountItemImageSrc = 'assets/filtGreyDown.webp';

  void filtTap(int index) async {
    switch (index) {
      case 0:
        if (dateItemType == 0) {
          dateItemType = 1;
          dateItemImageSrc = 'assets/filtLightDown.webp';
        } else if (dateItemType == 1) {
          dateItemType = 2;
          dateItemImageSrc = 'assets/filtLight.webp';
        } else if (dateItemType == 2) {
          dateItemType = 1;
          dateItemImageSrc = 'assets/filtLightDown.webp';
        }
        evaluateItemType = 0;
        evaluateItemImageSrc = 'assets/filtGreyDown.webp';
        amountItemType = 0;
        amountItemImageSrc = 'assets/filtGreyDown.webp';
        list.value =
            await dbConsumption.getAllData(isDateAsc: dateItemType == 2);
        break;
      case 1:
        if (evaluateItemType == 0) {
          evaluateItemType = 1;
          evaluateItemImageSrc = 'assets/filtLightDown.webp';
        } else if (evaluateItemType == 1) {
          evaluateItemType = 2;
          evaluateItemImageSrc = 'assets/filtLight.webp';
        } else if (evaluateItemType == 2) {
          evaluateItemType = 1;
          evaluateItemImageSrc = 'assets/filtLightDown.webp';
        }
        dateItemType = 0;
        dateItemImageSrc = 'assets/filtGreyDown.webp';
        amountItemType = 0;
        amountItemImageSrc = 'assets/filtGreyDown.webp';
        list.value =
            await dbConsumption.getAllData(isStarAsc: evaluateItemType == 2);
        break;
      case 2:
        if (amountItemType == 0) {
          amountItemType = 1;
          amountItemImageSrc = 'assets/filtLightDown.webp';
        } else if (amountItemType == 1) {
          amountItemType = 2;
          amountItemImageSrc = 'assets/filtLight.webp';
        } else if (amountItemType == 2) {
          amountItemType = 1;
          amountItemImageSrc = 'assets/filtLightDown.webp';
        }
        dateItemType = 0;
        dateItemImageSrc = 'assets/filtGreyDown.webp';
        evaluateItemType = 0;
        evaluateItemImageSrc = 'assets/filtGreyDown.webp';
        list.value =
            await dbConsumption.getAllData(isAmountAsc: amountItemType != 2);
        break;
    }
    update();
    countNum();
  }

  void getData() async {
    dateItemType = 0;
    dateItemImageSrc = 'assets/filtGreyDown.webp';
    evaluateItemType = 0;
    evaluateItemImageSrc = 'assets/filtGreyDown.webp';
    amountItemType = 0;
    amountItemImageSrc = 'assets/filtGreyDown.webp';
    list.value = await dbConsumption.getAllData();
    countNum();
  }

  void countNum() {
    consumptionNum.value = list.length;
    if (list.value.isNotEmpty) {
      consumptionSum.value = list
          .map((e) => num.parse(e.amount))
          .reduce((value, element) => value + element)
          .toStringAsFixed(2);
      consumptionAvg.value = (list
                  .map((e) => num.parse(e.amount))
                  .reduce((value, element) => value + element) /
              list.length)
          .toStringAsFixed(2);
    } else {
      consumptionSum.value = '0';
      consumptionAvg.value = '0';
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
