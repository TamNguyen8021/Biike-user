import 'package:bikes_user/app/data/providers/sos_number_provider.dart';
import 'package:get/get.dart';

class AddSOSNumberController extends GetxController {
  final _sosProvider = Get.find<SOSNumberProvider>();

  Rx<String> name = ''.obs;
  Rx<String> number =''.obs;

  bool isLoading = false;

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }

  Future<bool> addSOSNumber() async {
    _enableLoading(true);

    Map<String, dynamic> body = {
      'sosName': name.value,
      'sosPhone': number.value
    };

    return await _sosProvider.addSOSNumber(body: body);
  }

  bool validate() {
    if (name.value.trim().isEmpty || number.value.trim().isEmpty) {
      return false;
    }

    return true;
  }
}
