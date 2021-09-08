import 'package:bikes_user/utils/custom_strings.dart';
import 'package:get/get.dart';

class BookTripController extends GetxController {
  Rx<String> dropdownFromValue = CustomStrings.kChooseFrom.obs;
  Rx<String> dropdownToValue = CustomStrings.kChooseTo.obs;

  void changeDropdownFromValue(value) {
    dropdownFromValue.value = value;
  }

  void changeDropdownToValue(value) {
    dropdownToValue.value = value;
  }
}
