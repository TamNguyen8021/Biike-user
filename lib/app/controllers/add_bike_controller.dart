import 'package:bikes_user/app/common/functions/snackbar.dart';
import 'package:bikes_user/app/data/providers/bike_provider.dart';
import 'package:bikes_user/app/data/providers/image_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

class AddBikeController extends GetxController {
  Rx<String> plateNumber = ''.obs;
  Rx<String> bikeOwner = ''.obs;
  Rx<String> color = ''.obs;
  Rx<String> brand = ''.obs;
  Rx<String> category = ''.obs;
  Rx<String> volume = ''.obs;
  Rx<String> bikePicture = ''.obs;
  Rx<String> bikeLicensePicture = ''.obs;
  Rx<String> plateNumberPicture = ''.obs;

  bool isLoading = false;
  String errorMessage = '';

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }

  Future<void> addBike() async {
    if (!validate()) {
      return;
    }

    try {
      _enableLoading(true);

      dynamic bikePictureUrl = await ImageProvider().postImage('bikePicture', bikePicture.value);
      dynamic bikeLicensePictureUrl = await ImageProvider().postImage('bikeLicensePicture', bikeLicensePicture.value);
      dynamic plateNumberPictureUrl = await ImageProvider().postImage('plateNumberPicture', plateNumberPicture.value);

      Map<String, dynamic> data = <String, dynamic>{
        'userId': Biike.userId.value,
        'plateNumber': plateNumber.value,
        'bikeOwner': bikeOwner.value,
        'color': color.value,
        'brand': brand.value,
        'bikePicture': bikePictureUrl,
        'bikeLicensePicture': bikeLicensePictureUrl,
        'plateNumberPicture': plateNumberPictureUrl,
      };

      print(data);

      // bool result = await new BikeProvider().addBike(data);
      // if (result) {
      //   Get.back();
      //   SnackBarServices.showSnackbar(
      //       title: '', message: 'Đã thêm xe.\nVui lòng đợi Admin duyệt!');
      // } else {
      //   SnackBarServices.showSnackbar(title: '', message: 'Thêm xe thất bại!');
      // }
    } catch (error) {
      SnackBarServices.showSnackbar(title: '', message: 'Thêm xe thất bại!');
    } finally {
      _enableLoading(false);
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
