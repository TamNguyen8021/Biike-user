import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_dialog.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_objects/custom_location.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This widget means user has arrived at the pick up point.
// ignore: must_be_immutable
class ConfirmArrivalButton extends StatelessWidget {
  final _tripProvider = Get.find<TripProvider>();
  final TripDetailsController tripDetailsController;
  final int tripId;

  Rx<Color> buttonColor = CustomColors.kBlue.obs;
  Rx<String> buttonText = CustomStrings.kConfirmArrival.tr.obs;

  ConfirmArrivalButton(
      {Key? key, required this.tripDetailsController, required this.tripId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isArrivedAtPickUpPoint = false;

    return FutureBuilder(
        future: _tripProvider.isArrivedAtPickUpPoint(tripId: tripId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            isArrivedAtPickUpPoint = snapshot.data;

            if (isArrivedAtPickUpPoint) {
              buttonColor.value = CustomColors.kDarkGray;
              buttonText.value = CustomStrings.kArriveAtDestination.tr;
            }

            return SizedBox(
              height: 35,
              width: 185,
              child: Obx(() => ElevatedButton.icon(
                    onPressed: () async {
                      tripDetailsController.userLocation =
                          await CommonFunctions.getCurrentLocation();

                      if (tripDetailsController.userLocation != null) {
                        CommonFunctions.showConfirmDialog(
                            context: context,
                            isCancel: false,
                            title: CustomStrings.kConfirmArrivalTitle.tr,
                            message: Biike.role.value == Role.keer
                                ? CustomStrings.kConfirmArrivalMessageForKeer.tr
                                : CustomStrings
                                    .kConfirmArrivalMessageForBiker.tr,
                            onPressedFunc: () async {
                              await tripDetailsController.getTripDetails(
                                  tripId: tripId);
                              tripDetailsController.userLocation =
                                  await CommonFunctions.getCurrentLocation();

                              CustomLocation departureLocation = CustomLocation(
                                  coordinate: tripDetailsController
                                      .departureStation.departureCoordinate);

                              if (CommonFunctions().isArrivedAtPickUpPoint(
                                  userLat: tripDetailsController
                                      .userLocation!.latitude!,
                                  userLng: tripDetailsController
                                      .userLocation!.longitude!,
                                  departureLat: departureLocation.latitude,
                                  departureLng: departureLocation.longitude)) {
                                Get.back();
                                
                                CustomDialog customDialog = CustomDialog(context: context);
                                customDialog.loadingDialog.show();

                                if (await _tripProvider
                                    .markArrivedAtPickUpPoint(tripId: tripId)) {
                                  buttonColor.value = CustomColors.kDarkGray;
                                  buttonText.value =
                                      CustomStrings.kArriveAtDestination.tr;
                                  customDialog.loadingDialog.dismiss();
                                } else {
                                  AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.ERROR,
                                          headerAnimationLoop: false,
                                          desc: CustomErrorsString
                                              .kDevelopError.tr)
                                      .show();
                                }
                              } else {
                                AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.ERROR,
                                        headerAnimationLoop: false,
                                        desc: CustomErrorsString
                                            .kNotArrivedAtPickUpPoint.tr)
                                    .show();
                              }
                            });
                      } else {
                        AwesomeDialog(
                                context: context,
                                dialogType: DialogType.INFO_REVERSED,
                                headerAnimationLoop: false,
                                desc: CustomStrings.kNeedLocationPermission.tr)
                            .show();
                      }
                    },
                    icon: Icon(Icons.done_all, size: 25),
                    label: Text(
                      buttonText.value,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      primary: buttonColor.value,
                    ),
                  )),
            );
          } else {
            return Loading();
          }
        });
  }
}
