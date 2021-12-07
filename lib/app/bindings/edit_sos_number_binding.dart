import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/edit_sos_number_controller.dart';
import 'package:bikes_user/app/data/providers/sos_number_provider.dart';
import 'package:get/get.dart';

class EditSOSNumberBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(EditSOSNumberController());
    CommonFunctions.bind(SOSNumberProvider());
  }
}
