import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_dialog.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/add_bike_controller.dart';
import 'package:bikes_user/app/controllers/manage_bike_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/camera_button.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/bike_dropdown_field.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/bike_text_field.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/image_file_container.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'add_bike' screen
//ignore: must_be_immutable
class AddBikePage extends StatelessWidget {
  final _addBikeController = Get.find<AddBikeController>();
  final _manageBikeController = Get.find<ManageBikeController>();

  RxList<String> brands = [
    'Aprilia', 'Bazan', 'Benelli', 'BMW', 'Brixton', 'CR&S', 'Daelim', 'Detech', 'Ducati',
    'Euro Reibel', 'GPX', 'Halim', 'Harley Davidson', 'Honda', 'Hyosung', 'Kawasaki', 'Keeway', 'Kengo', 'KTM',
    'Kymco', 'Lambretta', 'Malaguti', 'Moto Guzzi', 'MV Agusta', 'Nioshima', 'Norton', 'Peugeot', 'Piaggio', 'RebelUSA',
    'Regal Raptor', 'Royal Enfield', 'Sachs', 'Sanda', 'Suzuki', 'SYM', 'Taya', 'Triumph', 'Vento', 'Victory',
    'Visitor', 'Yamaha', 'Hãng khác'
  ].obs;
  RxList<String> categories = ['Xe số', 'Tay ga', 'Tay côn/Moto'].obs;
  RxList<String> volumes = ['Dưới 50cc', '50 - 100cc', '100 - 175cc', 'Trên 175cc'].obs;

  bool isAddBike = Get.arguments['isAddBike'];
  String fromPage = Get.arguments['from'];

  AddBikePage({Key? key}) : super(key: key);

