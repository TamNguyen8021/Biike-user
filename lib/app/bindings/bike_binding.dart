import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/data/providers/bike_provider.dart';
import 'package:get/get.dart';

class BikeBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(BikeProvider());
  }
}
