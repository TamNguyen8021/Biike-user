import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<bool> isAppBarVisible = true.obs;
  Rx<bool> isAtDestination = false.obs;

  void setAppBarVisible(isVisible) {
    isAppBarVisible.value = isVisible;
  }

  void setAtDestination() {
    isAtDestination.value = !isAtDestination.value;
  }
}
