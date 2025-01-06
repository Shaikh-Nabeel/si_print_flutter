import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../view/buttom_nav_bar_page.dart';


class RegistrationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  RxString photoPath = ''.obs;  // Holds the path of the selected photo
  RxString genderController = ''.obs;  // Holds selected gender
  final gender = 'Male'.obs;
  final isLoading = false.obs;
  File? image;
  Rx<File?> photo = Rx<File?>(null);

  final ImagePicker picker = ImagePicker();

  // Pick an image from the gallery
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo.value = File(pickedFile.path);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadImagePath();
  }

  // Load the image path from shared preferences
  Future<void> _loadImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPhotoPath = prefs.getString('photoPath');
    if (savedPhotoPath != null && savedPhotoPath.isNotEmpty) {
      photoPath.value = savedPhotoPath;  // Update the observable with the saved path
    }
  }

  // Save the image path to shared preferences
  Future<void> _saveImagePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('photoPath', path);  // Save the path
  }

  void setGender(String value) {
    gender.value = value;
  }

  void clearForm() {
    idController.clear();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    gender.value = 'Male';
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  @override
  void onClose() {
    idController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      photoPath.value = image.path;  // Update the observable with the image path
      _saveImagePath(image.path);  // Save the new image path
    } else {
      print("No image selected.");
    }
  }

  // Pick image from camera
  // Future<void> pickImageFromCamera() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  //
  //   if (image != null) {
  //     photoPath.value = image.path;  // Update the observable with the image path
  //     _saveImagePath(image.path);  // Save the new image path
  //   } else {
  //     print("No image captured.");
  //   }
  // }

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
    request.fields['gender'] = genderController.value;

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
          Get.to(BottomNavView());
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


}
