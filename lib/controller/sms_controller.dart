import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/sms_model.dart';

class SmsController extends GetxController {
  var isLoading = true.obs;
  var smsList = <SmsModel>[].obs;

  Future<void> fetchSmsData(String ownerId, int offset) async {
    final url = Uri.parse('https://si-sms.net/api/getReceivedSms');
    try {
      isLoading(true);
      final response = await http.post(
        url,
        body: {
          'owner_id': ownerId,
          'offset': offset.toString(),
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 200) {
          List<dynamic> data = responseData['data'];
          smsList.value = data.map((e) => SmsModel.fromJson(e)).toList();
        } else {
          Get.snackbar("Error", responseData['message']);
        }
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
