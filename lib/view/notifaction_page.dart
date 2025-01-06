import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/notification_controller.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationsController controller = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Notification",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.brown),
        )),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          return const Center(child: Text("No notifications available",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),));
        }

        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.notifications_on_outlined),
                title: Text(
                  notification.title,
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.description,style: TextStyle(fontSize: 15),),
                    const SizedBox(height: 5),
                    // Text(
                    //   notification.date,
                    //   style: const TextStyle(fontSize: 12, color: Colors.grey),
                    // ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
