import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/update_mobile_number_controller.dart';

class UpdateMobileNumberPage extends StatefulWidget {
  const UpdateMobileNumberPage({super.key});

  @override
  State<UpdateMobileNumberPage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdateMobileNumberPage> {
  final UpdateMobileNumberController modUpdateController =
  Get.put(UpdateMobileNumberController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter new mobile number",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.025),
                    border: Border.all(width: 1, color: Colors.brown),
                  ),
                  child: Row(
                    children: [
                      CountryCodePicker(
                        onChanged: (country) {
                          modUpdateController.changeCountryCode(country.dialCode!);
                        },
                        initialSelection: 'المملكة العربية السعودية',
                        favorite: [
                          '+966',
                          'المملكة العربية السعودية',
                          '+91',
                          'India'
                        ],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                        showFlagMain: false,
                        showDropDownButton: true,
                        padding: EdgeInsets.zero,
                      ),
                      Expanded(
                        child: TextField(
                          controller: modUpdateController.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: 'Mobile number',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
                Center(
                  child: Text(
                    "OTP",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.05,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                        (index) => SizedBox(
                      width: width * 0.14,
                      height: height * 0.06,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: height * 0.005,
                          horizontal: width * 0.005,
                        ),
                        child: TextField(
                          controller: modUpdateController.otpControllers[index],
                          focusNode: modUpdateController.otpFocusNodes[index],
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) =>
                              modUpdateController.nextField(value, index),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Obx(() {
                    return modUpdateController.isLoading.value
                        ? const CircularProgressIndicator()
                        : InkWell(
                      onTap: () {
                        modUpdateController.updatePhoneNumber();
                      },
                      child: Container(
                        height: 45,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.brown,
                        ),
                        child: const Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
