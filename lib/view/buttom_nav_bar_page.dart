import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_print/view/setting_page.dart';
import 'package:si_print/view/sms_page.dart';
import '../controller/butom_nav_bar_controller.dart';
import 'home_page.dart';
import 'miliseconds_test.dart';
import 'notifaction_page.dart';

class BottomNavView extends StatelessWidget {
  final BottomNavController bottomNavController = Get.put(BottomNavController());

  final List<Widget> pages = [
    HomePage(),
    SmsPage(),
    // DateRangeInputPage(),
    NotificationPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Obx(() {
        return SizedBox.expand(
          child: pages[bottomNavController.currentIndex.value],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: bottomNavController.currentIndex.value,
          onTap: bottomNavController.changeIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.message, 'SMS', 1),
            _buildNavItem(Icons.notifications_active_outlined, 'Notific', 2),
            _buildNavItem(Icons.settings, 'Setting', 3),
          ],
        );
      }),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        height:40,
        decoration: BoxDecoration(
          color: bottomNavController.currentIndex.value == index
              ? Colors.brown // Background color when selected
              : Colors.transparent, // Transparent when not selected
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: bottomNavController.currentIndex.value == index
                  ? Colors.white
                  : Colors.grey,
            ),
            if (bottomNavController.currentIndex.value == index)
              Padding(
                padding: const EdgeInsets.only(left:1.0),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
      label: '',
    );
  }
}
