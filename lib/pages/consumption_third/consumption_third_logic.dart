import 'package:consumption_record/db_consumption/db_consumption.dart';
import 'package:consumption_record/pages/consumption_first/consumption_first_logic.dart';
import 'package:consumption_record/pages/consumption_second/consumption_second_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConsumptionThirdLogic extends GetxController {

  DBConsumption dbConsumption = Get.find<DBConsumption>();

  cleanConsumptionData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all records?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbConsumption.cleanConsumptionData();
            ConsumptionFirstLogic consumptionFirstLogic = Get.find<ConsumptionFirstLogic>();
            consumptionFirstLogic.getData();
            ConsumptionSecondLogic consumptionSecondLogic = Get.find<ConsumptionSecondLogic>();
            consumptionSecondLogic.getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutConsumptionPrivacy(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Privacy Policy"),
          ),
          body: const Markdown(data: """
#### Data Collection
Our apps do not collect any personal information or user data. All event logs are executed locally on the device and are not transmitted to any external server.

#### Cookie Usage
Our app does not use any form of cookies or similar technologies to track user behavior or personal information.

#### Data Security
User input data is only used for calculations on the user's device and is not stored or transmitted. We are committed to ensuring the security of user data.

#### Contact Information
If you have any questions or concerns about our privacy policy, please contact us via email.
          """),
        );
      },
    );
  }

  aboutConsumptionUS(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/10900.png',
        width: 72,
        height: 72,
      ),
      children: [
        const Text(
            """We can provide you with a record of your purchases"""),
      ],
      context: context,
    );
  }

}
