import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/biike_profile_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiikeProfilePage extends StatelessWidget {
  final _biikeProfileController = Get.find<BiikeProfileController>();

  BiikeProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      appBar: CustomAppBar(
        hasShape: false,
        appBar: AppBar(),
        hasLeading: true,
        onPressedFunc: () {
          Get.back();
        },
        title: Text(
          CustomStrings.kBiikeProfile.tr,
        ),
      ),
      body: FutureBuilder(
          future: _biikeProfileController.getUserAchievement(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            CustomStrings.kOnJourneyWithBiike.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  _biikeProfileController.noOfRideTrips,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 30.sp),
                                ),
                              ),
                              Text(
                                CustomStrings.kNoOfRideTrips.tr,
                                style: TextStyle(color: CustomColors.kDarkGray),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: CustomColors.kLightGray,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: CustomColors.kDarkGray.withOpacity(0.3),
                                // changes position of shadow
                                offset: Offset(0, 1.25),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  _biikeProfileController.noOfFreeTrips,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 30.sp),
                                ),
                              ),
                              Text(
                                CustomStrings.kNoOfFreeTrips.tr,
                                style: TextStyle(color: CustomColors.kDarkGray),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: CustomColors.kLightGray,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: CustomColors.kDarkGray.withOpacity(0.3),
                                // changes position of shadow
                                offset: Offset(0, 1.25),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  _biikeProfileController.noOfKm,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 30.sp),
                                ),
                              ),
                              Text(
                                CustomStrings.kNoOfKm.tr,
                                style: TextStyle(color: CustomColors.kDarkGray),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: CustomColors.kLightGray,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: CustomColors.kDarkGray.withOpacity(0.3),
                                // changes position of shadow
                                offset: Offset(0, 1.25),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  _biikeProfileController.noOfGasLitres,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 30.sp),
                                ),
                              ),
                              Text(
                                CustomStrings.kNoOfGasLitres.tr,
                                style: TextStyle(color: CustomColors.kDarkGray),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: CustomColors.kLightGray,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: CustomColors.kDarkGray.withOpacity(0.3),
                                // changes position of shadow
                                offset: Offset(0, 1.25),
                              )
                            ],
                          ),
                        ),
                        Text(
                          CustomStrings.kThankYouForChoosingBiike.tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 30.0, bottom: 16.0),
                          child: Image.asset(
                            'assets/images/logo-app-blue.jpg',
                            width: 220,
                            height: 50,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Text(
                          CustomStrings.kFromFPTUniversity.tr,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Loading();
            }
          }),
    );
  }
}
