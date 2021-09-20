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
