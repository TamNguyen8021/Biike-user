import 'dart:io';

import 'package:bikes_user/app/controllers/add_bike_controller.dart';
import 'package:bikes_user/app/ui/android/pages/add_bike_camera/add_bike_camera_page.dart';
import 'package:bikes_user/app/ui/android/widgets/others/bike_text_field.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'add_bike' screen
class AddBikePage extends StatelessWidget {
  const AddBikePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addBikeController = Get.find<AddBikeController>();
    final Rx<String> imagePath = ''.obs;

    return Scaffold(
        appBar: CustomAppBar(
          isVisible: true,
          appBar: AppBar(),
          hasShape: true,
          hasLeading: true,
          title: Text(
            CustomStrings.kAddBike.tr,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Form(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      GetBuilder<AddBikeController>(
                        builder: (controller) {
                          if (controller.errorMessage.isNotEmpty) {
                            return Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                CustomStrings.kCheckBikeInfo.tr,
                                style: TextStyle(color: CustomColors.kBlue),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      Text(CustomStrings.kBikeOwner.tr),
                      Obx(
                        () => BikeTextField(
                          hintText: CustomStrings.kEnterBikeOwner.tr,
                          isReadOnly: false,
                          isEditSOSNumber: true,
                          initialValue: '${addBikeController.bikeOwner}',
                          onChangedFunc: (value) {
                            addBikeController.bikeOwner.value = value;
                          },
                        ),
                      ),
                      Text(CustomStrings.kBikeBrand.tr),
                      Obx(
                        () => BikeTextField(
                          hintText: CustomStrings.kEnterBrand.tr,
                          isReadOnly: false,
                          isEditSOSNumber: true,
                          initialValue: '${addBikeController.brand}',
                          onChangedFunc: (value) {
                            addBikeController.brand.value = value;
                          },
                        ),
                      ),
                      Text(CustomStrings.kBikeColor.tr),
                      Obx(
                        () => BikeTextField(
                          hintText: CustomStrings.kEnterColor.tr,
                          isReadOnly: false,
                          isEditSOSNumber: true,
                          initialValue: '${addBikeController.color}',
                          onChangedFunc: (value) {
                            addBikeController.color.value = value;
                          },
                        ),
                      ),
                      Text(CustomStrings.kNumberPlate.tr),
                      Obx(
                        () => BikeTextField(
                          hintText: CustomStrings.kEnterNumberPlate.tr,
                          isReadOnly: false,
                          isEditSOSNumber: true,
                          initialValue: '${addBikeController.plateNumber}',
                          onChangedFunc: (value) {
                            addBikeController.plateNumber.value = value;
                          },
                        ),
                      ),
                      Text(CustomStrings.kNumberPlatePicture.tr),
                      Obx(() => Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 15),
                          child: imagePath.value == ''
                              ? Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                    color: CustomColors.kLightGray,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                )
                              : Container(
                                  height: 250,
                                  child: Image.file(File(imagePath.value),
                                      fit: BoxFit.cover),
                                ))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, left: 30.0),
                              child: CustomElevatedIconButton(
                                onPressedFunc: () async {
                                  imagePath.value = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              AddBikeCameraPage()));
                                },
                                text: CustomStrings.kTakePictureAgain.tr,
                                backgroundColor: CustomColors.kLightGray,
                                foregroundColor: CustomColors.kDarkGray,
                                elevation: 0.0,
                                icon: Icons.photo_camera_outlined,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 30.0),
                              child: CustomElevatedIconButton(
                                onPressedFunc: () {
                                  addBikeController.addBike();
                                },
                                text: CustomStrings.kSave.tr,
                                backgroundColor: CustomColors.kBlue,
                                foregroundColor: Colors.white,
                                elevation: 2.0,
                                icon: Icons.save,
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
              )),
        ));
  }
}
