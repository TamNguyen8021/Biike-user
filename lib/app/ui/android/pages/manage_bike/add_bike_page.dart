import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/add_bike_controller.dart';
import 'package:bikes_user/app/controllers/manage_bike_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/camera_button.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/custom_elevated_icon_has_loading_button.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/bike_dropdown_field.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/bike_text_field.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/image_file_container.dart';
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
    'Honda',
    'Yamaha',
    'Toyota',
  ].obs;
  RxList<String> categories = ['Xe số', 'Tay ga', 'Tay côn'].obs;
  RxList<String> volumes = ['50cc', '100cc', '120cc'].obs;

  bool isAddBike = Get.arguments['isAddBike'];
  String fromPage = Get.arguments['from'];

  AddBikePage({Key? key}) : super(key: key);

  Future<void> _onBackPressed() async {
    await _manageBikeController.getBike();
    if (fromPage == 'requireAddBike') {
      Biike.role.value = Role.keer;
      Biike.localAppData.saveRole(Biike.role.value);
      Get.offAllNamed(CommonRoutes.HOME);
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isAddBike) {
      _addBikeController.brand.value = brands.first;
      _addBikeController.volume.value = volumes.first;
      _addBikeController.category.value = categories.first;
    }

    return OnBackPressed(
      perform: () {
        _onBackPressed();
      },
      child: GetBuilder(
          init: _addBikeController,
          builder: (_) {
            return Scaffold(
                appBar: CustomAppBar(
                  isVisible: true,
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
                              Obx(
                                () => BikeTextField(
                                  hintText: CustomStrings.kEnterBikeOwner.tr,
                                  isReadOnly: false,
                                  isEditSOSNumber: true,
                                  initialValue:
                                      '${_addBikeController.bikeOwner}',
                                  onChangedFunc: (value) {
                                    _addBikeController.bikeOwner.value = value;
                                  },
                                ),
                              ),
                              Text(CustomStrings.kBikeBrand.tr),
                              Obx(
                                () => BikeDropdownField(
                                  hintText: CustomStrings.kEnterBrand.tr,
                                  items: brands.toList(),
                                  defaultValue: _addBikeController.brand.value,
                                  onChangedFunc: (value) {
                                    _addBikeController.brand.value = value;
                                  },
                                ),
                              ),
                              Text(CustomStrings.kBikeColor.tr),
                              Obx(
                                () => BikeTextField(
                                  hintText: CustomStrings.kEnterColor.tr,
                                  isReadOnly: false,
                                  isEditSOSNumber: true,
                                  initialValue: '${_addBikeController.color}',
                                  onChangedFunc: (value) {
                                    _addBikeController.color.value = value;
                                  },
                                ),
                              ),
                              Text(CustomStrings.kBikeCategory.tr),
                              Obx(
                                () => BikeDropdownField(
                                  hintText: CustomStrings.kEnterCategory.tr,
                                  items: categories.toList(),
                                  defaultValue:
                                      _addBikeController.category.value,
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
                                  defaultValue: _addBikeController.volume.value,
                                  onChangedFunc: (value) {
                                    _addBikeController.volume.value = value;
                                  },
                                ),
                              ),
                              Text(CustomStrings.kNumberPlate.tr),
                              Obx(
                                () => BikeTextField(
                                  hintText: CustomStrings.kEnterNumberPlate.tr,
                                  isReadOnly: false,
                                  isEditSOSNumber: true,
                                  initialValue:
                                      '${_addBikeController.plateNumber}',
                                  onChangedFunc: (value) {
                                    _addBikeController.plateNumber.value =
                                        value;
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(CustomStrings.kRegistrationPicture.tr),
                                  CameraButton(onPressed: () async {
                                    _addBikeController
                                            .registrationPicture.value =
                                        await Get.toNamed(
                                            CommonRoutes.TAKE_PICTURE,
                                            arguments: {
                                          'type': 'bike license'
                                        });
                                  }),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Obx(
                                  () => _addBikeController
                                          .registrationPicture.value
                                          .contains('https')
                                      ? Container(
                                          height: 250,
                                          child: Image.network(_addBikeController
                                            .registrationPicture.value, fit: BoxFit.cover))
                                      : ImageFileContainer(
                                          condition: _addBikeController
                                                  .registrationPicture.value ==
                                              '',
                                          path: _addBikeController
                                              .registrationPicture.value),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(CustomStrings.kBikePicture.tr),
                                  CameraButton(onPressed: () async {
                                    _addBikeController.bikePicture.value =
                                        await Get.toNamed(
                                            CommonRoutes.TAKE_PICTURE,
                                            arguments: {'type': 'bike'});
                                  }),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Obx(
                                  () => _addBikeController.bikePicture.value
                                          .contains('https')
                                      ? Container(
                                          height: 250,
                                          child: Image.network(_addBikeController
                                              .bikePicture.value, fit: BoxFit.cover))
                                      : ImageFileContainer(
                                          condition: _addBikeController
                                                  .bikePicture.value ==
                                              '',
                                          path: _addBikeController
                                              .bikePicture.value),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(CustomStrings.kNumberPlatePicture.tr),
                                  CameraButton(onPressed: () async {
                                    _addBikeController
                                            .numberPlatePicture.value =
                                        await Get.toNamed(
                                            CommonRoutes.TAKE_PICTURE,
                                            arguments: {
                                          'type': 'number plate'
                                        });
                                  }),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Obx(
                                  () => _addBikeController
                                          .numberPlatePicture.value
                                          .contains('https')
                                      ? Container(
                                          height: 250,
                                          child: Image.network(_addBikeController
                                              .numberPlatePicture.value, fit: BoxFit.cover))
                                      : ImageFileContainer(
                                          condition: _addBikeController
                                                  .numberPlatePicture.value ==
                                              '',
                                          path: _addBikeController
                                              .numberPlatePicture.value),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(CustomStrings.kDrivingLicenseBackPicture.tr),
                                  CameraButton(onPressed: () async {
                                    _addBikeController
                                        .drivingLicenseBackPicture.value =
                                    await Get.toNamed(
                                        CommonRoutes.TAKE_PICTURE,
                                        arguments: {
                                          'type': 'driving license back'
                                        });
                                  }),
                                ],
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 16.0),
                                child: Obx(
                                      () => _addBikeController
                                      .drivingLicenseBackPicture.value
                                      .contains('https')
                                      ? Container(
                                      height: 250,
                                      child: Image.network(_addBikeController
                                          .drivingLicenseBackPicture.value, fit: BoxFit.cover))
                                      : ImageFileContainer(
                                      condition: _addBikeController
                                          .drivingLicenseBackPicture.value ==
                                          '',
                                      path: _addBikeController
                                          .drivingLicenseBackPicture.value),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(CustomStrings.kDrivingLicenseFrontPicture.tr),
                                  CameraButton(onPressed: () async {
                                    _addBikeController
                                        .drivingLicenseFrontPicture.value =
                                    await Get.toNamed(
                                        CommonRoutes.TAKE_PICTURE,
                                        arguments: {
                                          'type': 'driving license front'
                                        });
                                  }),
                                ],
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 16.0),
                                child: Obx(
                                      () => _addBikeController
                                      .drivingLicenseFrontPicture.value
                                      .contains('https')
                                      ? Container(
                                      height: 250,
                                      child: Image.network(_addBikeController
                                          .drivingLicenseFrontPicture.value, fit: BoxFit.cover))
                                      : ImageFileContainer(
                                      condition: _addBikeController
                                          .drivingLicenseFrontPicture.value ==
                                          '',
                                      path: _addBikeController
                                          .drivingLicenseFrontPicture.value),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 100),
                                      child: CustomElevatedIconHasLoadingButton(
                                        onPressedFunc: () async {
                                          if (_addBikeController.validate()) {
                                            if (await _addBikeController
                                                .addBikeOrReplaceBike(
                                                    isAddBike: isAddBike)) {
                                              await _onBackPressed();
                                              CommonFunctions().showSuccessDialog(
                                                  context: context,
                                                  message: CustomStrings.kAddBikeSuccess.tr
                                              );
                                            } else {
                                              CommonFunctions().showErrorDialog(
                                                  context: context,
                                                  message: CustomErrorsString
                                                      .kDevelopError.tr);
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
                                        isLoading: _addBikeController.isLoading,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ]),
                      )),
                ));
          }),
    );
  }
}
