import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/top_biker_controller.dart';
import 'package:bikes_user/app/data/providers/top_biker_provider.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:get/get.dart';

/// Contains controllers and services for [TopBikerPage]
class TopBikerBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(TopBikerController());
    CommonFunctions.bind(TopBikerProvider());
    CommonFunctions.bind(UserProvider());
  }
}
