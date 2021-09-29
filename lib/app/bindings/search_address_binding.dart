import 'package:bikes_user/app/controllers/search_address_controller.dart';
import 'package:get/get.dart';

class SearchAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchAddressController());
  }
}