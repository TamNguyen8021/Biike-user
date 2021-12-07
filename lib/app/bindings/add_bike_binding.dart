import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/add_bike_controller.dart';
import 'package:bikes_user/app/controllers/manage_bike_controller.dart';
import 'package:bikes_user/app/data/providers/bike_provider.dart';
import 'package:bikes_user/app/data/providers/image_provider.dart';
import 'package:get/get.dart';

class AddBikeBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(ImageProvider());
    CommonFunctions.bind(BikeProvider());
    CommonFunctions.bind(AddBikeController());
    CommonFunctions.bind(ManageBikeController());
  }
}
