import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../controller/show_pdf_controler.dart';
import '../model/show_pdf_model.dart';


class DashboardPage2 extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage2> {
  final ShowPdfController controller = Get.put(ShowPdfController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Listen to scroll events
    scrollController.addListener(() {
      controller.onScrollEvent(scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          // if (controller.isLoading.value && controller.invoices.isEmpty) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          if (controller.invoices.value == null) {
            return const Center(
              child: Text("No user data available"),
            );
          }
          else {
            return Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  color: Colors.yellow,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Recent uploads',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                // Integrating DashboardPage
                TableHeader(),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController, // Attach the ScrollController
                    itemCount: controller.invoices.length + 1, // Extra item for loading indicator
                    itemBuilder: (context, index) {
                      if (index < controller.invoices.length) {
                        final invoice = controller.invoices[index];
                        return InkWell(
                          onTap: (){
                            print(controller.getUserId());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.picture_as_pdf,color: Colors.red,),
                                          Text(
                                            controller.getFormattedDate(invoice.date!),
                                            style: TextStyle(color: Colors.grey[700]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        invoice.label!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.grey[700]),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:height*0.040,
                                        child: Text(
                                          controller.getFileName(invoice.file!),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.grey[700]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width:width*0.060,),
                                //
                                SizedBox(
                                  child: Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: InkWell(
                                        onTap: () {
                                           showFileDetailsDialog(context, invoice);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.brown,
                                            borderRadius: BorderRadius.circular(40),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 7,
                                                width: 7,
                                                decoration: BoxDecoration(
                                                  color:
                                                  Colors.white, // White color for the small circles
                                                  borderRadius:
                                                  BorderRadius.circular(40), // Circular shape
                                                ),
                                              ),
                                              Container(
                                                height: 7,
                                                width: 7,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(40),
                                                ),
                                              ),
                                              Container(
                                                height: 7,
                                                width: 7,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(40),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ),
                        );
                      } else if (controller.isMoreDataAvailable.value) {
                        // Show loading indicator at the bottom
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const SizedBox.shrink(); // Empty widget if no more data
                      }
                    },
                  ),
                ),
                const SizedBox(height: 90,)
              ],
            );
          }
        }),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
class TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.amber[100],
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child:  Row(
        children: [
          const Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width:width*0.18,
          ),
          const Text('Label', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width:width*0.18,
          ),
          const Text('Documents', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width:width*0.18,
          ),
          const Text('Share', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

}
void showFileDetailsDialog(BuildContext context,  Invoice invoice,) {
  //share on whatsapp and many more
  final String fileLink =(invoice.file!);
 // download function
  double downloadProgress = 0.0;

  String getFileName(String path) {
    return path.split('/').last;
  }
  Future<void> downloadAndSavePdf() async {
    print("fileName======${getFileName(fileLink)}fileName}");
    try {
      // Get the directory to save the file
      final directory = await getExternalStorageDirectory(); // External storage directory
      if (directory == null) {
        throw Exception("Could not find storage directory.");
      }

      final filePath = '${directory.path}/Download/${getFileName(fileLink)}';
      print(filePath);
      // Download the PDF with progress
      final dio = Dio();
      await dio.download(
        fileLink,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {

              downloadProgress = received / total;

          }
        },
      );

      // Check if file exists
      if (File(filePath).existsSync()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File downloaded successfully!')),
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

  showDialog(
    context: context,
    builder: (BuildContext context) {
      String getFileName(String path) {
        return path.split('/').last;
      }

      String getFormattedDate(String dateTime) {
        return dateTime.split(' ').first;
      }
      return AlertDialog(
        backgroundColor: Colors.grey[200], // Light background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: InkWell(
          onTap: (){
            print(getFileName(invoice.file!));
          },
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.insert_drive_file,
                      color: Colors.brown,
                      size: 40,
                    ),
                    const SizedBox(width: 10),

                    Expanded(
                      child:  Text(
                        getFileName(invoice.file!),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [

                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date:",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500,color: Colors.grey),),

                        Text("Label:",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500,color: Colors.grey),),
                        Text("Description:",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500,color: Colors.grey),),
                        Text("Upload by:",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500,color: Colors.grey),),
                      ],
                    ),
                    const SizedBox(width: 50,),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getFormattedDate(invoice.date!),
                          style: const TextStyle(fontSize: 16,fontWeight:FontWeight.w500,),
                        ),
                        Text(
                          invoice.label!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16,fontWeight:FontWeight.w500,),
                        ),
                        const Text("SELF",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500,),),
                        const Text("SELF",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500,),),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Edit action
                      },
                      label: const Text("EDIT"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    ElevatedButton.icon(
                      onPressed: () {
                        Share.share('Check out this file: $fileLink');
                      },
                      label: const Text("SHARE"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    ElevatedButton.icon(
                      onPressed: () {
                        downloadAndSavePdf();
                      },
                      label: const Text("DOWNLOAD"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ),
        ),
      );
    },
  );
}


