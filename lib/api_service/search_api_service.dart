import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/search_pdf_model.dart';

class SearchPdfService {
  static const String apiUrl = "https://si-sms.net/api/searchPdf";

  Future<List<SearchPdfModel>> searchPdf(String search, int offset) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString("userId") ?? '';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          "user_id": userId,
          "search": search,
          "offset": offset.toString(),
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 200 && data['message'] == "Success") {
          return (data['data'] as List)
              .map((item) => SearchPdfModel.fromJson(item))
              .toList();
        } else {
          throw Exception("Error: ${data['message']}");
        }
      } else {
        throw Exception("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching PDFs: $e");
    }
  }
}
