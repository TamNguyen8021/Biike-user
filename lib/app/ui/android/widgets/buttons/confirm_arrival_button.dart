import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// This widget means user has arrived at the pick up point.
// ignore: must_be_immutable
class ConfirmArrivalButton extends StatelessWidget {
  final _tripProvider = Get.find<TripProvider>();
  final bool isOnHomeScreen;
  final int tripId;

  Rx<bool> isAtDestination = false.obs;
  Rx<Color> buttonColor = CustomColors.kBlue.obs;
  Rx<String> buttonText = CustomStrings.kConfirmArrival.tr.obs;

  ConfirmArrivalButton(
      {Key? key, required this.isOnHomeScreen, required this.tripId})
      : super(key: key);

  void _showConfirmArrivalDialog(
      {required BuildContext context, required Role role}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    CustomStrings.kConfirmArrivalTitle.tr,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      role == Role.keer
                          ? CustomStrings.kConfirmArrivalMessageForKeer.tr
                          : CustomStrings.kConfirmArrivalMessageForBiker.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomTextButton(
                            hasBorder: false,
                            backgroundColor: CustomColors.kLightGray,
                            foregroundColor: CustomColors.kDarkGray,
                            text: CustomStrings.kCancel.tr,
                            onPressedFunc: () {
                              Get.back();
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CustomTextButton(
                            hasBorder: false,
                            backgroundColor: CustomColors.kBlue,
                            foregroundColor: Colors.white,
                            text: CustomStrings.kYes.tr,
                            onPressedFunc: () async {
                              if (await _tripProvider.markArrivedAtPickUpPoint(
                                  tripId: tripId)) {
                                isAtDestination.value = true;
                                buttonColor.value = CustomColors.kDarkGray;
                                buttonText.value =
                                    CustomStrings.kArriveAtDestination.tr;
                                Get.back();
                              } else {
                                CommonFunctions().showErrorDialog(
                                    context: context,
                                    message:
                                        CustomErrorsString.kDevelopError.tr);
                              }
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: isOnHomeScreen ? 170 : null,
      child: Obx(() => ElevatedButton.icon(
            onPressed: () {
              if (isOnHomeScreen && isAtDestination.isFalse) {
                _showConfirmArrivalDialog(
                    context: context, role: Biike.role.value);
              } else if (!isOnHomeScreen) {
                Get.offAllNamed(CommonRoutes.FEEDBACK, arguments: tripId);
              }
            },
            icon: Icon(Icons.done_all, size: 25),
            label: Text(
              buttonText.value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:
                      MediaQuery.of(context).size.width >= 400 ? 12.sp : 10.sp),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              primary: buttonColor.value,
            ),
          )),
    );
  }
}
