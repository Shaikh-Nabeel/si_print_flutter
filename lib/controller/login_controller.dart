import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../view/buttom_nav_bar_page.dart';
import '../view/registration_page.dart';

class LoginController extends GetxController {
  var selectedCountryCode = '91'.obs; // Default without '+' sign
  var phoneNumber = ''.obs;
  var otp = ''.obs;
  RxString fcmToken = ''.obs;
  var otpControllers = List.generate(6, (_) => TextEditingController()).obs;
  var otpFocusNodes = List.generate(6, (_) => FocusNode()).obs;
  TextEditingController phoneController = TextEditingController();

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    phoneController.dispose();
    super.onClose();
  }


  @override
  void onInit() {
    super.onInit();
    getFcmToken();
  }

  // Method to handle OTP field navigation
  void nextField(String value, int index) {
    if (value.length == 1 && index < otpFocusNodes.length - 1) {
      FocusScope.of(Get.context!).requestFocus(otpFocusNodes[index + 1]);
    }
  }

  // Method to set the phone number
  void setPhoneNumber(String value) {
    phoneNumber.value = value;
  }

  // Method to handle country code change
  void changeCountryCode(String code) {
    selectedCountryCode.value = code.replaceAll('+', '');
  }

  // Method to concatenate OTP values and submit
  void submitOtp() {
    otp.value = otpControllers.map((controller) => controller.text).join();
    if (otp.value.length == 8) {
      Get.snackbar("OTP Submitted", "Your OTP is ${otp.value}");
      print("hello");
    } else {
      Get.snackbar("Error", "Please enter the full OTP");
    }
  }


  Future<void> getFcmToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      String? token = await messaging.getToken();

      if (token != null) {
        fcmToken.value = token; // Update the observable variable
        print("FCM Token: $token");
      } else {
        print("FCM Token is null");
      }
    } catch (e) {
      print("Error getting FCM token: $e");
    }
  }

  // Method to log in the user
  Future<void> loginUser(BuildContext context, String phoneNumber) async {
    var headers = {
       'Cookie': 'ci_session=e93c2de6e99ae2af8a6210c62cbe25fb82b54c7f',
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://si-sms.net/api/userLogin2'),
    );
    request.fields.addAll({
      'phone': phoneNumber,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      print("jsonResponse${jsonResponse}");
      if (jsonResponse['status'] == 200) {
        String userStatus = jsonResponse['data']['status'];
        String userId = jsonResponse['data']['id'];
        // Save user ID in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("userId", userId);
        await prefs.setBool('isLoggedIn', true);
        print("userid for check purpose${userId}");

        if (userStatus == 'NEW REGISTRATION') {
          print("${userId}userIdgggggggggggggggg");
          Get.to(RegistrationPage());
        } else if (userStatus == 'VALID') {
          print("${userId}userIdggggggggggggggggg");
          Get.to(BottomNavView());
        } else if (userStatus == 'BLOCK') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Blocked'),
                content: const Text('You are blocked. Please contact support.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          print('Unexpected user status: $userStatus');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonResponse['message'])),
        );
      }
    } else {
      print('Error: ${response.reasonPhrase}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to connect to the server.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  var isLoading = false.obs;

  Future<void> updateFcmToken() async {
    const String url = "https://si-sms.net/api/updateFcm";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId") ?? '';
    final body = {
      "user_id": userId,
      "fcmToken": fcmToken.value,
    };
    print(fcmToken.value);
     print(userId);
     print("ggggggggggggggggggggggggggggggggg");
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
         print(jsonData);
        if (jsonData['status'] == 200) {
          Get.snackbar("Success", "FCM Token updated successfully");
        } else {
          Get.snackbar("Errorgggggggggggggg", jsonData['message'] ?? "Update failed");
        }
      } else {
        Get.snackbar("Error", "Failed to connect to the server");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

}
