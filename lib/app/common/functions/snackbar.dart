import 'package:get/get.dart';

class SnackBarServices {
  static void showSnackbar({required String title, required String message}) {
    Get.snackbar(title, message,);
  }
}
