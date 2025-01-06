import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_print/view/update_mobile_number_page.dart';
import '../controller/update_conroller.dart';

class UpdateUserPage extends StatelessWidget {
  final UpdateUserController controller = Get.put(UpdateUserController());
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Obx(
            () =>
            Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Profile Image with Edit Icon
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: controller.profileImageUrl.value
                                .isNotEmpty
                                ? FileImage(File(controller.profileImageUrl
                                .value))
                                : AssetImage(
                                'assets/placeholder.png') as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => controller.pickImage(),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.grey[200],
                                child: Icon(
                                    Icons.edit, size: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.centerRight,
                        // Aligns the edit icon to the right
                        children: [
                          TextField(
                            controller: controller.phoneController,
                            keyboardType: TextInputType.phone,
                            readOnly: true, // Makes the TextField non-editable
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                              labelText: "Phone Number",
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.brown, width: 2),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                          ),
                          Positioned(
                            right: 12, // Adjust the position of the edit icon
                            child: GestureDetector(
                              onTap: () {
                                Get.to(UpdateMobileNumberPage());
                                print("Edit icon tapped");
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 380,
                        child: TextField(
                          controller: controller.nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Name",
                            labelText: "Name",
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.brown, width: 2),
                            ),
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Email TextField
                      Container(
                        width: 380,
                        child: TextField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Email",
                            labelText: "Email",
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.brown, width: 2),
                            ),
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Gender Dropdown
                      Container(
                        width: 380,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.brown, width: 1),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: selectedGender,
                          onChanged: (String? newValue) {
                            selectedGender = newValue;
                            controller.genderController.text = newValue ?? '';
                          },
                          decoration: InputDecoration(
                            labelText: "Gender",
                            hintText: "Select Gender",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            border: InputBorder.none,
                          ),
                          items: ['Male', 'Female', 'Other']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(height: 24),

                      // Update Button
                      Obx(() {
                        return controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : Container(
                            width: 380,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1),
                                color: Colors.brown),
                            child: Center(
                                child: InkWell(
                                    onTap: () {

  
                                      controller.updateUserDetails();
                                    },
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.white),
                                    ),
                                  )
                             ));
                      }),
                    ],
                  ),
                ),
                // Circular Progress Indicator
              ],
            ),
      ),
    );
  }
}
