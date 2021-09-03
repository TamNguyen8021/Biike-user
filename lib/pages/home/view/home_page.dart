import 'package:bikes_user/pages/home/controller/home_controller.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:bikes_user/widgets/appbars/bottom_tabbar.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/switch_role_button.dart';
import 'package:bikes_user/widgets/pages/activity.dart';
// import 'package:bikes_user/widgets/pages/customer_home_blank.dart';
import 'package:bikes_user/widgets/pages/customer_home_full.dart';
import 'package:bikes_user/widgets/pages/driver_home.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The home screen template for both ke-er and biker
class HomePage extends StatelessWidget {
  final Role role;

  HomePage({Key? key, required this.role}) : super(key: key);

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    Widget _homePage = CustomerHomeFull();
    Widget _activityPage = Activity(
      role: role,
    );
    String _homeRoute = '/driverHome';
    String _profileRoute = '/customerProfile';

    if (role != Role.Customer) {
      _homePage = DriverHome();
      _homeRoute = '/customerHome';
      _profileRoute = '/driverProfile';
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(new AppBar().preferredSize.height),
          child: Builder(
            builder: (context) {
              switch (DefaultTabController.of(context)!.index) {
                case 0:
                  homeController.setAppBarVisible(true);
                  break;
                case 1:
                  homeController.setAppBarVisible(false);
                  break;
                default:
                  break;
              }
              return Obx(
                () => CustomAppBar(
                  isVisible: homeController.isAppBarVisible.value,
                  hasShape: true,
                  hasLeading: false,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SwitchRoleButton(
                            role: role,
                            route: _homeRoute,
                          ),
                        ),
                      ],
                    ),
                  ),
                  actionWidgets: <Widget>[
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.notifications)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 20.0, 16.0),
                      child: CircularProfileAvatar(
                        'assets/images/profile-1.jpg',
                        radius: 12,
                        onTap: () {
                          Get.toNamed(_profileRoute);
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
          children: <Widget>[_homePage, _activityPage],
        ),
        bottomNavigationBar: BottomTabBar(
          onTapFunction: (index) {
            switch (index) {
              case 0:
                homeController.setAppBarVisible(true);
                break;
              case 1:
                homeController.setAppBarVisible(false);
                break;
              default:
                break;
            }
          },
        ),
      ),
    );
  }
}
