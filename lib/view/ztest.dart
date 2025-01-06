import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/credit_controller.dart';

class CreditView extends StatelessWidget {
  final CreditController controller = Get.put(CreditController());

  CreditView() {
    // Fetch data when the page is called
    controller.fetchCredits();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.creditData.isEmpty) {
        return Center(child: Text('No data available'));
      }

      return ListView.builder(
        itemCount: controller.creditData.length,
        itemBuilder: (context, index) {
          final item = controller.creditData[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 8),
                    Text(
                      'Added Limit: ${item['added_limit']}',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Used Limit: ${item['used_limit']}',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Date: ${item['date']}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
