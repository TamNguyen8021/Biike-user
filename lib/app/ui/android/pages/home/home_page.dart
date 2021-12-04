import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/providers/pathshare_provider.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/bottom_tabbar.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/create_trip_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/switch_role_button.dart';
import 'package:bikes_user/app/ui/android/pages/home/widgets/activity.dart';
import 'package:bikes_user/app/ui/android/pages/home/widgets/home.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/android/widgets/painters/tooltip_painter.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/main.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// The home screen template for both ke-er and biker
// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _homeController = Get.find<HomeController>();
  final _profileController = Get.find<ProfileController>();
  final _tripDetailsController = Get.find<TripDetailsController>();
  final _pathshareProvider = Get.find<PathshareProvider>();

  Rx<bool> isAppBarVisible = true.obs;

  /// Show/hide appbar depends on [isVisible]
  ///
  /// Author: TamNTT
  void setAppBarVisible(isVisible) {
    isAppBarVisible.value = isVisible;
  }

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
                            setAppBarVisible(true);
                            break;
                          case 1:
                            setAppBarVisible(false);
                            break;
                          default:
                            break;
                        }
                        return Obx(
                          () => CustomAppBar(
                            isVisible: isAppBarVisible.value,
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
                  body: GetBuilder<HomeController>(
                      init: _homeController,
                      builder: (HomeController controller) {
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
                  floatingActionButton: Biike.role.value == Role.keer
                      ? Obx(
                          () => Visibility(
                            visible: isAppBarVisible.value,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                if (_homeController.upcomingTrips.isEmpty) ...[
                                  CustomPaint(
                                    foregroundPainter: TooltipPainter(),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      margin: const EdgeInsets.only(
                                          bottom: 20.0,
                                          left: 22.0,
                                          right: 22.0),
                                      decoration: BoxDecoration(
                                        color: CustomColors.kLightGray,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        CustomStrings.kCreateTrip.tr,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                  ),
                                ],
                                CreateTripButton(
                                  createTrip: () {
                                    _homeController
                                        .verifyPhoneBeforeBookOrSearchStrip(
                                            context: context,
                                            onSuccess: () => Get.toNamed(
                                                CommonRoutes.BOOK_TRIP));
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      : null,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  bottomNavigationBar: BottomTabBar(
                    onTapFunction: (index) {
                      switch (index) {
                        case 0:
                          setAppBarVisible(true);
                          break;
                        case 1:
                          setAppBarVisible(false);
                          break;
                        default:
                          break;
                      }
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
