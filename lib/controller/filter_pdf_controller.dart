// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import '../api_service/filter_api_service.dart';
// import '../model/filter_pdf_model.dart';
// import '../test.dart';
//
// class PDFController extends GetxController {
//   final PDFService _pdfService = PDFService();
//   final TextEditingController startingDateController = TextEditingController();
//   final TextEditingController endingDateController = TextEditingController();
//
//   var startingMilliseconds = 0.obs;
//   var endingMilliseconds = 0.obs;
//   var isLoading = false.obs;
//   var pdfList = <PdfData>[].obs;
//   var errorMessage = ''.obs;
//
//   /// Convert a date to milliseconds since the epoch
//
//   /// Set starting date and convert to milliseconds
//   void setStartingDate(String date) {
//     try {
//       startingMilliseconds.value = convertDateToMilliseconds(date);
//       print("${startingDateController.text} Date in Milliseconds: ${startingMilliseconds.value}"); // Log the value
//
//     } catch (e) {
//       throw FormatException('Invalid starting date format. Please use dd-MM-yyyy.');
//     }
//   }
//
//   /// Set ending date and convert to milliseconds
//   void setEndingDate(String date) {
//     try {
//       endingMilliseconds.value = convertDateToMilliseconds(date);
//       print("${endingDateController.text}  Date in Milliseconds: ${endingMilliseconds.value}"); // Log the value
//
//     } catch (e) {
//       throw FormatException('Invalid ending date format. Please use dd-MM-yyyy.');
//     }
//   }
//
//   /// Clear both date inputs and reset milliseconds
//   void clearDates() {
//     startingDateController.clear();
//     endingDateController.clear();
//     startingMilliseconds.value = 0;
//     endingMilliseconds.value = 0;
//   }
//
//
//   String getFileName(String path) {
//     return path.split('/').last;
//   }
//
//   String getFormattedDate(String dateTime) {
//     return dateTime.split(' ').first;
//   }
//   @override
//   void onInit() {
//     super.onInit();
//     // Fetch data with default date range
//     fetchPDFs("${startingMilliseconds.value}", "${endingMilliseconds.value}");
//     print("${startingMilliseconds.value}dateeeeeeeeee");
//     print(endingMilliseconds.value);
//   }
//   // Fetch PDFs with startDate and endDate
//   Future<void> fetchPDFs(String startDate, String endDate) async {
//     try {
//       isLoading(true); // Start loading
//       errorMessage(''); // Clear previous errors
//       pdfList.clear(); // Clear previous data
//
//       // Fetch data from the service
//       final data = await _pdfService.fetchPDFs(startDate, endDate);
//       pdfList.addAll(data); // Add data to the observable list
//     } catch (e) {
//       errorMessage(e.toString()); // Set error message
//     } finally {
//       isLoading(false); // Stop loading
//     }
//   }
//   void onScrollEvent(ScrollController scrollController) {
//     if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
//       fetchPDFs("${startingMilliseconds.value}", "${startingMilliseconds.value}");
//     }
//   }
// }
