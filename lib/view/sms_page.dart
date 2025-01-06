import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/sms_controller.dart';
class SmsPage extends StatefulWidget {
  const SmsPage({super.key});

  @override
  State<SmsPage> createState() => _SmsPageState();
}

class _SmsPageState extends State<SmsPage> {
  final SmsController controller = Get.put(SmsController());

  @override
  Widget build(BuildContext context) {
    controller.fetchSmsData("1", 0);

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
              "SMS",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25, color: Colors.brown),
            )),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.smsList.isEmpty) {
          return const Center(
            child: Text("No SMS Found"),
          );
        } else {
          return ListView.builder(
            itemCount: controller.smsList.length,
            itemBuilder: (context, index) {
              final sms = controller.smsList[index];
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.sms_failed,color: Colors.blue,),
                  title: Text(sms.label),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sms.description),
                      const SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            sms.date,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
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
      }),
    );
  }
}
