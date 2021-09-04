import 'package:bikes_user/pages/manage_bike/view/manage_bike_page.dart';
import 'package:get/get.dart';

/// Manage states for [ManageBikePage]
class ManageBikeController extends GetxController {
  Rx<bool> hasBike = false.obs;

  void addBike() {
    hasBike.value = true;
  }

  void removeBike() {
    hasBike.value = false;
  }
}
