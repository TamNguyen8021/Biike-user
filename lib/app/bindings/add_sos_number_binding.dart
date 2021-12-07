import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/add_sos_number_controller.dart';
import 'package:bikes_user/app/data/providers/sos_number_provider.dart';
import 'package:get/get.dart';

class AddSOSNumberBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(AddSOSNumberController());
    CommonFunctions.bind(SOSNumberProvider());
  }
}
