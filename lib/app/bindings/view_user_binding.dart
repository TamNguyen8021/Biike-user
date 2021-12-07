import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/view_user_controller.dart';
import 'package:bikes_user/app/data/providers/intimacies_provider.dart';
import 'package:bikes_user/app/data/providers/report_provider.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:get/get.dart';

class ViewUserBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(IntimaciesProvider());
    CommonFunctions.bind(ReportProvider());
    CommonFunctions.bind(ViewUserController());
    CommonFunctions.bind(UserProvider());
    CommonFunctions.bind(TripProvider());
  }
}
