import 'package:bikes_user/main.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:flutter/material.dart';

/// This widget is the bottom navigation bar on home page
class BottomTabBar extends StatelessWidget {
  final Function(int)? onTapFunction;
  const BottomTabBar({Key? key, this.onTapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.0,
      child: Material(
        color: CustomColors.kBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
        child: TabBar(
          unselectedLabelColor: Colors.white,
          indicator: BoxDecoration(
              color: CustomColors.kDarkBlue,
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          indicatorPadding: const EdgeInsets.all(10.0),
          tabs: <Widget>[
            Tab(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(child: Icon(Icons.home_sharp)),
                      WidgetSpan(
                          child: Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                        child: Text(CustomStrings.kHome,
                            style: TextStyle(
                              fontSize: 10,
                            )),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            Tab(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                          child: Icon(
                        Icons.calendar_today_rounded,
                      )),
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                          child: Text(
                            Biike.role.value == Role.Customer
                                ? CustomStrings.kCustomerActivities
                                : CustomStrings.kDriverActivities,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          onTap: onTapFunction,
        ),
      ),
    );
  }
}
