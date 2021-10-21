import 'package:bikes_user/app/common/functions/snackbar.dart';
import 'package:bikes_user/app/data/models/bike.dart';
import 'package:bikes_user/app/data/providers/bike_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

/// Manage states for [ManageBikePage]
class ManageBikeController extends GetxController {
  Rx<bool> hasBike = false.obs;
  Rx<Bike> bike = Bike(-1, -1, '', '', '', '', false).obs;

  Future<void> getBike() async {
    dynamic response = await BikeProvider().getBike(Biike.userId);
    if (response != null) {
      try {
        bike.value = Bike.fromJson(response);
        hasBike.value = true;
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> removeBike() async {
    bool result = await BikeProvider().removeBike(Biike.userId);
    if (result) {
      hasBike.value = false;
      SnackBarServices.showSnackbar(title: '', message: 'Xoá thành công!');
    } else {
      SnackBarServices.showSnackbar(title: '', message: 'Xoá thất bại!');
    }
  }
}
