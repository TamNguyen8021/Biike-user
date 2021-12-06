import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/data/providers/pathshare_provider.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/bottom_tabbar.dart';
import 'package:bikes_user/app/ui/android/pages/home/widgets/activity.dart';
import 'package:bikes_user/app/ui/android/pages/home/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// The home screen template for both ke-er and biker
// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _homeController = Get.find<HomeController>();
  final _tripDetailsController = Get.find<TripDetailsController>();
  final _pathshareProvider = Get.find<PathshareProvider>();

  @override
  Widget build(BuildContext context) {
    return OnBackPressed(
      perform: () => CommonFunctions().showConfirmDialog(
        context: context,
        title: CustomStrings.kConfirm.tr,
        message: CustomStrings.kConfirmExitApp.tr,
        onPressedFunc: () async {
          if (_tripDetailsController.isLocationShared.isTrue) {
            if (await _pathshareProvider.leaveSession(
                sessionIdentifier: _tripDetailsController.sessionIdentifier)) {
              SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
            } else {
              await CommonFunctions().showErrorDialog(
                  context: context,
                  message: CustomErrorsString.kErrorWhenStopSharingLocation.tr);
            }
          } else {
            SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
          }
        },
      ),
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            body: GetBuilder<HomeController>(
                init: _homeController,
                builder: (HomeController controller) {
                  controller.pagingController.notifyPageRequestListeners(0);

                  return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Home(
                        homeController: controller,
                      ),
                      Activity(
                        homeController: controller,
                      ),
                    ],
                  );
                }),
            bottomNavigationBar: BottomTabBar(
              onTapFunction: (int index) {
                _homeController.upcomingTrips.clear();
                _homeController.isUpcomingTripsLoading.value = true;
                Future.sync(() => _homeController.pagingController.refresh());
              },
            ),
          ),
        ),
      ),
    );
  }
}
