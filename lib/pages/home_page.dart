import 'package:bikes_user/widgets/appbars/bottom_tabbar.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/switch_role_button.dart';
import 'package:bikes_user/widgets/pages/activity.dart';
import 'package:bikes_user/widgets/pages/customer_home_full.dart';
import 'package:bikes_user/widgets/pages/driver_home.dart';
import 'package:flutter/material.dart';

/// The home screen template for both ke-er and biker
class HomePage extends StatefulWidget {
  final String role;

  HomePage({Key? key, required this.role}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static late bool isAppBarVisible;

  @override
  Widget build(BuildContext context) {
    Widget _homePage = CustomerHomeFull();
    Widget _activityPage = Activity(
      role: widget.role,
    );
    String _homeRoute = '/driverHome';
    String _profileRoute = '/customerProfile';

    if (widget.role != 'Customer') {
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
                  isAppBarVisible = true;
                  break;
                case 1:
                  isAppBarVisible = false;
                  break;
                default:
                  break;
              }
              return CustomAppBar(
                isVisible: isAppBarVisible,
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
                          role: widget.role,
                          route: _homeRoute,
                        ),
                      ),
                    ],
                  ),
                ),
                actionWidgets: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, _profileRoute);
                        },
                        icon: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.white,
                        )),
                  ),
                ],
              );
            },
          ),
        ),
        body: TabBarView(
          children: <Widget>[_homePage, _activityPage],
        ),
        bottomNavigationBar: BottomTabBar(
          onTapFunction: (index) {
            setState(() {
              switch (index) {
                case 0:
                  isAppBarVisible = true;
                  break;
                case 1:
                  isAppBarVisible = false;
                  break;
                default:
                  break;
              }
            });
          },
        ),
      ),
    );
  }
}
