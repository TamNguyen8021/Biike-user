import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// On [HomePage] screen, this widget means user has arrived at the pick up point.
///
/// On [TripDetailsPage] screen, ke-er taps this button to finish a trip.
//ignore: must_be_immutable
class ConfirmArrivalButton extends StatelessWidget {
  final isOnHomeScreen;

  Rx<bool> isAtDestination = false.obs;
  Rx<Color> buttonColor = CustomColors.kBlue.obs;
  Rx<String> buttonText = CustomStrings.kConfirmArrival.tr.obs;

  ConfirmArrivalButton({Key? key, required this.isOnHomeScreen})
      : super(key: key);

  void _showConfirmArrivalDialog(
      {required BuildContext context, required Role role}) {
    showDialog(
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
                            backgroundColor: CustomColors.kBlue,
                            foregroundColor: Colors.white,
                            text: CustomStrings.kSure.tr,
                            onPressedFunc: () {
                              isAtDestination.value = true;
                              buttonColor.value = CustomColors.kDarkGray;
                              buttonText.value =
                                  CustomStrings.kArriveAtDestination.tr;
                              Get.back();
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
                // isAtDestination.value = true;
                // buttonColor.value = CustomColors.kDarkGray;
                // buttonText.value = CustomStrings.kArriveAtDestination.tr;
              } else if (!isOnHomeScreen) {
                Get.offAllNamed(CommonRoutes.FEEDBACK);
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
