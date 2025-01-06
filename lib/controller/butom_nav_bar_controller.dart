import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;

  // Function to change the index
  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
