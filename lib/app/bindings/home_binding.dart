import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/data/providers/station_provider.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(HomeController());
    CommonFunctions.bind(TripProvider());
    CommonFunctions.bind(StationProvider());
  }
}
