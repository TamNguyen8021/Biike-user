import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/home/widgets/list_upcoming_trips.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/LazyLoadingListErrorBuilder.dart';
import 'package:bikes_user/app/ui/android/widgets/others/ad_container.dart';
import 'package:bikes_user/app/ui/android/widgets/others/top_biker.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/contact_buttons.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/create_trip_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/confirm_arrival_button.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
import 'package:bikes_user/app/ui/android/widgets/painters/tooltip_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

/// The home screen widget
class Home extends StatelessWidget {
  final HomeController homeController;

  const Home({Key? key, required this.homeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late DateTime _firstTripTimeBook;
    DateTime _currentTime = DateTime.now();
    String _timeLeft = '';

    if (homeController.upcomingTrips.isNotEmpty) {
      _firstTripTimeBook = DateTime.tryParse(
              homeController.upcomingTrips.toList()[0].bookTime) ??
          DateTime.now();
      if (_firstTripTimeBook.hour - _currentTime.hour > 0) {
        _timeLeft = _timeLeft +
            (_firstTripTimeBook.hour - _currentTime.hour).toString() +
            CustomStrings.kReminderHour.tr;
      }

      if (_timeLeft.isNotEmpty) {
        _timeLeft = _timeLeft +
            (_firstTripTimeBook.minute - _currentTime.minute).abs().toString() +
            CustomStrings.kReminderMinute.tr +
            CustomStrings.kReminderLeft.tr;
      } else if (_firstTripTimeBook.hour == _currentTime.hour &&
          _firstTripTimeBook.minute - _currentTime.minute > 0) {
        _timeLeft = _timeLeft +
            (_firstTripTimeBook.minute - _currentTime.minute).toString() +
            CustomStrings.kReminderMinute.tr +
            CustomStrings.kReminderLeft.tr;
      }
    }

    return GetBuilder<HomeController>(
        init: homeController,
        builder: (HomeController controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 0.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            if (Biike.role.value == Role.biker) ...[
                              GestureDetector(
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 8.0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    decoration: BoxDecoration(
                                        color: CustomColors.kLightBlue,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Image.asset(
                                            'assets/images/fire.png',
                                            height: 20,
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                          CustomStrings.kNoKeNowTrip.tr,
                                        )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                        )
                                      ],
                                    )),
                                onTap: () => Get.toNamed(CommonRoutes.CHO_NOW),
                              )
                            ],
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: TopBiker(),
                            ),
                            if (controller.upcomingTrips.isNotEmpty) ...[
                              if (_firstTripTimeBook.day == _currentTime.day &&
                                  _firstTripTimeBook.month ==
                                      _currentTime.month &&
                                  _firstTripTimeBook.year ==
                                      _currentTime.year) ...[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        Biike.role.value == Role.keer
                                            ? CustomStrings
                                                .kKeerReadyReminder.tr
                                            : CustomStrings
                                                .kBikerReadyReminder.tr,
                                        style: TextStyle(
                                            color: CustomColors.kDarkGray),
                                      ),
                                      Text(
                                        _timeLeft,
                                        style: TextStyle(
                                            color: CustomColors.kBlue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: UpcomingTripCard(
                                      isSearchedTrip: false,
                                      tripId: controller.upcomingTrips
                                          .toList()[0]
                                          .tripId,
                                      userId: controller.upcomingTrips
                                          .toList()[0]
                                          .userId,
                                      backgroundColor: CustomColors.kBlue,
                                      foregroundColor: Colors.white,
                                      iconColor: Colors.white,
                                      avatarUrl: controller.upcomingTrips
                                          .toList()[0]
                                          .avatarUrl,
                                      name: controller.upcomingTrips
                                          .toList()[0]
                                          .name,
                                      phoneNo: controller.upcomingTrips
                                          .toList()[0]
                                          .phoneNo,
                                      bookTime: controller.upcomingTrips
                                          .toList()[0]
                                          .bookTime,
                                      departureStation: controller.upcomingTrips
                                          .toList()[0]
                                          .departureStation,
                                      destinationStation: controller
                                          .upcomingTrips
                                          .toList()[0]
                                          .destinationStation),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ConfirmArrivalButton(
                                      isOnHomeScreen: true,
                                      tripId: controller.upcomingTrips
                                          .toList()[0]
                                          .tripId,
                                    ),
                                    ContactButtons(
                                      phoneNo: controller.upcomingTrips
                                          .toList()[0]
                                          .phoneNo,
                                    )
                                  ],
                                ),
                              ],
                            ]
                          ]),
                    ),
                    if (controller.upcomingTrips.isNotEmpty ||
                        Biike.role.value == Role.biker) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Divider(),
                      ),
                      if (Biike.role.value == Role.keer) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AdContainer(),
                              if (controller.upcomingTrips.isNotEmpty) ...[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, top: 35.0),
                                  child: Text(
                                    CustomStrings.kUpcomingTrips.tr,
                                    style: TextStyle(
                                        color: CustomColors.kDarkGray),
                                  ),
                                ),
                                RefreshIndicator(
                                  onRefresh: () => Future.sync(
                                    () => controller.pagingController.refresh(),
                                  ),
                                  child: PagedListView<int, dynamic>(
                                    pagingController:
                                        controller.pagingController,
                                    shrinkWrap: true,
                                    builderDelegate: PagedChildBuilderDelegate<
                                            dynamic>(
                                        animateTransitions: true,
                                        itemBuilder: (context, item, index) {
                                          if (index == 0 &&
                                              (_firstTripTimeBook.day ==
                                                      _currentTime.day &&
                                                  _firstTripTimeBook.month ==
                                                      _currentTime.month &&
                                                  _firstTripTimeBook.year ==
                                                      _currentTime.year)) {
                                            return SizedBox.shrink();
                                          } else {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: UpcomingTripCard(
                                                  isSearchedTrip: false,
                                                  tripId: controller.pagingController.itemList!
                                                      .elementAt(index)
                                                      .tripId,
                                                  userId: controller.pagingController.itemList!
                                                      .elementAt(index)
                                                      .userId,
                                                  avatarUrl: controller
                                                      .pagingController
                                                      .itemList!
                                                      .elementAt(index)
                                                      .avatarUrl,
                                                  name: controller.pagingController.itemList!
                                                      .elementAt(index)
                                                      .name,
                                                  phoneNo: controller.pagingController.itemList!
                                                      .elementAt(index)
                                                      .phoneNo,
                                                  bookTime: controller.pagingController.itemList!
                                                      .elementAt(index)
                                                      .bookTime,
                                                  departureStation: controller
                                                      .pagingController
                                                      .itemList!
                                                      .elementAt(index)
                                                      .departureStation,
                                                  destinationStation: controller
                                                      .pagingController
                                                      .itemList!
                                                      .elementAt(index)
                                                      .destinationStation),
                                            );
                                          }
                                        },
                                        noItemsFoundIndicatorBuilder:
                                            (BuildContext context) {
                                          return Text(CustomStrings
                                              .kNoUpcomingTrips.tr);
                                        },
                                        firstPageErrorIndicatorBuilder:
                                            (BuildContext context) {
                                          return LazyLoadingListErrorBuilder(
                                              onPressed: () {
                                            controller.pagingController
                                                .refresh();
                                          });
                                        }),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        )
                      ] else ...[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(CustomStrings.kFilter.tr,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          width: 110,
                                          margin:
                                              const EdgeInsets.only(right: 8.0),
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              color: CustomColors.kLightGray,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: CustomColors.kDarkGray
                                                      .withOpacity(0.4),
                                                  // changes position of shadow
                                                  offset: Offset(0, 1),
                                                )
                                              ]),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Obx(
                                                () => GestureDetector(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 5.0),
                                                        child: Icon(
                                                          Icons.event_outlined,
                                                        ),
                                                      ),
                                                      Text(
                                                        controller
                                                            .searchDateString
                                                            .value,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1,
                                                      ),
                                                    ],
                                                  ),
                                                  onTap: () async {
                                                    controller.searchDate.value =
                                                        await CommonFunctions()
                                                            .selectDate(
                                                                context:
                                                                    context,
                                                                selectedDate:
                                                                    controller
                                                                        .searchDate,
                                                                isBirthDatePicker:
                                                                    false);
                                                    controller.searchDateString
                                                            .value =
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(controller
                                                                .searchDate
                                                                .value!);
                                                  },
                                                ),
                                              ),
                                              Divider(),
                                              Obx(
                                                () => GestureDetector(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 5.0),
                                                        child: Icon(
                                                          Icons.access_time,
                                                        ),
                                                      ),
                                                      Text(
                                                        controller
                                                            .searchTimeString
                                                            .value,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1,
                                                      ),
                                                    ],
                                                  ),
                                                  onTap: () async {
                                                    TimeOfDay tempTime =
                                                        await CommonFunctions()
                                                            .selectTime(
                                                                context:
                                                                    context,
                                                                selectedTime:
                                                                    controller
                                                                        .searchTime);
                                                    int tempTimeNum =
                                                        tempTime.hour * 60 +
                                                            tempTime.minute;
                                                    int lowestBoundTimeNum =
                                                        5 * 60;
                                                    int highestBoundTimeNum =
                                                        21 * 60;
                                                    if (tempTimeNum >=
                                                            lowestBoundTimeNum &&
                                                        tempTimeNum <=
                                                            highestBoundTimeNum) {
                                                      controller
                                                              .searchTimeString
                                                              .value =
                                                          MaterialLocalizations
                                                                  .of(context)
                                                              .formatTimeOfDay(
                                                                  tempTime,
                                                                  alwaysUse24HourFormat:
                                                                      true);
                                                    } else {
                                                      CommonFunctions().showErrorDialog(
                                                          context: context,
                                                          message:
                                                              CustomErrorsString
                                                                  .kTripCanOnlySearchFrom5AMTo9PM
                                                                  .tr);
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                color: CustomColors.kLightGray,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                    color: CustomColors
                                                        .kDarkGray
                                                        .withOpacity(0.4),
                                                    // changes position of shadow
                                                    offset: Offset(0, 1),
                                                  )
                                                ]),
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.adjust,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .more_vert_outlined,
                                                      ),
                                                      Icon(
                                                        Icons.location_on,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Obx(
                                                        () => GestureDetector(
                                                          child: Text(
                                                            controller
                                                                .departureStationName
                                                                .value,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1,
                                                          ),
                                                          onTap: () {
                                                            controller
                                                                .showStationsDialog(
                                                                    context:
                                                                        context,
                                                                    isDepartureStation:
                                                                        true);
                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Divider(),
                                                      ),
                                                      Obx(
                                                        () => GestureDetector(
                                                          child: Text(
                                                            controller
                                                                .destinationStationName
                                                                .value,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1,
                                                          ),
                                                          onTap: () {
                                                            controller
                                                                .showStationsDialog(
                                                                    context:
                                                                        context,
                                                                    isDepartureStation:
                                                                        false);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  child: Icon(
                                                    Icons.swap_vert_sharp,
                                                    size: 30,
                                                  ),
                                                  onTap: () {
                                                    controller.swapStations();
                                                  },
                                                ),
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: CustomTextButton(
                                        width: 120,
                                        backgroundColor:
                                            CustomColors.kLightGray,
                                        foregroundColor: CustomColors.kDarkGray,
                                        text: CustomStrings.kSearchAgain.tr,
                                        onPressedFunc: () {
                                          controller.upcomingTripsForBiker
                                              .clear();
                                          controller.hasSearchedTrips = false;
                                          controller.searchDateString.value =
                                              CustomStrings.kChooseDate.tr;
                                          controller.searchTimeString.value =
                                              CustomStrings.kChooseTime.tr;
                                          controller.departureStation.value
                                              .stationId = -1;
                                          controller.departureStationName
                                              .value = controller
                                                  .departureStation.value.name =
                                              CustomStrings
                                                  .kSelectSourceStation.tr;
                                          controller.destinationStation.value
                                              .stationId = -1;
                                          controller.destinationStationName
                                              .value = controller
                                                  .destinationStation
                                                  .value
                                                  .name =
                                              CustomStrings
                                                  .kSelectDestinationStation.tr;
                                        },
                                        hasBorder: false),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CustomTextButton(
                                        width: 120,
                                        backgroundColor: CustomColors.kBlue,
                                        foregroundColor: Colors.white,
                                        text: CustomStrings.kSearch.tr,
                                        onPressedFunc: () async {
                                          controller
                                              .verifyPhoneBeforeBookOrSearchStrip(
                                            context: context,
                                            onSuccess: () async {
                                              await controller.searchTrips(
                                                  date: controller
                                                      .searchDate.value,
                                                  time: controller
                                                      .searchTime.value,
                                                  departureId: controller
                                                      .departureStation
                                                      .value
                                                      .stationId,
                                                  destinationId: controller
                                                      .destinationStation
                                                      .value
                                                      .stationId);
                                            },
                                          );
                                        },
                                        hasBorder: false),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(22.0, 5.0, 22.0,
                              controller.upcomingTrips.length > 2 ? 35.0 : 8.0),
                          child: Obx(
                            () => ListUpcomingTrips(
                                listUpcomingTrips:
                                    controller.upcomingTripsForBiker.toList(),
                                itemPadding: 10.0,
                                hasSearchTrips: controller.hasSearchedTrips),
                          ),
                        ),
                      ]
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22.0),
                        child: SvgPicture.asset('assets/images/blank.svg'),
                      ),
                    ]
                  ],
                ),
              ),
            ),
            floatingActionButton: Biike.role.value == Role.keer
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if (controller.upcomingTrips.isEmpty) ...[
                        CustomPaint(
                          foregroundPainter: TooltipPainter(),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            margin: const EdgeInsets.only(
                                bottom: 20.0, left: 22.0, right: 22.0),
                            decoration: BoxDecoration(
                              color: CustomColors.kLightGray,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              CustomStrings.kCreateTrip.tr,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ],
                      CreateTripButton(
                        createTrip: () =>
                            controller.verifyPhoneBeforeBookOrSearchStrip(
                                context: context,
                                onSuccess: () =>
                                    Get.toNamed(CommonRoutes.BOOK_TRIP)),
                      ),
                    ],
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        });
  }
}
