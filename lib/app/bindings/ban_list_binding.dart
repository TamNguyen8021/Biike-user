import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/ban_list_controller.dart';
import 'package:get/get.dart';

class BanListBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(BanListController());
  }
}
