import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// The activity page widget
class Activity extends StatelessWidget {
  final HomeController homeController;

  const Activity({Key? key, required this.homeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _roleActivity = CustomStrings.kKeerActivities.tr;
    if (Biike.role.value != Role.keer) {
      _roleActivity = CustomStrings.kBikerActivities.tr;
    }

    return GetBuilder(
        init: homeController,
        builder: (_) {
          return Scaffold(
            appBar: null,
            body: Padding(
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
                  Container(
                    height: MediaQuery.of(context).size.height - 230,
                    child: RefreshIndicator(
                      onRefresh: () => Future.sync(
                        () => homeController.pagingController.refresh(),
                      ),
                      child: PagedListView<int, dynamic>(
                        pagingController: homeController.pagingController,
                        builderDelegate: PagedChildBuilderDelegate<dynamic>(
                            itemBuilder: (context, item, index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: UpcomingTripCard(
                                      isSearchedTrip: false,
                                      tripId: homeController
                                          .pagingController.itemList!
                                          .elementAt(index)
                                          .tripId,
                                      userId: homeController
                                          .pagingController.itemList!
                                          .elementAt(index)
                                          .userId,
                                      avatarUrl: homeController
                                          .pagingController.itemList!
                                          .elementAt(index)
                                          .avatarUrl,
                                      name: homeController
                                          .pagingController.itemList!
                                          .elementAt(index)
                                          .name,
                                      phoneNo: homeController
                                          .pagingController.itemList!
                                          .elementAt(index)
                                          .phoneNo,
                                      bookTime: homeController
                                          .pagingController.itemList!
                                          .elementAt(index)
                                          .bookTime,
                                      departureStation: homeController
                                          .pagingController.itemList!
                                          .elementAt(index)
                                          .departureStation,
                                      destinationStation: homeController
                                          .pagingController.itemList!
                                          .elementAt(index)
                                          .destinationStation),
                                ),
                            noItemsFoundIndicatorBuilder:
                                (BuildContext context) {
                              return Text(CustomStrings.kNoUpcomingTrips.tr);
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
