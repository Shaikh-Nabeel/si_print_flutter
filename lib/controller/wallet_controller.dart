import 'package:get/get.dart';

class WalletController extends GetxController {
  // Observable variable for selected option
  var selectedOption = "Wallet".obs;

  // Function to change the selected option and navigate to the respective screen
  void changeOption(String option) {
    selectedOption.value = option;

  }
}
