import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/controllers/manage_bike_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 'manage_bike' screen
class ManageBikePage extends StatelessWidget {
  final bool isBikeVerified;

  ManageBikePage({Key? key, required this.isBikeVerified}) : super(key: key);

  void _onBackPressed() {
    Get.offAndToNamed(CommonRoutes.PROFILE);
  }

  @override
  Widget build(BuildContext context) {
    final manageBikeController = Get.find<ManageBikeController>();

    return FutureBuilder(
        future: manageBikeController.getBike(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(
              () => OnBackPressed(
                perform: () => _onBackPressed(),
                child: Scaffold(
                  appBar: CustomAppBar(
                    isVisible: true,
                    hasLeading: true,
                    onPressedFunc: _onBackPressed,
                    hasShape: true,
                    appBar: AppBar(),
                    title: Text(
                      CustomStrings.kManageBike.tr,
                    ),
                    actionWidgets: <Widget>[
                      if (manageBikeController.hasBike.isTrue) ...[
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                            onPressed: () => manageBikeController.removeBike(
                                context: context),
                            icon: Icon(Icons.delete),
                          ),
                        ),
                      ] else ...[
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                            onPressed: () => Get.toNamed(CommonRoutes.ADD_BIKE,
                                arguments: {
                                  'isAddBike': true,
                                  'from': 'manageBike'
                                }),
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ]
                    ],
                  ),
                  body: manageBikeController.hasBike.isTrue
                      ? GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.all(22.0),
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                                color: CustomColors.kLightGray,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color:
                                        CustomColors.kDarkGray.withOpacity(0.3),
                                    // changes position of shadow
                                    offset: Offset(0, 1.5),
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.two_wheeler,
                                        size: 25,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        manageBikeController.bike.plateNumber ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(fontSize: 20.sp),
                                      ),
                                    ),
                                    if (isBikeVerified) ...[
                                      Text(
                                        CustomStrings.kBikeVerified.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                color: CustomColors.kBlue),
                                      ),
                                    ] else ...[
                                      Text(
                                        CustomStrings.kWaitingVerified.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                color: CustomColors.kOrange),
                                      ),
                                    ]
                                  ]),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        CustomStrings.kBikeOwner.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Text(
                                          manageBikeController.bike.bikeOwner ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                      Text(
                                        CustomStrings.kBikeBrand.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Text(
                                          manageBikeController.bike.brand ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                      Text(
                                        CustomStrings.kBikeColor.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      Text(
                                        manageBikeController.bike.color ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(CommonRoutes.ADD_BIKE, arguments: {
                              'isAddBike': false,
                              'from': 'manageBike'
                            });
                          },
                        )
                      : Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            CustomStrings.kSuggestAddBike.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: CustomColors.kDarkGray,
                            ),
                          ),
                        ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
