import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
import 'package:bikes_user/app/ui/android/widgets/others/LazyLoadingListErrorBuilder.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
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

    return Padding(
      padding: EdgeInsets.fromLTRB(22.0, 40.0, 22.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _roleActivity,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  IconButton(
                      onPressed: () => Get.toNamed(CommonRoutes.TRIP_HISTORY),
                      icon: Icon(
                        Icons.history,
                        color: CustomColors.kBlue,
                      ))
                ]),
          ),
          Obx(() {
            if (homeController.isUpcomingTripsLoading.isTrue) {
              return Loading();
            } else {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: RefreshIndicator(
                    onRefresh: () {
                      homeController.upcomingTrips.clear();
                      return Future.sync(
                        () => homeController.pagingController.refresh(),
                      );
                    },
                    child: PagedListView<int, dynamic>(
                      pagingController: homeController.pagingController,
                      shrinkWrap: true,
                      builderDelegate: PagedChildBuilderDelegate<dynamic>(
                          animateTransitions: true,
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
                          noItemsFoundIndicatorBuilder: (BuildContext context) {
                            return Text(CustomStrings.kNoUpcomingTrips.tr);
                          },
                          firstPageErrorIndicatorBuilder:
                              (BuildContext context) {
                            return LazyLoadingListErrorBuilder(onPressed: () {
                              homeController.pagingController.refresh();
                            });
                          }),
                    ),
                  ),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
