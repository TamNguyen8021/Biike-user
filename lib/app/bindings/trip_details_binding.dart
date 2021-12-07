import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/data/providers/pathshare_provider.dart';
import 'package:bikes_user/app/data/providers/station_provider.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:get/get.dart';

class TripDetailsBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(TripDetailsController());
    CommonFunctions.bind(TripProvider());
    CommonFunctions.bind(HomeController());
    CommonFunctions.bind(ProfileController());
    CommonFunctions.bind(UserProvider());
    CommonFunctions.bind(StationProvider());
    CommonFunctions.bind(PathshareProvider());
  }
}
