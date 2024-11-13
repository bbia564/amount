import 'package:consumption_record/db_consumption/db_consumption.dart';
import 'package:consumption_record/pages/consumption_first/consumption_first_binding.dart';
import 'package:consumption_record/pages/consumption_first/consumption_first_view.dart';
import 'package:consumption_record/pages/consumption_second/consumption_second_binding.dart';
import 'package:consumption_record/pages/consumption_second/consumption_second_view.dart';
import 'package:consumption_record/pages/consumption_tab/consumption_tab_binding.dart';
import 'package:consumption_record/pages/consumption_third/consumption_third_binding.dart';
import 'package:consumption_record/pages/consumption_third/consumption_third_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'pages/consumption_tab/consumption_tab_view.dart';

Color primaryColor = const Color(0xffc68854);
Color bgColor = const Color(0xfffff8f5);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Get.putAsync(() => DBConsumption().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Rads,
      initialRoute: '/consumption_tab',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Rads = [
  GetPage(name: '/consumption_tab', page: () => ConsumptionTabPage(), binding: ConsumptionTabBinding()),
  GetPage(name: '/consumption_first', page: () => ConsumptionFirstPage(),binding: ConsumptionFirstBinding()),
  GetPage(name: '/consumption_second', page: () => ConsumptionSecondPage(),binding: ConsumptionSecondBinding()),
  GetPage(name: '/consumption_third', page: () => ConsumptionThirdPage(),binding: ConsumptionThirdBinding()),
];