  Future<void> _onBackPressed() async {
    // await _manageBikeController.getBike();

    if (fromPage == 'requireAddBike') {
      Biike.role.value = Role.keer;
      Biike.localAppData.saveRole(Biike.role.value);
      Get.offAllNamed(CommonRoutes.HOME);
    } else {
      _manageBikeController.update();
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isAddBike) {
      _addBikeController.brand.value = brands.first;
      _addBikeController.volume.value = volumes.first;
      _addBikeController.category.value = categories.first;
    } else {
      _addBikeController.plateNumber.value =
          _manageBikeController.bike.plateNumber!;
      _addBikeController.bikeOwner.value =
          _manageBikeController.bike.bikeOwner!;
      _addBikeController.color.value = _manageBikeController.bike.color!;
      _addBikeController.brand.value = _manageBikeController.bike.brand!;
      _addBikeController.category.value = _manageBikeController.bike.bikeType!;
      _addBikeController.volume.value = _manageBikeController.bike.bikeVolume!;
      _addBikeController.bikePicture.value =
          _manageBikeController.bike.bikePicture!;
      _addBikeController.registrationPicture.value =
          _manageBikeController.bike.bikeLicensePicture!;
      _addBikeController.numberPlatePicture.value =
          _manageBikeController.bike.plateNumberPicture!;
      _addBikeController.drivingLicenseBackPicture.value =
          _manageBikeController.bike.drivingLicenseBackPicture!;
      _addBikeController.drivingLicenseFrontPicture.value =
          _manageBikeController.bike.drivingLicenseFrontPicture!;
      _addBikeController.bikeStatus.value =
          _manageBikeController.bike.bikeStatus!;
    }

    return OnBackPressed(
      perform: () {
        _onBackPressed();
      },
      child: Scaffold(
          appBar: CustomAppBar(
            appBar: AppBar(),
            hasShape: true,
            hasLeading: true,
            onPressedFunc: () {
              _onBackPressed();
            },
            title: Text(
              isAddBike
                  ? CustomStrings.kAddBike.tr
                  : CustomStrings.kChangeBike.tr,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Form(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            CustomStrings.kPleaseEnterCorrectBikeInfo.tr,
                            style: TextStyle(color: CustomColors.kBlue),
                          ),
                        ),
                        Text(CustomStrings.kBikeOwner.tr),
                        BikeTextField(
                          hintText: CustomStrings.kEnterBikeOwner.tr,
                          isReadOnly: false,
                          isEditSOSNumber: true,
                          initialValue:
                              '${_manageBikeController.bike.bikeOwner}',
                          onChangedFunc: (value) {
                            _addBikeController.bikeOwner.value = value;
                          },
                        ),
                        Text(CustomStrings.kBikeBrand.tr),
                        Obx(
                          () => BikeDropdownField(
                            hintText: CustomStrings.kEnterBrand.tr,
                            items: brands.toList(),
                            defaultValue: _manageBikeController.bike.brand!
                                    .trim()
                                    .isNotEmpty
                                ? _manageBikeController.bike.brand.obs.value!
                                : _addBikeController.brand.value,
                            onChangedFunc: (value) {
                              _addBikeController.brand.value = value;
                            },
                          ),
                        ),
                        Text(CustomStrings.kBikeColor.tr),
                        BikeTextField(
                          hintText: CustomStrings.kEnterColor.tr,
                          isReadOnly: false,
                          isEditSOSNumber: true,
                          initialValue: '${_manageBikeController.bike.color}',
                          onChangedFunc: (value) {
                            _addBikeController.color.value = value;
                          },
                        ),
                        Text(CustomStrings.kBikeCategory.tr),
                        Obx(
                          () => BikeDropdownField(
                            hintText: CustomStrings.kEnterCategory.tr,
                            items: categories.toList(),
                            defaultValue: _manageBikeController.bike.bikeType!
                                    .trim()
                                    .isNotEmpty
                                ? _manageBikeController.bike.bikeType.obs.value!
                                : _addBikeController.category.value,
                            onChangedFunc: (value) {
                              _addBikeController.category.value = value;
                            },
                          ),
                        ),
                        Text(CustomStrings.kBikeVolume.tr),
                        Obx(
                          () => BikeDropdownField(
                            hintText: CustomStrings.kEnterVolume.tr,
                            items: volumes.toList(),
                            defaultValue: _manageBikeController.bike.bikeVolume!
                                    .trim()
                                    .isNotEmpty
                                ? _manageBikeController
                                    .bike.bikeVolume.obs.value!
                                : _addBikeController.volume.value,
                            onChangedFunc: (value) {
                              _addBikeController.volume.value = value;
                            },
                          ),
                        ),
                        Text(CustomStrings.kNumberPlate.tr),
                        BikeTextField(
                          hintText: CustomStrings.kEnterNumberPlate.tr,
                          isReadOnly: false,
                          isEditSOSNumber: true,
                          initialValue:
                              '${_manageBikeController.bike.plateNumber}',
                          onChangedFunc: (value) {
                            _addBikeController.plateNumber.value = value;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(CustomStrings.kRegistrationPicture.tr),
                            CameraButton(onPressed: () async {
                              _addBikeController.registrationPicture.value =
                                  await Get.toNamed(CommonRoutes.TAKE_PICTURE,
                                      arguments: {'type': 'bike license'});
                            }),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Obx(
                            () => _manageBikeController
                                    .bike.bikeLicensePicture.obs.value!
                                    .contains('http')
                                ? Container(
                                    height: 250,
                                    child: Image.network(
                                        _manageBikeController
                                            .bike.bikeLicensePicture!,
                                        fit: BoxFit.cover))
                                : ImageFileContainer(
                                    condition: _addBikeController
                                            .registrationPicture.value ==
                                        '',
                                    path: _addBikeController
                                        .registrationPicture.value),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(CustomStrings.kBikePicture.tr),
                            CameraButton(onPressed: () async {
                              _addBikeController.bikePicture.value =
                                  await Get.toNamed(CommonRoutes.TAKE_PICTURE,
                                      arguments: {'type': 'bike'});
                            }),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Obx(
                            () => _manageBikeController
                                    .bike.bikePicture.obs.value!
                                    .contains('http')
                                ? Container(
                                    height: 250,
                                    child: Image.network(
                                        _manageBikeController.bike.bikePicture!,
                                        fit: BoxFit.cover))
                                : ImageFileContainer(
                                    condition:
                                        _addBikeController.bikePicture.value ==
                                            '',
                                    path: _addBikeController.bikePicture.value),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(CustomStrings.kNumberPlatePicture.tr),
                            CameraButton(onPressed: () async {
                              _addBikeController.numberPlatePicture.value =
                                  await Get.toNamed(CommonRoutes.TAKE_PICTURE,
                                      arguments: {'type': 'number plate'});
                            }),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Obx(
                            () => _manageBikeController
                                    .bike.plateNumberPicture.obs.value!
                                    .contains('http')
                                ? Container(
                                    height: 250,
                                    child: Image.network(
                                        _manageBikeController
                                            .bike.plateNumberPicture!,
                                        fit: BoxFit.cover))
                                : ImageFileContainer(
                                    condition: _addBikeController
                                            .numberPlatePicture.value ==
                                        '',
                                    path: _addBikeController
                                        .numberPlatePicture.value),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(CustomStrings.kDrivingLicenseBackPicture.tr),
                            CameraButton(onPressed: () async {
                              _addBikeController
                                      .drivingLicenseBackPicture.value =
                                  await Get.toNamed(CommonRoutes.TAKE_PICTURE,
                                      arguments: {
                                    'type': 'drivingLicenseBack'
                                  });
                            }),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Obx(
                            () => _manageBikeController
                                    .bike.drivingLicenseBackPicture.obs.value!
                                    .contains('http')
                                ? Container(
                                    height: 250,
                                    child: Image.network(
                                        _manageBikeController
                                            .bike.drivingLicenseBackPicture!,
                                        fit: BoxFit.cover))
                                : ImageFileContainer(
                                    condition: _addBikeController
                                            .drivingLicenseBackPicture.value ==
                                        '',
                                    path: _addBikeController
                                        .drivingLicenseBackPicture.value),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(CustomStrings.kDrivingLicenseFrontPicture.tr),
                            CameraButton(onPressed: () async {
                              _addBikeController
                                      .drivingLicenseFrontPicture.value =
                                  await Get.toNamed(CommonRoutes.TAKE_PICTURE,
                                      arguments: {
                                    'type': 'drivingLicenseFront'
                                  });
                            }),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Obx(
                            () => _manageBikeController
                                    .bike.drivingLicenseFrontPicture.obs.value!
                                    .contains('http')
                                ? Container(
                                    height: 250,
                                    child: Image.network(
                                        _manageBikeController
                                            .bike.drivingLicenseFrontPicture!,
                                        fit: BoxFit.cover))
                                : ImageFileContainer(
                                    condition: _addBikeController
                                            .drivingLicenseFrontPicture.value ==
                                        '',
                                    path: _addBikeController
                                        .drivingLicenseFrontPicture.value),
                          ),
                        ),
                        if (isAddBike) ...[
                          CustomElevatedIconButton(
                            onPressedFunc: () async {
                              CustomDialog customDialog =
                                  CustomDialog(context: context);

                              if (_addBikeController.validate()) {
                                customDialog.loadingDialog.show();

                                if (await _addBikeController
                                    .addBikeOrReplaceBike(
                                        isAddBike: isAddBike,
                                        customDialog: customDialog,
                                        context: context)) {
                                  customDialog.loadingDialog.dismiss();
                                  if (isAddBike) {
                                    Get.back();
                                  } else {
                                    Biike.role.value = Role.keer;
                                    Get.offAllNamed(CommonRoutes.HOME);
                                  }

                                  AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.SUCCES,
                                          headerAnimationLoop: false,
                                          desc:
                                              CustomStrings.kAddBikeSuccess.tr)
                                      .show();
                                } else {
                                  customDialog.loadingDialog.dismiss();

                                  CommonFunctions().showErrorDialog(
                                      context: context,
                                      message:
                                          CustomErrorsString.kDevelopError.tr);
                                }
                              } else {
                                CommonFunctions().showErrorDialog(
                                    context: context,
                                    message: CustomErrorsString
                                        .kNotFillAllFields.tr);
                              }
                            },
                            text: CustomStrings.kSave.tr,
                            backgroundColor: CustomColors.kBlue,
                            foregroundColor: Colors.white,
                            elevation: 2.0,
                            icon: Icons.save,
                          ),
                        ],
                      ]),
                )),
          )),
    );
  }
}
