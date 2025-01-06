import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UserRegistrationController extends GetxController {
  // TextEditingControllers for user inputs
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();

  // For storing the picked image
  Rx<File?> photo = Rx<File?>(null);

  // ImagePicker instance
  final ImagePicker picker = ImagePicker();

  // Pick an image from the gallery
  Future<void> pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        photo.value = File(pickedFile.path);
      } else {
        Get.snackbar('No Image Selected', 'Please select an image.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Send POST API request
  Future<void> registerUser() async {
    final url = Uri.parse("https://si-sms.net/api/userRegistration2");

    // if (nameController.text.isEmpty ||
    //     idController.text.isEmpty ||
    //     passwordController.text.isEmpty ||
    //     emailController.text.isEmpty ||
    //     genderController.text.isEmpty ||
    //     photo.value == null) {
    //   Get.snackbar('Error', 'All fields are required.',
    //       snackPosition: SnackPosition.BOTTOM);
    //   return;
    // }

    var request = http.MultipartRequest('POST', url);

    // Adding form fields
    request.fields['name'] = nameController.text;
    request.fields['id'] = idController.text;
    request.fields['password'] = passwordController.text;
    request.fields['email'] = emailController.text;
    request.fields['gender'] = genderController.text;

    // Adding the photo file
    try {
      if (photo.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath('photo', photo.value!.path),
        );
      }

      // Sending the request
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final jsonResponse = json.decode(responseData.body);

        if (jsonResponse['status'] == 200) {
          Get.snackbar('Success', jsonResponse['message'],
              snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar('Error', jsonResponse['message'],
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to register user: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Dispose controllers to avoid memory leaks
  @override
  void onClose() {
    nameController.dispose();
    idController.dispose();
    passwordController.dispose();
    emailController.dispose();
    genderController.dispose();
    super.onClose();
  }
}
