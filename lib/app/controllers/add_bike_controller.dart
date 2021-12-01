import 'dart:io';

import 'package:bikes_user/app/controllers/manage_bike_controller.dart';
import 'package:bikes_user/app/data/providers/bike_provider.dart';
import 'package:bikes_user/app/data/providers/image_provider.dart';
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
    _enableLoading(true);

    List<MultipartFile> imageList = [];
    imageList.add(await createMultipartFile(bikePicture.value,
        bikePicture.value.substring(bikePicture.value.lastIndexOf('/') + 1)));
    imageList.add(await createMultipartFile(registrationPicture.value,
        registrationPicture.value.substring(registrationPicture.value.lastIndexOf('/') + 1)));
    imageList.add(await createMultipartFile(numberPlatePicture.value,
        numberPlatePicture.value.substring(numberPlatePicture.value.lastIndexOf('/') + 1)));

    dynamic imageURLs = await _imageProvider.postImage(imageType: 1,
        imageList: [bikePicture.value, registrationPicture.value, numberPlatePicture.value]);

    Map<String, dynamic> body = {
      'userId': Biike.userId.value,
      'plateNumber': plateNumber.value,
      'bikeOwner': bikeOwner.value,
      'color': color.value,
      'brand': brand.value,
      'bikeType': category.value,
      'bikeVolume': volume.value,
      'bikePicture': imageURLs[0],
      'bikeLicensePicture': imageURLs[1],
      'plateNumberPicture': imageURLs[2],
    };

    if (isAddBike) {
      return await _bikeProvider.addBike(body: body);
    } else {
      return await _bikeProvider.replaceBike(body: body);
    }
  }

  bool validate() {
    if (plateNumber.value.trim().isEmpty ||
        bikeOwner.value.trim().isEmpty ||
        color.value.trim().isEmpty ||
        brand.value.trim().isEmpty ||
        bikePicture.value.trim().isEmpty ||
        numberPlatePicture.value.trim().isEmpty ||
        registrationPicture.value.trim().isEmpty) {
      return false;
    }

    return true;
  }

  Future<MultipartFile> createMultipartFile(imagePath, imageName) async {
    final File imageFile = File(imagePath);

    if (await imageFile.exists()) {
    // Use the cached images if it exists
    } else {
    // Image doesn't exist in cache
      await imageFile.create(recursive: true);
    }

    return MultipartFile(imageFile, filename: imageName);
  }
}
