import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/filter_pdf_model.dart';

class PDFService {
  static const String baseUrl = "https://si-sms.net/api/pdfFilter";

  Future<List<PdfData>> fetchPDFs( String startDate, String endDate,) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString("userId") ?? '';
      final Uri url = Uri.parse(
        '$baseUrl?user_id=${userId}&starting=$startDate&ending=$endDate&offset=0',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 200 && data['message'] == "success") {
          return (data['data'] as List).map((pdf) => PdfData.fromJson(pdf)).toList();
        } else {
          throw Exception("Failed to fetch PDFs: ${data['message']}");
        }
      } else {
        throw Exception("HTTP error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching PDFs: $e");
    }
  }
}
