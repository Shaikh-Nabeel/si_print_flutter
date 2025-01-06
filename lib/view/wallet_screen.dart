import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_print/controller/wallet_controller.dart';
import 'package:si_print/view/transaction_page.dart';
import 'package:si_print/view/wallet_credit_screen.dart';
import 'package:si_print/view/ztest.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  final WalletController controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(Icons.ac_unit_outlined),
                  Text(
                    "SI PRINT",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ],
              ),
            ),
            // Dynamic Section Title
            Obx(
                  () => Container(
                height: 45,
                width: double.infinity,
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 20),
                  child: Text(
                    controller.selectedOption.value.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Option Containers
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 120,
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Wallet Option
                    _buildOption(
                      label: "Wallet",
                      color: Colors.greenAccent,
                      icon: Icons.account_balance_wallet,
                      iconColor: Colors.green,
                    ),
                    SizedBox(width: 20),
                    // Transaction Option
                    _buildOption(
                      label: "Transaction",
                      color: Colors.redAccent,
                      icon: Icons.swap_horiz,
                      iconColor: Colors.red,
                    ),
                    SizedBox(width: 20),
                    // Usage Option
                    _buildOption(
                      label: "Usage",
                      color: Colors.blueAccent,
                      icon: Icons.pie_chart,
                      iconColor: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            SizedBox(height: 20),
            // Dynamic Content
            Expanded(
              child: Obx(
                    () {
                  if (controller.selectedOption.value == "Wallet") {
                     return WalletCreditScreen();

                  } else if (controller.selectedOption.value == "Transaction") {
                    return TransactionView();
                  } else if (controller.selectedOption.value == "Usage") {
                    return CreditView();
                  } else {
                    return Center(
                      child: Text("Select an option"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build an option card
  Widget _buildOption({
    required String label,
    required Color color,
    required IconData icon,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: () => controller.changeOption(label),
      child: Obx(
            () => Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
            border: Border.all(
              color: controller.selectedOption.value == label
                  ? Colors.black
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconColor,
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(label,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
