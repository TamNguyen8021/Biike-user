import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/ui/android/widgets/others/ad_container.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
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
    return GetBuilder(
        init: homeController,
        builder: (_) {
          return FutureBuilder(
            future: Biike.role.value == Role.keer
                ? homeController.getUpcomingTrips()
                : homeController.getStations(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                late DateTime _firstTripTimeBook;
                DateTime _currentTime = DateTime.now();
                String _timeLeft = '';

                if (homeController.upcomingTrips.isNotEmpty) {
                  _firstTripTimeBook = DateTime.parse(
                      homeController.upcomingTrips.toList()[0].bookTime);
                  if (_firstTripTimeBook.hour - _currentTime.hour > 0) {
                    _timeLeft = _timeLeft +
                        (_firstTripTimeBook.hour - _currentTime.hour)
                            .toString() +
                        CustomStrings.kReminderHour.tr;
                  }

                  if (_timeLeft.isNotEmpty) {
                    _timeLeft = _timeLeft +
                        (_firstTripTimeBook.minute - _currentTime.minute)
                            .abs()
                            .toString() +
                        CustomStrings.kReminderMinute.tr +
                        CustomStrings.kReminderLeft.tr;
                  } else if (_firstTripTimeBook.hour == _currentTime.hour &&
                      _firstTripTimeBook.minute - _currentTime.minute > 0) {
                    _timeLeft = _timeLeft +
                        (_firstTripTimeBook.minute - _currentTime.minute)
                            .toString() +
                        CustomStrings.kReminderMinute.tr +
                        CustomStrings.kReminderLeft.tr;
                  }
                }
                return Scaffold(
                  body: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                22.0, 22.0, 22.0, 0.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: TopBiker(),
                                  ),
                                  if (homeController
                                      .upcomingTrips.isNotEmpty) ...[
                                    if (_firstTripTimeBook.day ==
                                            _currentTime.day &&
                                        _firstTripTimeBook.month ==
                                            _currentTime.month &&
                                        _firstTripTimeBook.year ==
                                            _currentTime.year) ...[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
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
                                                  color:
                                                      CustomColors.kDarkGray),
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
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: UpcomingTripCard(
                                            tripId: homeController.upcomingTrips
                                                .toList()[0]
                                                .tripId,
                                            userId: homeController.upcomingTrips
                                                .toList()[0]
                                                .userId,
                                            backgroundColor: CustomColors.kBlue,
                                            foregroundColor: Colors.white,
                                            iconColor: Colors.white,
                                            avatarUrl: homeController
                                                .upcomingTrips
                                                .toList()[0]
                                                .avatarUrl,
                                            name: homeController.upcomingTrips
                                                .toList()[0]
                                                .name,
                                            phoneNo: homeController
                                                .upcomingTrips
                                                .toList()[0]
                                                .phoneNo,
                                            bookTime: homeController
                                                .upcomingTrips
                                                .toList()[0]
                                                .bookTime,
                                            departureStation: homeController
                                                .upcomingTrips
                                                .toList()[0]
                                                .departureStation,
                                            destinationStation: homeController
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
                                          ),
                                          ContactButtons(
                                            phoneNo: homeController
                                                .upcomingTrips
                                                .toList()[0]
                                                .phoneNo,
                                          )
                                        ],
                                      ),
                                    ],
                                  ]
                                ]),
                          ),
                          if (homeController.upcomingTrips.isNotEmpty ||
                              Biike.role.value == Role.biker) ...[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Divider(),
                            ),
                            if (Biike.role.value == Role.keer) ...[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AdContainer(),
                                    if (homeController.upcomingTrips.length >
                                        1) ...[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8.0, top: 35.0),
                                        child: Text(
                                          CustomStrings.kUpcomingTrips.tr,
                                          style: TextStyle(
                                              color: CustomColors.kDarkGray),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        margin: EdgeInsets.only(
                                            bottom: homeController
                                                        .upcomingTrips.length >
                                                    2
                                                ? 70.0
                                                : 0.0),
                                        child: RefreshIndicator(
                                          onRefresh: () => Future.sync(
                                            () => homeController
                                                .pagingController
                                                .refresh(),
                                          ),
                                          child: PagedListView<int, dynamic>(
                                            pagingController:
                                                homeController.pagingController,
                                            builderDelegate:
                                                PagedChildBuilderDelegate<
                                                        dynamic>(
                                                    itemBuilder: (context, item,
                                                            index) =>
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 10.0),
                                                          child: UpcomingTripCard(
                                                              tripId: homeController
                                                                  .pagingController
                                                                  .itemList!
                                                                  .elementAt(
                                                                      index)
                                                                  .tripId,
                                                              userId: homeController
                                                                  .pagingController
                                                                  .itemList!
                                                                  .elementAt(
                                                                      index)
                                                                  .userId,
                                                              avatarUrl:
                                                                  homeController
                                                                      .pagingController
                                                                      .itemList!
                                                                      .elementAt(
                                                                          index)
                                                                      .avatarUrl,
                                                              name: homeController
                                                                  .pagingController
                                                                  .itemList!
                                                                  .elementAt(
                                                                      index)
                                                                  .name,
                                                              phoneNo: homeController
                                                                  .pagingController
                                                                  .itemList!
                                                                  .elementAt(
                                                                      index)
                                                                  .phoneNo,
                                                              bookTime: homeController
                                                                  .pagingController
                                                                  .itemList!
                                                                  .elementAt(index)
                                                                  .bookTime,
                                                              departureStation: homeController.pagingController.itemList!.elementAt(index).departureStation,
                                                              destinationStation: homeController.pagingController.itemList!.elementAt(index).destinationStation),
                                                        ),
                                                    noItemsFoundIndicatorBuilder:
                                                        (BuildContext context) {
                                                      return Text(CustomStrings
                                                          .kNoUpcomingTrips.tr);
                                                    }),
                                          ),
                                        ),
                                      ),
                                    ]
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
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(CustomStrings.kFilter.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2),
                                    ),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Container(
                                                width: 110,
                                                decoration: BoxDecoration(
                                                    color:
                                                        CustomColors.kLightGray,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                        color: CustomColors
                                                            .kDarkGray
                                                            .withOpacity(0.4),
                                                        // changes position of shadow
                                                        offset: Offset(0, 1),
                                                      )
                                                    ]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Obx(
                                                        () => GestureDetector(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .event_outlined,
                                                                ),
                                                              ),
                                                              Text(
                                                                homeController
                                                                    .searchDateString
                                                                    .value,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1,
                                                              ),
                                                            ],
                                                          ),
                                                          onTap: () async {
                                                            homeController
                                                                .searchDateString
                                                                .value = DateFormat(
                                                                    'dd-MM-yyyy')
                                                                .format(await CommonFunctions().selectDate(
                                                                    context:
                                                                        context,
                                                                    selectedDate:
                                                                        homeController
                                                                            .searchDate,
                                                                    isBirthDatePicker:
                                                                        false));
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
                                                                        right:
                                                                            5.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .access_time,
                                                                ),
                                                              ),
                                                              Text(
                                                                homeController
                                                                    .searchTimeString
                                                                    .value,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1,
                                                              ),
                                                            ],
                                                          ),
                                                          onTap: () async {
                                                            homeController
                                                                    .searchTimeString
                                                                    .value =
                                                                await CommonFunctions().selectTime(
                                                                    context:
                                                                        context,
                                                                    selectedTime:
                                                                        homeController
                                                                            .searchTime);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                          Expanded(
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                    color:
                                                        CustomColors.kLightGray,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
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
                                                          GestureDetector(
                                                            child: Text(
                                                              CustomStrings
                                                                  .kSelectSourceStation
                                                                  .tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                            ),
                                                            onTap: () {
                                                              homeController
                                                                  .showStationsDialog(
                                                                      context:
                                                                          context);
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Divider(),
                                                          ),
                                                          GestureDetector(
                                                            child: Text(
                                                              CustomStrings
                                                                  .kSelectDestinationStation
                                                                  .tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                            ),
                                                            onTap: () {
                                                              homeController
                                                                  .showStationsDialog(
                                                                      context:
                                                                          context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.swap_vert_sharp,
                                                      size: 30,
                                                    ),
                                                  ],
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    22.0,
                                    5.0,
                                    22.0,
                                    homeController.upcomingTrips.length > 2
                                        ? 35.0
                                        : 8.0),
                                child: Column(
                                  children: <Widget>[
                                    // if (homeController.upcomingTrips.isNotEmpty) ...[
                                    //   ListUpcomingTrips(
                                    //     listUpcomingTrips:
                                    //         homeController.upcomingTrips.toList(),
                                    //     itemPadding: 12.0,
                                    //   ),
                                    // ],
                                  ],
                                ),
                              ),
                            ]
                          ] else ...[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                              child:
                                  SvgPicture.asset('assets/images/blank.svg'),
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
                            if (homeController.upcomingTrips.isEmpty) ...[
                              CustomPaint(
                                foregroundPainter: TooltipPainter(),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  margin: const EdgeInsets.only(
                                      bottom: 20.0, left: 22.0, right: 22.0),
                                  decoration: BoxDecoration(
                                    color: CustomColors.kLightGray,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    CustomStrings.kCreateTrip.tr,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ),
                            ],
                            CreateTripButton(),
                          ],
                        )
                      : null,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                );
              } else {
                return Loading();
              }
            },
          );
        });
  }
}
