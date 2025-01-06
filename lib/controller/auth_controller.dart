import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxString verificationId = ''.obs;

  Future<void> verifyPhone(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        print(credential);
        await _auth.signInWithCredential(credential);
        Get.snackbar('Success', 'Logged in successfully!');
      },
      verificationFailed: (FirebaseAuthException e) {
        print("ooooooooooooooooo+$e");
        Get.snackbar('Error', e.message!);

      },
      codeSent: (String verId, int? resendToken) {
        verificationId.value = verId;
        Get.snackbar('Verification', 'Code sent to $phoneNumber');
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId.value = verId;
      },
    );
  }

  Future<void> signInWithOTP(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId.value,
      smsCode: otp,
    );
    await _auth.signInWithCredential(credential);
    Get.snackbar('Success', 'Logged in successfully!');
  }
}
