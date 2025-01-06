import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'model.dart';

class DashboardController extends GetxController {
  var isLoading = true.obs;
  var userData = Rxn<UserDatas>();
  var invoices = <Invoices>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  void fetchDashboardData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString("userId") ?? '';
      isLoading(true);
      final response = await http.get(Uri.parse("https://si-sms.net/api/dashboard?user_id=5&offset=0"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        userData.value = UserDatas.fromJson(data['user_data']);
        invoices.value = (data['invoices'] as List)
            .map((invoice) => Invoices.fromJson(invoice))
            .toList();
      } else {
        Get.snackbar("Error", "Failed to load data");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
