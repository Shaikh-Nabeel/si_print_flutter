import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import 'package:share_plus/share_plus.dart';


class FilterPdfData extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<FilterPdfData> {
  final HomeController filterController = Get.put(HomeController());
  final ScrollController scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    // Listen to scroll events
    scrollController.addListener(() {
      filterController.onScrollEvent(scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (filterController.isLoading.value && filterController.pdfList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
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
                              "${filterController.startingDateController.text} to ${filterController.endingDateController.text}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                          InkWell(
                            onTap: () {
                              filterController.isSearching.value = false;
                            },
                            child: const Icon(Icons.clear, size: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Integrating DashboardPage
                TableHeader(),
                Expanded(
                  child: Obx(() {
                    if (filterController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (filterController.errorMessage.isNotEmpty) {
                      return Center(child: Text("Error: ${filterController.errorMessage}"));
                    } else if (filterController.pdfList.isEmpty) {
                      return Center(child: Text("No PDFs found."));
                    } else {
                      return ListView.builder(
                        itemCount: filterController.pdfList.length,
                        itemBuilder: (context, index) {
                          final pdf = filterController.pdfList[index];
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
                                            filterController.getFormattedDate(pdf.date),
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
                                          filterController.getFileName(pdf.file),
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
                SizedBox(height: 80,)
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
          Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width:width*0.18,
          ),
          Text('Label', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width:width*0.18,
          ),
          Text('Documents', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width:width*0.18,
          ),
          Text('Share', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

}
void showFileDetailsDialog(BuildContext context,  pdf,) {
  final String fileLink = "https://si-sms.net/api/InvoiceUploads/UNIT_4_AI_67555d94bc7f3.pdf"; // Replace with your file link

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
                      Share.share('Checkout this file: $fileLink');
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


