import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_upcoming_trips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// The activity page widget
class Activity extends StatelessWidget {
  final HomeController homeController;

  const Activity({Key? key, required this.homeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Role _role = Role.none;

    String _roleActivity = CustomStrings.kKeerActivities.tr;
    if (Biike.role.value != Role.keer) {
      _roleActivity = CustomStrings.kBikerActivities.tr;
    }

    return FutureBuilder(
        future: homeController.getUpcomingTrips(
            context: context,
            userId: Biike.userId,
            role: _role.getRoleNum(Biike.role.value)),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: null,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 22.0, vertical: 40.0),
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
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.kBlue),
                                ),
                                IconButton(
                                    onPressed: () =>
                                        Get.toNamed(CommonRoutes.TRIP_HISTORY),
                                    icon: Icon(
                                      Icons.history,
                                      color: CustomColors.kBlue,
                                    ))
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: ListUpcomingTrips(
                            listUpcomingTrips: homeController.upcomingTrips,
                            itemPadding: 10.0,
                          ),
                        ),
                      ],
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
