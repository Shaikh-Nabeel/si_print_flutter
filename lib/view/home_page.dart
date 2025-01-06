import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_print/controller/filter_pdf_controller.dart';
import 'package:si_print/controller/home_controller.dart';
import 'package:si_print/view/search_pdf.dart';
import '../controller/search_controller.dart';
import 'all_pdf_data.dart';
import 'filter_pdf_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? selectedDate;
  HomeController homeController = Get.put(HomeController());
  HomeController filterController = Get.put(HomeController());
  final SearchPdfController searchPdfController = Get.put(SearchPdfController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        return homeController.isPdfSearching.value
                            ? InkWell(
                          onTap: () {
                            // Fetch data on search
                            final searchText = searchPdfController.searchController.text.trim();
                            if (searchText.isNotEmpty) {
                              searchPdfController.fetchPdfs(searchText, 0);
                            }
                          },
                              child: TextField(
                                controller: searchPdfController.searchController,
                                  decoration: InputDecoration(
                                    hintText: "Search...",
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide:
                                          const BorderSide(color: Colors.blue),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: Colors.blue, width: 2.0),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.search,size: 30,),
                                      onPressed: () {
                                        // Fetch data on search
                                        final searchText = searchPdfController.searchController.text.trim();
                                        if (searchText.isNotEmpty) {
                                          searchPdfController.fetchPdfs(searchText, 0);
                                        }
                                      },
                                    ),
                                  ),
                                  onChanged: (value) {
                                    // Real-time search filtering
                                  },
                                ),
                            )
                            : const Row(
                                children: [
                                  Icon(Icons.image, size: 29),
                                  SizedBox(width: 5),
                                  Text(
                                    "SI PRINT",
                                    style: TextStyle(fontSize: 19),
                                  ),
                                ],
                              );
                      }),
                    ),
                    Obx(() {
                      // Show search icon only when not searching
                      return homeController.isPdfSearching.value
                          ? const SizedBox.shrink()
                          : IconButton(
                              icon: const Icon(Icons.search, size: 35),
                              onPressed: () {
                                homeController.isPdfSearching.value = true;
                              },
                            );
                    }),
                    IconButton(
                      icon: const Icon(Icons.upload, size: 35),
                      onPressed: homeController.uploadPdf,
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_alt_rounded, size: 35),
                      onPressed: () {
                        _showDatePickerDialog(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Obx(() {
                  if (homeController.isSearching.value) {
                    return  FilterPdfData();
                  } else if (homeController.isPdfSearching.value) {
                    return  SearchPdfScreen();
                  } else {
                    return  DashboardPage2();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(child: Text('Select Dates')),
        content: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 40,
                width: 140,
                child: TextField(
                  controller: filterController.startingDateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Starting Date',
                    hintText: "(dd-MM-yyyy)",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

            const SizedBox(width: 10),
            Container(
              height: 40,
              width: 140,
              child:  TextField(
                controller: filterController.endingDateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Ending Date',
                  hintText: "dd-MM-yyyy",

                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: InkWell(
              onTap: () {
                homeController.isSearching.value = true;
                filterController.setStartingDate(
                  filterController.startingDateController.text.trim(),
                );
                filterController.setEndingDate(
                  filterController.endingDateController.text.trim(),
                );
                filterController.fetchPDFs("${filterController.startingMilliseconds.value}","${filterController.endingMilliseconds.value}");
                Get.back();
              },
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.brown,
                ),
                child: const Center(
                  child: Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
