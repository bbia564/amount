import 'package:consumption_record/pages/consumption_first/consumption_first_view.dart';
import 'package:consumption_record/pages/consumption_second/consumption_second_view.dart';
import 'package:consumption_record/pages/consumption_third/consumption_third_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'consumption_tab_logic.dart';

class ConsumptionTabPage extends GetView<ConsumptionTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          ConsumptionFirstPage(),
          ConsumptionSecondPage(),
          ConsumptionThirdPage()
        ],
      ),
      bottomNavigationBar: Obx(()=>_navConBars()),
    );
  }

  Widget _navConBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/tab0Unselect.webp',width: 23,height: 23,fit: BoxFit.cover,),
          activeIcon:Image.asset('assets/tab0Selected.webp',width: 23,height: 23,fit: BoxFit.cover,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/tab1Unselect.webp',width: 23,height: 23,fit: BoxFit.cover,),
          activeIcon:Image.asset('assets/tab1Selected.webp',width: 23,height: 23,fit: BoxFit.cover,),
          label: 'Statistics',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/tab2Unselect.webp',width: 23,height: 23,fit: BoxFit.cover,),
          activeIcon:Image.asset('assets/tab2Selected.webp',width: 23,height: 23,fit: BoxFit.cover,),
          label: 'Other',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        controller.currentIndex.value = index;
        controller.pageController.jumpToPage(index);
      },
    );
  }
}
