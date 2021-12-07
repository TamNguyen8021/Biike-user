import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_dialog.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/image_type_enum.dart';
import 'package:bikes_user/app/data/providers/bike_provider.dart';
import 'package:bikes_user/app/data/providers/image_provider.dart'
    as imageProvider;
import 'package:bikes_user/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddBikeController extends GetxController {
  final _bikeProvider = Get.find<BikeProvider>();
  final _imageProvider = Get.find<imageProvider.ImageProvider>();

  Rx<String> plateNumber = ''.obs;
  Rx<String> bikeOwner = ''.obs;
  Rx<String> color = ''.obs;
  Rx<String> brand = ''.obs;
  Rx<String> category = ''.obs;
  Rx<String> volume = ''.obs;
  Rx<String> bikePicture = ''.obs;
  Rx<String> registrationPicture = ''.obs;
  Rx<String> numberPlatePicture = ''.obs;
  Rx<String> drivingLicenseBackPicture = ''.obs;
  Rx<String> drivingLicenseFrontPicture = ''.obs;
  Rx<int> bikeStatus = 1.obs;

  Future<bool> addBikeOrReplaceBike(
      {required bool isAddBike,
      required CustomDialog customDialog,
      required BuildContext context}) async {
    List<http.MultipartFile> imageList = [];
    imageList
        .add(await http.MultipartFile.fromPath('imageList', bikePicture.value));
    imageList.add(await http.MultipartFile.fromPath(
        'imageList', registrationPicture.value));
    imageList.add(await http.MultipartFile.fromPath(
        'imageList', numberPlatePicture.value));
    imageList.add(await http.MultipartFile.fromPath(
        'imageList', drivingLicenseBackPicture.value));
    imageList.add(await http.MultipartFile.fromPath(
        'imageList', drivingLicenseFrontPicture.value));

    ImageType bikeImage = ImageType.bike;

    var imageURLs = await _imageProvider
        .postImage(
            imageType: bikeImage.getImageTypeInt(bikeImage),
            imageList: imageList)
        .catchError((error) {
      CommonFunctions.catchExceptionError(error);
      customDialog.loadingDialog.dismiss();
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              headerAnimationLoop: false,
              desc: CustomErrorsString.kDevelopError.tr)
          .show();
    });

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
      'drivingLicenseBackPicture': imageURLs[3],
      'drivingLicenseFrontPicture': imageURLs[4]
    };

    if (isAddBike) {
      return await _bikeProvider.addBike(body: body);
    } else {
      return await _bikeProvider.replaceBike(body: body).catchError((error) {
        CommonFunctions.catchExceptionError(error);
        customDialog.loadingDialog.dismiss();
        AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                headerAnimationLoop: false,
                desc: CustomErrorsString.kDevelopError.tr)
            .show();
      });
    }
  }

  bool validate() {
    if (plateNumber.value.trim().isEmpty ||
        bikeOwner.value.trim().isEmpty ||
        color.value.trim().isEmpty ||
        brand.value.trim().isEmpty ||
        bikePicture.value.trim().isEmpty ||
        numberPlatePicture.value.trim().isEmpty ||
        registrationPicture.value.trim().isEmpty ||
        drivingLicenseBackPicture.value.trim().isEmpty ||
        drivingLicenseFrontPicture.value.trim().isEmpty) {
      Biike.logger.d(plateNumber.value);
      Biike.logger.d(bikeOwner.value);
      Biike.logger.d(color.value);
      Biike.logger.d(brand.value);
      Biike.logger.d(bikePicture.value);
      Biike.logger.d(numberPlatePicture.value);
      Biike.logger.d(registrationPicture.value);
      Biike.logger.d(drivingLicenseBackPicture.value);
      Biike.logger.d(drivingLicenseFrontPicture.value);
      return false;
    }

    return true;
  }
}
