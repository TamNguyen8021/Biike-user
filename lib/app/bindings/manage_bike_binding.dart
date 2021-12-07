import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/manage_bike_controller.dart';
import 'package:bikes_user/app/data/providers/bike_provider.dart';
import 'package:get/get.dart';

/// Contains controllers and services for [ManageBikePage]
class ManageBikeBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(ManageBikeController());
    CommonFunctions.bind(BikeProvider());
  }
}
