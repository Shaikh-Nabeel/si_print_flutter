import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_print/controller/filter_pdf_controller.dart';

import '../controller/home_controller.dart';

class DateRangeInputPage extends StatelessWidget {
  final HomeController filterController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 180,
              child: TextField(
                controller: filterController.startingDateController,
                decoration: InputDecoration(
                  labelText: 'Starting Date (dd-MM-yyyy)',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                try {
                  filterController.setStartingDate(
                    filterController.startingDateController.text.trim(),
                  );
                } catch (e) {
                  Get.snackbar(
                    "Error",
                    e.toString(),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                }
              },
              child: Text('Set Starting Date'),
            ),
            Obx(() => Text(
              "Starting Date in Milliseconds: ${filterController.startingMilliseconds.value}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
            SizedBox(height: 32),
            TextField(
              controller: filterController.endingDateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ending Date (dd-MM-yyyy)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                try {
                  filterController.setEndingDate(
                    filterController.endingDateController.text.trim(),
                  );
                } catch (e) {
                  Get.snackbar(
                    "Error",
                    e.toString(),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                }
              },
              child: Text('Set Ending Date'),
            ),
            Obx(() => Text(
              "${filterController.endingDateController.text} Date in Milliseconds: ${filterController.endingMilliseconds.value}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: filterController.clearDates,
              child: Text('Clear Dates'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
