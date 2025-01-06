import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class UpdatePhoneController extends GetxController {
  // Controllers for user input
  TextEditingController phoneController = TextEditingController();
  RxBool isLoading = false.obs;

  // API URL
  final String apiUrl = "https://si-sms.net/api/updatePhone";

  // Function to update phone number
  Future<void> updatePhoneNumber() async {
    isLoading.value = true;

    try {
      // Prepare the request body
      final Map<String, String> body = {
        'user_id': "3",
        'phone': phoneController.text,
      };

      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      // Handle response
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 200) {
          // Success
          Get.snackbar('Success', responseData['message'], snackPosition: SnackPosition.BOTTOM);
        } else {
          // Failure message
          Get.snackbar('Error', responseData['message'], snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        // API call failure
        Get.snackbar('Error', 'Failed to update phone number.', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      // Error handling
      Get.snackbar('Error', 'Something went wrong: $e', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
