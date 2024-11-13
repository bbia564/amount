import 'package:consumption_record/Utils/Utils.dart';
import 'package:consumption_record/main.dart';
import 'package:consumption_record/pages/consumption_first/star_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'consumption_first_logic.dart';

class ConsumptionFirstPage extends GetView<ConsumptionFirstLogic> {
  Widget _tapItem(int index, String title) {
    final titles = ['Records','Statistical', 'Consumption'];
    return Expanded(
        child: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            titles[index],
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ].toColumn(mainAxisAlignment: MainAxisAlignment.center));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
      body: <Widget>[
        Container(
          height: 70,
          child: <Widget>[
            Obx(() {
              return _tapItem(0, controller.consumptionNum.value.toString());
            }),
            Obx(() {
              return _tapItem(1, controller.consumptionSum.value);
            }),
            Obx(() {
              return _tapItem(2, controller.consumptionAvg.value);
            })
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround),
        ).decorated(
            color: primaryColor, borderRadius: BorderRadius.circular(12)),
        <Widget>[
          <Widget>[
            Container(
              height: 20,
              width: 4,
            ).decorated(
                color: primaryColor, borderRadius: BorderRadius.circular(2)),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'List',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ].toRow(),
          GetBuilder<ConsumptionFirstLogic>(
              init: ConsumptionFirstLogic(),
              builder: (_) {
                return <Widget>[
                  <Widget>[
                    Image.asset(
                      controller.dateItemImageSrc,
                      width: 14,
                      height: 12,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Date',
                      style: TextStyle(
                          fontSize: 12,
                          color: controller.dateItemType == 0
                              ? const Color(0xff8d8d8d)
                              : primaryColor),
                    ),
                  ].toRow().gestures(onTap: () {
                    controller.filtTap(0);
                  }),
                  const SizedBox(
                    width: 8,
                  ),
                  <Widget>[
                    Image.asset(
                      controller.evaluateItemImageSrc,
                      width: 14,
                      height: 12,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Evaluate',
                      style: TextStyle(
                          fontSize: 12,
                          color: controller.evaluateItemType == 0
                              ? const Color(0xff8d8d8d)
                              : primaryColor),
                    ),
                  ].toRow().gestures(onTap: () {
                    controller.filtTap(1);
                  }),
                  const SizedBox(
                    width: 8,
                  ),
                  <Widget>[
                    Image.asset(
                      controller.amountItemImageSrc,
                      width: 14,
                      height: 12,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Amount',
                      style: TextStyle(
                          fontSize: 12,
                          color: controller.amountItemType == 0
                              ? const Color(0xff8d8d8d)
                              : primaryColor),
                    ),
                  ].toRow().gestures(onTap: () {
                    controller.filtTap(2);
                  }),
                ].toRow(mainAxisAlignment: MainAxisAlignment.end);
              })
        ]
            .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            .marginSymmetric(vertical: 15),
        Expanded(child: Obx(() {
          return controller.list.value.isEmpty
              ? const Center(
            child: Text('No data'),
          )
              : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 160.0 / 146.0,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              padding: EdgeInsets.zero,
              itemCount: controller.list.value.length,
              itemBuilder: (_, index) {
                final entity = controller.list.value[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  child: <Widget>[
                    <Widget>[
                      Expanded(
                        child: Text(
                          entity.amount,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        entity.timeTransString,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ].toRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          entity.remark,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 14, color: Color(0xff838383)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ).decorated(
                          color: const Color(0xfff7f7f7),
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 20,
                      child: IgnorePointer(
                          child: StarWidget(
                              value: entity.star.toDouble(),
                              onChange: (value) {})),
                    )
                  ].toColumn(),
                ).decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)).gestures(onTap: (){
                      Utils.showFloatAddWidget(context,entity: entity);
                });
              });
        }))
      ].toColumn().marginAll(15),
    );
  }
}
