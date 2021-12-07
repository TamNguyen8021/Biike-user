import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/data/providers/station_provider.dart';
import 'package:get/get.dart';

class StationBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(StationProvider());
  }
}
