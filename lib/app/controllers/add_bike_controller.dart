import 'package:bikes_user/app/common/functions/snackbar.dart';
import 'package:bikes_user/app/data/providers/bike_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

class AddBikeController extends GetxController {
  Rx<String> plateNumber = ''.obs;
  Rx<String> bikeOwner = ''.obs;
  Rx<String> picture = ''.obs;
  Rx<String> color = ''.obs;
  Rx<String> brand = ''.obs;

  String errorMessage = '';

  Future<void> addBike() async {
    if (!validate()) {
      return;
    }

    picture.value = 'pic:url';

    Map<String, dynamic> data = <String, dynamic>{
      'userId': Biike.userId.value,
      'plateNumber': plateNumber.value,
      'bikeOwner': bikeOwner.value,
      'picture': picture.value,
      'color': color.value,
      'brand': brand.value,
    };

    bool result = await new BikeProvider().addBike(data);
    if (result) {
      Get.back();
      SnackBarServices.showSnackbar(
          title: '', message: 'Đã thêm xe.\nVui lòng đợi Admin duyệt!');
    } else {
      SnackBarServices.showSnackbar(title: '', message: 'Thêm xe thất bại!');
    }
  }

  bool validate() {
    String error = _validate();
    if (error.isNotEmpty) {
      errorMessage = error;
      update();
      return false;
    } else {
      errorMessage = '';
      update();
      return true;
    }
  }

  String _validate() {
    if (plateNumber.value.replaceAll(" ", "").isEmpty ||
        bikeOwner.value.replaceAll(" ", "").isEmpty ||
        color.value.replaceAll(" ", "").isEmpty ||
        brand.value.replaceAll(" ", "").isEmpty) {
      return 'Not null';
    }

    return '';
  }
}
