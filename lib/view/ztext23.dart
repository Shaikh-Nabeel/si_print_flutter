import 'package:flutter/material.dart';
import '../controller/pdf_download_conroller.dart';

class PdfDownloaderPage extends StatelessWidget {
  final PdfDownloaderController controller = PdfDownloaderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download and Open PDF'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => controller.downloadAndSavePdf(context, "https://si-sms.net/api/InvoiceUploads/resume_6752ca23d10e5.pdf",
              ),
              child: Text('Download and Save PDF'),
            ),
            SizedBox(height: 20),
            ValueListenableBuilder<double>(
              valueListenable: controller.downloadProgress,
              builder: (context, progress, child) {
                if (progress > 0 && progress < 1) {
                  return Column(
                    children: [
                      Text('Downloading: ${(progress * 100).toStringAsFixed(0)}%'),
                      SizedBox(height: 10),
                      LinearProgressIndicator(value: progress),
                    ],
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
