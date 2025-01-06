import 'dart:async';

import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si_print/controller/login_controller.dart';

import 'buttom_nav_bar_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());
  @override
  void initState() {
    super.initState();
    // checkLoginStatus();
  }
  // Future<void> checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  //
  //     if (isLoggedIn) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => BottomNavView()),
  //       );
  //     } else {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => LoginPage()),
  //       );
  //     }
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.ac_unit),
        title: const Text("SI PRINT"),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.025),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * 0.045),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/logo_image.png",
                    height: height * 0.3,
                    width: width * 0.7,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Get organised. Make life easier.",
                  style: TextStyle(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w500,
                    color: Colors.brown,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Never lose your Documents.",
                  style: TextStyle(
                    fontSize: width * 0.042,
                    fontWeight: FontWeight.w500,
                    color: Colors.brown,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.02),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.025),
                    border: Border.all(width: 1, color: Colors.brown),
                  ),
                  child: Row(
                    children: [
                      CountryCodePicker(
                        onChanged: (country) {
                          loginController.changeCountryCode(country.dialCode!);
                        },
                        initialSelection: 'المملكة العربية السعودية',
                        favorite: [
                          '+966',
                          'المملكة العربية السعودية',
                          '+91',
                          'India'
                        ],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                        showFlagMain: false,
                        showDropDownButton: true,
                        padding: EdgeInsets.zero,
                      ),
                      Expanded(
                        child: TextField(
                          controller: loginController.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Mobile number',
                            border: InputBorder.none,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: width * 0.025),
                          ),
                          onChanged: loginController.setPhoneNumber,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Lost Number?",
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Center(
                  child: Text(
                    "OTP",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.05,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                        (index) => SizedBox(
                      width: width * 0.13,
                      height: height * 0.07,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: height * 0.005,
                          horizontal: width * 0.005,
                        ),
                        child: TextField(
                          controller: loginController.otpControllers[index],
                          focusNode: loginController.otpFocusNodes[index],
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) =>
                              loginController.nextField(value, index),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Center(
                  child: InkWell(
                    onTap: () {
                      loginController.updateFcmToken();
                      String phoneNumber =
                          '${loginController.selectedCountryCode.value}${loginController.phoneController.text.trim()}';
                      String enteredOtp = loginController.otpControllers
                          .map((controller) => controller.text)
                          .join();

                      if (loginController.phoneController.text
                          .trim()
                          .isNotEmpty) {
                        if (phoneNumber.length >= 11 &&
                            phoneNumber.length <= 15) {
                          if (enteredOtp == "000000") {
                            loginController.loginUser(context, phoneNumber);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('OTP is incorrect')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please enter a 10-digit phone number')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please enter a phone number')),
                        );
                      }
                    },
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.025),
                        border: Border.all(color: Colors.grey, width: 1),
                        color: Colors.brown,
                      ),
                      child: Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: width * 0.045,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
