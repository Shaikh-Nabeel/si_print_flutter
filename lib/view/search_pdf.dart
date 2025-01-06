import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../controller/search_controller.dart';
import 'all_pdf_data.dart';

class SearchPdfScreen extends StatelessWidget {
  final SearchPdfController searchPdfController = Get.put(SearchPdfController());
  HomeController homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              color: Colors.yellow,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Search Result",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                      ),
                      InkWell(
                        onTap: () {

                          homeController.isPdfSearching.value = false;
                        },
                        child: const Icon(Icons.clear, size: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TableHeader(),
            Expanded(
              child: Obx(() {
                if (searchPdfController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (searchPdfController.errorMessage.isNotEmpty) {
                  return Center(
                      child: Text(
                          "Error: ${searchPdfController.errorMessage}"));
                } else if (searchPdfController.pdfList.isEmpty) {
                  return Center(child: Text("No PDFs found."));
                } else {
                  return ListView.builder(
                    itemCount: searchPdfController.pdfList.length,
                    itemBuilder: (context, index) {
                      final pdf = searchPdfController.pdfList[index];
                      return Container(
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
                                      Icon(Icons.picture_as_pdf,color: Colors.red,),
                                      Text(
                                        searchPdfController.getFormattedDate(pdf.date),
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
                                    pdf.label,
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
                                      searchPdfController.getFileName(pdf.file),
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
                                       showFileDetailsDialog(context, pdf);
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
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
void showFileDetailsDialog(BuildContext context,  pdf,) {
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
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.insert_drive_file,
                    color: Colors.brown,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child:  Text(
                      getFileName(pdf.file),
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
                  Column(
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
                        getFormattedDate(pdf.date),
                        style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500,),
                      ),
                      Text(
                        pdf.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500,),
                      ),
                      const Text("SELF",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500,),),
                      const Text("SELF",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500,),),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Edit action
                    },
                    label: Text("EDIT"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Share action
                    },
                    label: Text("SHARE"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Download action
                    },
                    label: Text("DOWNLOAD"),
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
      );
    },
  );
}
