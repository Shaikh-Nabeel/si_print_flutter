import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UpdateMobileNumberController extends GetxController {
  var selectedCountryCode = '91'.obs;
  var otp = ''.obs;
  RxBool isLoading = false.obs;

  var otpControllers = List.generate(6, (_) => TextEditingController()).obs;
  var otpFocusNodes = List.generate(6, (_) => FocusNode()).obs;
  TextEditingController phoneController = TextEditingController();

  final String apiUrl = "https://si-sms.net/api/updatePhone";

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

  void changeCountryCode(String code) {
    selectedCountryCode.value = code.replaceAll('+', '');
  }

  void nextField(String value, int index) {
    if (value.length == 1 && index < otpFocusNodes.length - 1) {
      FocusScope.of(Get.context!).requestFocus(otpFocusNodes[index + 1]);
    }
  }

  void submitOtp() {
    otp.value = otpControllers.map((controller) => controller.text).join();
    if (otp.value.length == 6) {
      Get.snackbar("OTP Submitted", "Your OTP is ${otp.value}");
    } else {
      Get.snackbar("Error", "Please enter the full OTP");
    }
  }

  Future<void> updatePhoneNumber() async {
    if (phoneController.text.isEmpty || phoneController.text.length < 10) {
      Get.snackbar("Error", "Enter a valid phone number");
      return;
    }

    isLoading.value = true;
    try {
      final body = {
        'user_id': "3",
        'phone': phoneController.text.trim(),
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 200) {
        Get.snackbar('Success', responseData['message']);
      } else {
        Get.snackbar('Error', responseData['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
