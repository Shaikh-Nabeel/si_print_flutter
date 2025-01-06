import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_service/filter_api_service.dart';
import '../model/filter_pdf_model.dart';

class HomeController extends GetxController {


  final PDFService _pdfService = PDFService();
  final TextEditingController startingDateController = TextEditingController();
  final TextEditingController endingDateController = TextEditingController();

  var startingMilliseconds = 0.obs;
  var endingMilliseconds = 0.obs;
  var isLoading = false.obs;
  var pdfList = <PdfData>[].obs;
  var errorMessage = ''.obs;

  /// Convert a date to milliseconds since the epoch
  int convertDateToMilliseconds(String date) {
    try {
      final DateTime parsedDate = DateTime.parse(
        '${date.split('-')[2]}-${date.split('-')[1]}-${date.split('-')[0]}T00:00:01',
      );
      return parsedDate.millisecondsSinceEpoch;
    } catch (e) {
      throw FormatException('Invalid date format. Please use dd-MM-yyyy.');
    }
  }

  /// Set starting date and convert to milliseconds
  void setStartingDate(String date) {
    try {
      startingMilliseconds.value = convertDateToMilliseconds(date);
      print("${startingDateController.text} Date in Milliseconds: ${startingMilliseconds.value}"); // Log the value

    } catch (e) {
      throw FormatException('Invalid starting date format. Please use dd-MM-yyyy.');
    }
  }

  /// Set ending date and convert to milliseconds
  void setEndingDate(String date) {
    try {
      endingMilliseconds.value = convertDateToMilliseconds(date);
      print("${endingDateController.text}  Date in Milliseconds: ${endingMilliseconds.value}"); // Log the value

    } catch (e) {
      throw FormatException('Invalid ending date format. Please use dd-MM-yyyy.');
    }
  }

  /// Clear both date inputs and reset milliseconds
  void clearDates() {
    startingDateController.clear();
    endingDateController.clear();
    startingMilliseconds.value = 0;
    endingMilliseconds.value = 0;
  }


  String getFileName(String path) {
    return path.split('/').last;
  }

  String getFormattedDate(String dateTime) {
    return dateTime.split(' ').first;
  }
  @override
  void onInit() {
    super.onInit();
    // Fetch data with default date range
    fetchPDFs("${startingMilliseconds.value}", "${endingMilliseconds.value}");
    print("${startingMilliseconds.value}dateeeeeeeeee");
    print(endingMilliseconds.value);
  }
  // Fetch PDFs with startDate and endDate
  Future<void> fetchPDFs(String startDate, String endDate) async {
    try {
      print("${startingMilliseconds.value}dateeeeeeeeee");
      print(endingMilliseconds.value);
      isLoading(true); // Start loading
      errorMessage(''); // Clear previous errors
      // pdfList.clear(); // Clear previous data

      // Fetch data from the service
      final data = await _pdfService.fetchPDFs(startDate, endDate);
      pdfList.addAll(data); // Add data to the observable list
    } catch (e) {
      errorMessage(e.toString()); // Set error message
    } finally {
      isLoading(false); // Stop loading
    }
  }
  void onScrollEvent(ScrollController scrollController) {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      fetchPDFs("${startingMilliseconds.value}", "${endingMilliseconds.value}");
    }
  }

  final searchController = TextEditingController();
  var isSearching = false.obs;
  var isPdfSearching = false.obs;
  var isFiltering = false.obs;
  var uploadedFiles = <Map<String, String>>[].obs;
  var filteredFiles = <Map<String, String>>[].obs;
  var showFilteredPage = false.obs;
  final String apiUrl = 'https://si-sms.net/api/uploadPdf';
  // final String userId = '5';
  // final String ownerNumber = '91746083725';
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  // Method to pick a date
  Future<void> pickDate(BuildContext context, bool isStart) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStart
          ? startDate.value ?? DateTime.now()
          : endDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      if (isStart) {
        startDate.value = pickedDate;
      } else {
        endDate.value = pickedDate;
      }
    }
  }

  // Format date for display
  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd-MM-yyyy').format(date);
  }
  Future<void> uploadPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString("userId") ?? '';
      File file = File(result.files.single.path!);
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.fields['id'] = userId;
      // request.fields['owner'] = ownerNumber;
      request.files.add(await http.MultipartFile.fromPath('pdf', file.path));
      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var decodedResponse = json.decode(responseData);

          if (decodedResponse['status'] == 200) {
            Get.snackbar('Success', 'File uploaded successfully.');
          } else {
            Get.snackbar('Error', 'Upload failed: ${decodedResponse['message']}');
          }
        } else {
          Get.snackbar('Error', 'File upload failed with status code ${response.statusCode}.');
        }
      } catch (e) {
        Get.snackbar('Error', 'Error: ${e.toString()}');
      }
    } else {
      Get.snackbar('No file selected', 'Please select a file.');
    }
  }
}
