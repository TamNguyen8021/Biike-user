import 'package:bikes_user/app/controllers/manage_bike_controller.dart';
import 'package:bikes_user/app/data/providers/bike_provider.dart';
import 'package:bikes_user/app/data/providers/image_provider.dart';
// import 'package:bikes_user/app/data/providers/image_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

class AddBikeController extends GetxController {
  final _bikeProvider = Get.find<BikeProvider>();
  final _imageProvider = Get.find<ImageProvider>();
  final _manageBikeController = Get.find<ManageBikeController>();

  Rx<String> plateNumber = ''.obs;
  Rx<String> bikeOwner = ''.obs;
  Rx<String> color = ''.obs;
  Rx<String> brand = ''.obs;
  Rx<String> category = ''.obs;
  Rx<String> volume = ''.obs;
  Rx<String> bikePicture = ''.obs;
  Rx<String> registrationPicture = ''.obs;
  Rx<String> numberPlatePicture = ''.obs;
  Rx<int> bikeStatus = 1.obs;

  bool isLoading = false;

  @override
  void onInit() {
    _manageBikeController.getBike();
    plateNumber = _manageBikeController.bike.plateNumber!.obs;
    bikeOwner = _manageBikeController.bike.bikeOwner!.obs;
    color = _manageBikeController.bike.color!.obs;
    brand = _manageBikeController.bike.brand!.obs;
    category = _manageBikeController.bike.bikeType!.obs;
    volume = _manageBikeController.bike.bikeVolume!.obs;
    bikePicture = _manageBikeController.bike.bikePicture!.obs;
    registrationPicture = _manageBikeController.bike.bikeLicensePicture!.obs;
    numberPlatePicture = _manageBikeController.bike.plateNumberPicture!.obs;
    bikeStatus = _manageBikeController.bike.bikeStatus!.obs;
    super.onInit();
  }

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }

  Future<bool> addBikeOrReplaceBike({required bool isAddBike}) async {
    // try {
    // _enableLoading(true);

    String bikePictureUrl = await _imageProvider.postImage(
        imageType: 1,
        imageName:
            bikePicture.value.substring(bikePicture.value.lastIndexOf('/') + 1),
        imagePath: bikePicture.value);
    String bikeLicensePictureUrl = await _imageProvider.postImage(
        imageType: 1,
        imageName: registrationPicture.value
            .substring(registrationPicture.value.lastIndexOf('/') + 1),
        imagePath: registrationPicture.value);
    String plateNumberPictureUrl = await _imageProvider.postImage(
        imageType: 1,
        imageName: numberPlatePicture.value
            .substring(numberPlatePicture.value.lastIndexOf('/') + 1),
        imagePath: numberPlatePicture.value);

    Map<String, dynamic> body = {
      'userId': Biike.userId.value,
      'plateNumber': plateNumber.value,
      'bikeOwner': bikeOwner.value,
      'color': color.value,
      'brand': brand.value,
      'bikeType': category.value,
      'bikeVolume': volume.value,
      'bikePicture': bikePictureUrl,
      'bikeLicensePicture': bikeLicensePictureUrl,
      'plateNumberPicture': plateNumberPictureUrl,
    };

    if (isAddBike) {
      return await _bikeProvider.addBike(body: body);
    } else {
      return await _bikeProvider.replaceBike(body: body);
    }
    // } catch (e) {
    //   _enableLoading(false);
    //   Biike.logger.e('AddBikeController - addBikeOrReplaceBike(): ' + e.toString());
    // }

    // if (result) {
    //   Get.back();
    //   SnackBarServices.showSnackbar(
    //       title: '', message: 'Đã thêm xe.\nVui lòng đợi Admin duyệt!');
    // } else {
    //   SnackBarServices.showSnackbar(title: '', message: 'Thêm xe thất bại!');
    // }
    // } catch (error) {
    //   SnackBarServices.showSnackbar(title: '', message: 'Thêm xe thất bại!');
    // } finally {
    //   _enableLoading(false);
    // }
  }

  /// Edit bike's info
  ///
  /// Author: TamNTT
  // Future<bool> replaceBike() async {
  //   // _enableLoading(true);

  //   // String bikePictureUrl = await _imageProvider.postImage(
  //   //     imageType: 1, imageName: 'bikePicture', imagePath: bikePicture.value);
  //   // Biike.logger.d(bikePictureUrl);
  //   // String bikeLicensePictureUrl = await _imageProvider.postImage(
  //   //     imageType: 1,
  //   //     imageName: 'bikeLicensePicture',
  //   //     imagePath: registrationPicture.value);
  //   // Biike.logger.d(bikeLicensePictureUrl);
  //   // String plateNumberPictureUrl = await _imageProvider.postImage(
  //   //     imageType: 1,
  //   //     imageName: 'plateNumberPicture',
  //   //     imagePath: numberPlatePicture.value);
  //   // Biike.logger.d(plateNumberPictureUrl);

  //   Map<String, dynamic> body = {
  //     'userId': Biike.userId.value,
  //     'bikeOwner': bikeOwner.value,
  //     'brand': brand.value,
  //     'color': color.value,
  //     'plateNumber': plateNumber.value,
  //     'bikeLicensePicture': 'link',
  //     'bikePicture': 'link',
  //     'plateNumberPicture': 'link',
  //   };

  //   return await _bikeProvider.replaceBike(body: body);
  // }

  bool validate() {
    if (plateNumber.value.trim().isEmpty ||
        bikeOwner.value.trim().isEmpty ||
        color.value.trim().isEmpty ||
        brand.value.trim().isEmpty) {
      return false;
    }

    return true;
  }
}
