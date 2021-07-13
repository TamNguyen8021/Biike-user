import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

/// This widget is the bottom navigation bar on home page
class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColors.blue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
      child: TabBar(tabs: const <Widget>[
        Tab(
          icon: Icon(Icons.home),
          child: Text(
            CustomStrings.home,
          ),
        ),
        Tab(
          icon: Icon(Icons.calendar_today),
          child: Text(CustomStrings.activities),
        )
      ]),
    );
  }
}
