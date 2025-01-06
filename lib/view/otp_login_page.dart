// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controller/auth_controller.dart';
//
// class LoginPage2 extends StatefulWidget {
//   @override
//   State<LoginPage2> createState() => _LoginPage2State();
// }
//
// class _LoginPage2State extends State<LoginPage2> {
//   final AuthController authController = Get.put(AuthController());
//   bool isOTPVisible = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextField(
//               controller:authController.phoneController,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//             ),
//             if (isOTPVisible) ...[
//               TextField(
//                 controller: authController.otpController,
//                 decoration: InputDecoration(labelText: 'OTP'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   authController.signInWithOTP(authController.otpController.text);
//                 },
//                 child: Text('Verify OTP'),
//               ),
//             ],
//             ElevatedButton(
//               onPressed: () {
//                 authController.verifyPhone(authController.phoneController.text);
//                 isOTPVisible = true; // Show OTP input
//               },
//               child: Text('Send OTP'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
