import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/controllers/trip_history_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/history_trip_card.dart';
import 'package:bikes_user/app/ui/android/widgets/others/LazyLoadingListErrorBuilder.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// The trip history screen
class TripHistoryPage extends StatelessWidget {
  final _tripHistoryController = Get.find<TripHistoryController>();

  TripHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: CustomAppBar(
          hasShape: false,
          appBar: AppBar(),
          hasLeading: true,
          onPressedFunc: () {
            Get.back();
          },
          title: Text(
            CustomStrings.kHistory.tr,
          ),
          bottomAppBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
                BoxShadow(
                  color: CustomColors.kDarkGray.withOpacity(0.3),
                  blurRadius: 5,
                  // changes position of shadow
                  offset: Offset(0, 4),
                )
              ]),
              child: TabBar(
                unselectedLabelColor: CustomColors.kDarkGray,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                labelColor: CustomColors.kBlue,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                    color: CustomColors.kLightGray,
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                indicatorPadding: const EdgeInsets.all(10.0),
                tabs: <Widget>[
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        Biike.role.value == Role.keer
                            ? CustomStrings.kKeerHistory.tr
                            : CustomStrings.kBikerHistory.tr,
                        style: TextStyle(
                            fontSize: 10.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(22.0),
          child: TabBarView(children: <Widget>[
            GetBuilder<TripHistoryController>(
                init: _tripHistoryController,
                builder: (TripHistoryController controller) {
                  return RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => controller.pagingController.refresh(),
                    ),
                    child: PagedListView<int, HistoryTripCard>(
                      pagingController: controller.pagingController,
                      shrinkWrap: true,
                      builderDelegate: PagedChildBuilderDelegate<
                              HistoryTripCard>(
                          animateTransitions: true,
                          itemBuilder: (context, item, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: HistoryTripCard(
                                  tripId: controller.pagingController.itemList!
                                      .elementAt(index)
                                      .tripId,
                                  userId: controller.pagingController.itemList!
                                      .elementAt(index)
                                      .userId,
                                  dateTime: controller
                                      .pagingController.itemList!
                                      .elementAt(index)
                                      .dateTime,
                                  status: controller.pagingController.itemList!
                                      .elementAt(index)
                                      .status,
                                  sourceStation: controller
                                      .pagingController.itemList!
                                      .elementAt(index)
                                      .sourceStation,
                                  destinationStation: controller
                                      .pagingController.itemList!
                                      .elementAt(index)
                                      .destinationStation,
                                  isOnViewUserPage: false,
                                ),
                              ),
                          noItemsFoundIndicatorBuilder: (BuildContext context) {
                            String _noHistoryMessage = '';

                            switch (Biike.role.value) {
                              case Role.keer:
                                _noHistoryMessage =
                                    CustomStrings.kNoKeerHistoryTrips.tr;
                                break;
                              case Role.biker:
                                _noHistoryMessage =
                                    CustomStrings.kNoBikerHistoryTrips.tr;
                                break;
                              default:
                                _noHistoryMessage =
                                    CustomStrings.kNoHistoryTrip.tr;
                                break;
                            }

                            return Text(_noHistoryMessage);
                          },
                          firstPageErrorIndicatorBuilder:
                              (BuildContext context) {
                            return LazyLoadingListErrorBuilder(onPressed: () {
                              controller.pagingController.refresh();
                            });
                          }),
                    ),
                  );
                }),
          ]),
        ),
      ),
    );
  }
}
