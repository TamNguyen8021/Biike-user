import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/data/providers/pathshare_provider.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/bottom_tabbar.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/switch_role_button.dart';
import 'package:bikes_user/app/ui/android/pages/home/widgets/activity.dart';
import 'package:bikes_user/app/ui/android/pages/home/widgets/home.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// The home screen template for both ke-er and biker
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _homeController = Get.find<HomeController>();
  final _profileController = Get.find<ProfileController>();
  final _tripDetailsController = Get.find<TripDetailsController>();
  final _pathshareProvider = Get.find<PathshareProvider>();

  // void _onBackPressed() async {
  //   await Get.defaultDialog(
  //       title: 'Confirm',
  //       middleText: 'Do you want to exit the app?',
  //       middleTextStyle: TextStyle(color: Colors.black),
  //       textCancel: CustomStrings.kCancel.tr,
  //       textConfirm: 'Yes',
  //       onConfirm: () => SystemChannels.platform
  //           .invokeMethod<void>('SystemNavigator.pop')); //exit the app
  // }

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
      child: FutureBuilder(
          future: _profileController.getProfile(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize:
                        Size.fromHeight(AppBar().preferredSize.height),
                    child: Builder(
                      builder: (context) {
                        switch (DefaultTabController.of(context)!.index) {
                          case 0:
                            _homeController.setAppBarVisible(true);
                            break;
                          case 1:
                            _homeController.setAppBarVisible(false);
                            break;
                          default:
                            break;
                        }
                        return Obx(
                          () => CustomAppBar(
                            isVisible: _homeController.isAppBarVisible.value,
                            hasShape: true,
                            hasLeading: false,
                            onPressedFunc: () {},
                            appBar: AppBar(),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/logo-white.png',
                                    height: 25.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: SwitchRoleButton(
                                      route: CommonRoutes.HOME,
                                      isOnProfilePage: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actionWidgets: <Widget>[
                              IconButton(
                                  onPressed: () =>
                                      Get.toNamed(CommonRoutes.NOTIFICATION),
                                  icon: Icon(Icons.notifications)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 16.0, 20.0, 16.0),
                                child: CircularProfileAvatar(
                                  _profileController.user.avatar,
                                  radius: 12,
                                  onTap: () {
                                    Get.toNamed(CommonRoutes.PROFILE);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  body: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Home(
                        homeController: _homeController,
                      ),
                      Activity(
                        homeController: _homeController,
                      ),
                    ],
                  ),
                  bottomNavigationBar: BottomTabBar(
                    onTapFunction: (index) async {
                      switch (index) {
                        case 0:
                          _homeController.setAppBarVisible(true);
                          break;
                        case 1:
                          _homeController.setAppBarVisible(false);
                          break;
                        default:
                          break;
                      }
                      await _homeController.getUpcomingTrips();
                    },
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
