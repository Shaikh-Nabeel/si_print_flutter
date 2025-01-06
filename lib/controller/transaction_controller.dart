


// Controller
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionController extends GetxController {
  var transactions = [].obs;
  var isLoading = false.obs;

  Future<void> fetchTransactions() async {
    isLoading.value = true;
    final url = Uri.parse('https://si-sms.net/api/getTransactions');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"user_id": 1, "offset": 0}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 200) {
          transactions.value = jsonResponse['data'];
        } else {
          Get.snackbar('Error', 'Failed to fetch data.');
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

