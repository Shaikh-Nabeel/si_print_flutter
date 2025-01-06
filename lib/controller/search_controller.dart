import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../api_service/search_api_service.dart';
import '../model/search_pdf_model.dart';

class SearchPdfController extends GetxController {
  final SearchPdfService _searchPdfService = SearchPdfService();
  final TextEditingController searchController = TextEditingController();


  // Observables for state management
  var isLoading = false.obs;
  var pdfList = <SearchPdfModel>[].obs;
  var errorMessage = ''.obs;


  String getFileName(String path) {
    return path.split('/').last;
  }

  String getFormattedDate(String dateTime) {
    return dateTime.split(' ').first;
  }
  // Fetch PDFs from the API
  Future<void> fetchPdfs(String search, int offset) async {
    try {
      isLoading(true);
      errorMessage('');
      pdfList.clear();

      // Call the service
      final data = await _searchPdfService.searchPdf(search, offset);
      pdfList.addAll(data);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
