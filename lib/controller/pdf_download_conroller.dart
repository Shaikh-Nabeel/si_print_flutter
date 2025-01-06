// pdf_downloader_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';

class PdfDownloaderController {

  final ValueNotifier<double> downloadProgress = ValueNotifier(0.0);
  String getFileName(String path) {
    return path.split('/').last;
  }
  Future<void> downloadAndSavePdf(BuildContext context,pdfUrl) async {
    try {
      // Get the directory to save the file
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        throw Exception("Could not find storage directory.");
      }

      final filePath = '${directory.path}/Download/${getFileName(pdfUrl)}';

      final dio = Dio();
      await dio.download(
        pdfUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            downloadProgress.value = received / total;
          }
        },
      );

      // Check if file exists
      if (File(filePath).existsSync()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File downloaded successfully!')),
        );

        // Open the downloaded file
        OpenFile.open(filePath);
      } else {
        throw Exception("File not saved correctly.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
  void dispose() {
    downloadProgress.dispose();
  }
}
