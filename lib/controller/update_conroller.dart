import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  final isLoading = false.obs;
  var profileImageUrl = ''.obs; // Observable for the image URL
  RxString selectedGender = ''.obs;  // Observable for the image URL
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  // Load user data from SharedPreferences and set it to the controllers
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? gender = prefs.getString("gender");
    selectedGender.value = gender ?? 'Male';
    photoController.text = prefs.getString("photo") ?? '';
    nameController.text = prefs.getString("name") ?? '';
    emailController.text = prefs.getString("email") ?? '';
    genderController.text = prefs.getString("gender") ?? '';
    phoneController.text = prefs.getString("phone") ?? '';
    profileImageUrl.value = prefs.getString("photo") ?? '';
    print("Loaded user data:");
    print("Name: ${nameController.text}, Email: ${emailController.text}, Gender: ${genderController.text}, Phone: ${phoneController.text}, Photo: ${profileImageUrl.value}");
  }
  // Pick an image from the gallery or camera
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Update photoController and the profileImageUrl
      photoController.text = pickedFile.path;
      profileImageUrl.value = pickedFile.path;

      // Save the selected image path to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("photo", pickedFile.path);
    }
  }

  // Update user details on the server
  Future<void> updateUserDetails() async {
    const String url = 'https://si-sms.net/api/updateUserDetails';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId") ?? '';

    final body = {
      'user_id': "3",
      'name': nameController.text,
      'email': emailController.text,
      'gender': genderController.text,
      'phone': phoneController.text,
      'photo': photoController.text,
    };

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(url),
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 200) {
          await prefs.setString("photo", photoController.text);
          await prefs.setString("name", nameController.text);
          await prefs.setString("email", emailController.text);
          await prefs.setString("gender", genderController.text);
          await prefs.setString("phone", phoneController.text);
          Get.snackbar('Success', responseData['message']);
          print('Updated User Data: ${responseData['data']}');
        } else {
          Get.snackbar('ErrorRRRRRRRRRRR', responseData['message']);
        }
      } else {
        Get.snackbar('Error', 'Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('ErrorRRRRRRRRRRRuuuuuuuuuuu', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
