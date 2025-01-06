import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_print/controller/registration_controller.dart';

import 'buttom_nav_bar_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  RegistrationController resController = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme
            .of(context)
            .primaryColor),
        leading: Icon(Icons.arrow_back),
        title: const Text(
          'Create Account',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: resController.formKey, // Use the formKey from the controller
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profile Image Container
                Obx(() {
                  return Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200,
                              border: Border.all(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                width: 2,
                              ),
                            ),
                            child: resController.photoPath.value.isEmpty
                                ? const Icon(Icons.person) // Show default icon if no image is selected
                                : ClipOval(
                              child: Image.file(
                                File(resController.photoPath.value),
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ),
                            ), // Show selected image
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  // User can dismiss by tapping outside
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      title: Text('Select Image'),
                                      content: Text(
                                          'Choose an option to pick an image from the gallery or camera.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Select from Gallery'),
                                          onPressed: () async {
                                            Navigator.of(dialogContext)
                                                .pop(); // Close the dialog
                                            await resController
                                                .pickImageFromGallery(); // Pick image from gallery
                                          },
                                        ),
                                        // TextButton(
                                        //   child: Text('Capture with Camera'),
                                        //   onPressed: () async {
                                        //     Navigator.of(dialogContext)
                                        //         .pop(); // Close the dialog
                                        //     await resController.pickImageFromCamera(); // Capture image from camera
                                        //   },
                                        // ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )

                  );
                }),

                const SizedBox(height: 20),

                // Form Fields
                TextFormField(
                  controller: resController.idController,
                  decoration: _buildInputDecoration('ID', Icons.perm_identity),
                  validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your ID' : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: resController.nameController,
                  decoration: _buildInputDecoration('Full Name', Icons.person),
                  validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: resController.emailController,
                  decoration: _buildInputDecoration('Email', Icons.email),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                  !value!.contains('@') ? 'Please enter a valid email' : null,
                ),
                const SizedBox(height: 16),
                Obx(() {
                  return DropdownButtonFormField<String>(
                    value: resController.genderController.value.isEmpty
                        ? null
                        : resController.genderController.value,
                    decoration: _buildInputDecoration('Gender', Icons.wc),
                    items: ['MALE', 'FEMALE']
                        .map(
                          (gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        resController.genderController.value = value;
                      }
                    },
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please select your gender' : null,
                  );
                }),                const SizedBox(height: 16),
                TextFormField(
                  controller: resController.passwordController,
                  decoration: _buildInputDecoration('Password', Icons.lock),
                  obscureText: true,
                  validator: (value) =>
                  (value?.length ?? 0) < 8
                      ? 'Password must be at least 8 characters'
                      : null,
                ),
                const SizedBox(height: 30),
                // Register Button
                ElevatedButton(
                  onPressed: () async {
                    if (resController.formKey.currentState!.validate()) {
                      resController.registerUser();
                   resController.clearForm();

                    }

                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme
                        .of(context)
                        .primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Register Yourself',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Theme
          .of(context)
          .primaryColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Theme
            .of(context)
            .primaryColor, width: 2),
      ),
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }

}
