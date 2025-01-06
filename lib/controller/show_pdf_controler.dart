// controllers/home_controller.dart

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/show_pdf_model.dart';
import '../view/login_page.dart';

class ShowPdfController extends GetxController {
  var userData = Rxn<UserData>();
  var invoices = <Invoice>[].obs;
  var isLoading = true.obs;
  var isMoreDataAvailable = true.obs;
  var offset = 0.obs;

  @override
  void onInit() {
    fetchDashboardData();
    super.onInit();
  }
  String getFileName(String path) {
    return path.split('/').last;
  }

  String getFormattedDate(String dateTime) {
    return dateTime.split(' ').first;
  }
  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    print("Retrieved User ID: $userId");
  }

  Future<void> fetchDashboardData() async {
    if (!isMoreDataAvailable.value) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId") ?? '';

    isLoading(true);
    final url = Uri.parse("https://si-sms.net/api/dashboard?user_id=5&offset=${offset.value}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String name = data['data']['user_data']["name"];
        String email = data['data']['user_data']["email"];
        String phone = data['data']['user_data']["phone"];
        String photo = data['data']['user_data']["photo"];
        // Save user ID in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("name", name);
        await prefs.setString("email", email);
        await prefs.setString("phone", phone);
        await prefs.setString("photo", photo);
        print("this is the my name ${name}");
        print("this is the my email ${email}");
        print("this is the my phone ${phone}");
        print("this is the my photo ${photo}");
        prefs.setBool('isLoggedIn', true);
        if (data['data']['invoices'].isNotEmpty)
        {
          invoices.addAll(
            (data['data']['invoices'] as List).map((invoice) => Invoice.fromJson(invoice)).toList(),
          );
          offset.value++;
          if ((data['data']['invoices'] as List).length <20){
            isMoreDataAvailable(false);
          }
        } else {
          isMoreDataAvailable(false);
        }

        userData.value = UserData.fromJson(data['data']['user_data']);
        print("wwwwwwwwwwwwwwwwwwwwww${userData.value}");
      } else {
        Get.snackbar("Error", "Failed to fetch data");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.clear();
      Get.offAll(() => LoginPage());
    } catch (e) {
      print('Error logging out: $e');

    }
  }
  // Function to detect when the user has scrolled to the bottom
  void onScrollEvent(ScrollController scrollController) {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      fetchDashboardData();
    }
  }
}
