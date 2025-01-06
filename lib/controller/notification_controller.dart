// controllers/notifications_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/notification_model.dart';

class NotificationsController extends GetxController {
  var isLoading = true.obs;
  var notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId") ?? '';
    final url = "https://si-sms.net/api/getNotifications?user_id=2";

    try {
      isLoading(true);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'] == 200) {
          final List<dynamic> data = jsonData['data'];
          notifications.value =
              data.map((e) => NotificationModel.fromJson(e)).toList();
        } else {
          Get.snackbar("Error", jsonData['message'] ?? "Failed to fetch data");
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
