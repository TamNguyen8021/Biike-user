import 'package:bikes_user/app/data/models/bike.dart';
import 'package:bikes_user/app/data/providers/bike_provider.dart';
import 'package:get/get.dart';

/// Manage states for [ManageBikePage]
class ManageBikeController extends GetxController {
  final bikeProvider = Get.find<BikeProvider>();

  Rx<bool> hasBike = false.obs;
  Bike bike = Bike.empty();

  Future<void> getBike() async {
    dynamic response = await bikeProvider.getBike();
    if (response != null) {
      bike = Bike.fromJson(response);
      hasBike.value = true;
      update(['appbar']);
    }
  }
}
