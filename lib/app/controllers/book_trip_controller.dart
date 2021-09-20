import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:get/get.dart';

class BookTripController extends GetxController {
  Rx<String> dropdownFromValue = CustomStrings.kChooseFrom.tr.obs;
  Rx<String> dropdownToValue = CustomStrings.kChooseTo.tr.obs;

  void changeDropdownFromValue(value) {
    dropdownFromValue.value = value;
  }

  void changeDropdownToValue(value) {
    dropdownToValue.value = value;
  }
}
