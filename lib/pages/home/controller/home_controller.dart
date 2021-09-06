import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<bool> isAppBarVisible = true.obs;

  /// Show/hide appbar depends on [isVisible]
  ///
  /// Author: TamNTT
  void setAppBarVisible(isVisible) {
    isAppBarVisible.value = isVisible;
  }
}
