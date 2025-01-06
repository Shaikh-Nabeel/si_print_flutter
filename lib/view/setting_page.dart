import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_print/view/test123/view.dart';
import 'package:si_print/view/transaction_page.dart';
import 'package:si_print/view/update_page.dart';
import 'package:si_print/view/wallet_screen.dart';
import 'package:si_print/view/ztest.dart';
import 'package:si_print/view/ztext23.dart';
import '../controller/show_pdf_controler.dart';

class SettingPage extends StatefulWidget {
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final ShowPdfController accountController = Get.put(ShowPdfController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (accountController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // If userData is null, use static data
        final userData = accountController.userData.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              height: 70,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: const [
                  Icon(Icons.logo_dev_outlined),
                  SizedBox(width: 10),
                  Text(
                    "SI PRINT",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              height: 44,
              width: double.infinity,
              color: Colors.brown.shade100,
              padding: const EdgeInsets.only(top: 9, left: 9, bottom: 9),
              child: const Text(
                "Setting",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      if (userData?.photo != null && userData!.photo!.isNotEmpty)
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(userData.photo!),
                          onBackgroundImageError: (_, __) => Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          ),
                        )
                      else
                        CircleAvatar(
                          radius: 60,
                          child: Icon(
                            Icons.person,
                            size: 60,
                          ),
                        ),
                      Positioned(
                        bottom: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(UpdateUserPage());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userData?.name ?? "Guest User",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    userData?.phone ?? "No Phone Number",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: double.infinity,
                    color: Colors.brown,
                    child: Center(
                      child:Text(
                        userData != null
                            ? "Total files: ${int.tryParse(userData.selfUpload ?? '0')! + int.tryParse(userData.partyUpload ?? '0')!}"
                            : "Total files: 0",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width / 2,
                        color: Colors.brown.shade200,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Upload By Self",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5),
                              Text(
                                "${userData?.selfUpload ?? "0"} Files",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width / 2,
                        color: Colors.brown.shade100,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Upload By Party",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5),
                              Text(
                                "${userData?.partyUpload ?? "0"} Files",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap:(){
                        Get.to(WalletScreen());
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Text(
                          "Wallet",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                    const Divider(),
                     Padding(
                      padding: EdgeInsets.all(6.0),
                      child: InkWell(
                        onTap:(){
                             Get.to(DashboardView());
                        },
                        child: const Text(
                          "Contact us",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: InkWell(
                        onTap: (){
                           Get.to(TransactionView());
                        },
                        child: const Text(
                          "Terms & Condition",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "About us",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () async {
                        accountController.logout();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Text(
                          "Log Out",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
