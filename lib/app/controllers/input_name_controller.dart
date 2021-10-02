import 'package:get/get.dart';

class InputNameController extends GetxController {
  Rx<String> fullname = ''.obs;

  void inputName(name) {
    fullname.value = name;
  }
}
