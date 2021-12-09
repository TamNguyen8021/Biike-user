import 'package:bikes_user/app/common/values/custom_dialog.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// The 'get_trip_success' screen
class GetTripSuccessPage extends StatelessWidget {
  final HomeController _homeController = Get.arguments['controller'];

  GetTripSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: SvgPicture.asset(
                  'assets/images/biike-two-person.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 75.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                CustomStrings.kGetTripSuccess.tr,
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: CustomColors.kBlue,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IntrinsicWidth(
                        stepWidth: 200,
                        child: Column(
                          children: <Widget>[
                            CustomTextButton(
                                backgroundColor: CustomColors.kBlue,
                                foregroundColor: Colors.white,
                                text: CustomStrings.kViewTrip.tr,
                                onPressedFunc: () {
                                  Get.offAndToNamed(CommonRoutes.TRIP_DETAILS,
                                      arguments: {
                                        'tripId': Get.arguments['tripId'],
                                        'userId': Get.arguments['userId'],
                                        'route': 'getTripSuccess'
                                      });
                                },
                                hasBorder: false),
                            Padding(padding: EdgeInsets.all(10.0)),
                            CustomTextButton(
                                backgroundColor: Colors.white,
                                foregroundColor: CustomColors.kDarkGray,
                                text: CustomStrings.kBtnExit.tr,
                                onPressedFunc: () async {
                                  CustomDialog customDialog =
                                      CustomDialog(context: context);

                                  customDialog.loadingDialog.show();
                                  await _homeController.searchTrips(
                                      date: _homeController.searchDate.value,
                                      time: _homeController.searchTime.value,
                                      departureId: _homeController
                                          .departureStation.value.stationId,
                                      destinationId: _homeController
                                          .destinationStation.value.stationId);
                                  customDialog.loadingDialog.dismiss();
                                  Get.back();
                                },
                                hasBorder: false),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
