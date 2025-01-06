import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class DashboardView extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final user = controller.userData.value;
        if (user == null) {
          return Center(child: Text("No user data available"));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Data Section
              Text(
                "User Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text("Name: ${user.name}"),
              Text("Email: ${user.email}"),
              Text("Phone: ${user.phone}"),
              Text("Credits: ${user.credits}"),
              SizedBox(height: 16),

              // Invoices Section
              Text(
                "Invoices",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.invoices.length,
                itemBuilder: (context, index) {
                  final invoice = controller.invoices[index];
                  return Card(
                    child: ListTile(
                      title: Text("Description: ${invoice.description}"),
                      subtitle: Text("Date: ${invoice.date}"),
                      trailing: IconButton(
                        icon: Icon(Icons.download),
                        onPressed: () {
                          // Handle file download or opening
                          Get.snackbar("File", "Downloading ${invoice.file}");
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
