import 'package:get/get.dart';

class InputPhoneController extends GetxController {
  Rx<String> phoneNo = ''.obs;

  void inputPhoneNo(newPhoneNo) {
    phoneNo.value = newPhoneNo;
  }
}
