import 'package:bikes_user/main.dart';
import 'package:bikes_user/pages/home/controller/home_controller.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:bikes_user/widgets/lists/list_upcoming_trips.dart';
import 'package:bikes_user/widgets/others/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The activity page widget
class Activity extends StatelessWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    String _roleActivity = CustomStrings.kKeerActivities;
    if (Biike.role.value != Role.keer) {
      _roleActivity = CustomStrings.kBikerActivities;
    }

    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _roleActivity,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.kBlue),
                      ),
                      IconButton(
                          onPressed: () => Get.toNamed('/tripHistory'),
                          icon: Icon(
                            Icons.history,
                            color: CustomColors.kBlue,
                          ))
                    ]),
              ),
              if (homeController.upcomingTrips.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: ListUpcomingTrips(
                    listUpcomingTrips: homeController.upcomingTrips,
                    itemPadding: 10.0,
                  ),
                ),
              ] else ...[
                Loading(),
              ]
            ],
          ),
        )),
      ),
    );
  }
}
