import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/home/widgets/list_upcoming_trips.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/create_trip_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/switch_role_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/LazyLoadingListErrorBuilder.dart';
import 'package:bikes_user/app/ui/android/widgets/others/ad_container.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/android/widgets/others/top_biker.dart';
import 'package:bikes_user/app/ui/android/widgets/painters/tooltip_painter.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/contact_buttons.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/confirm_arrival_button.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

/// The home screen widget
class Home extends StatelessWidget {
  final _profileController = Get.find<ProfileController>();
  final HomeController homeController;
  final TripDetailsController tripDetailsController;

  Home(
      {Key? key,
      required this.homeController,
      required this.tripDetailsController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<bool> isProfileLoading = true.obs;
    DateTime firstTripTimeBook = DateTime.now();
    DateTime currentTime = DateTime.now();
    String timeLeft = '';

    return FutureBuilder(
        future: _profileController.getProfile(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            isProfileLoading.value = false;
          }

          return Scaffold(
            appBar: CustomAppBar(
              hasShape: true,
              hasLeading: false,
              onPressedFunc: () {},
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
                        route: CommonRoutes.HOME,
                        isOnProfilePage: false,
                      ),
                    ),
                  ],
                ),
              ),
              actionWidgets: <Widget>[
                IconButton(
                    onPressed: () => Get.toNamed(CommonRoutes.NOTIFICATION),
                    icon: Icon(Icons.notifications)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 16.0, 20.0, 16.0),
                  child: Obx(() {
                    if (isProfileLoading.isTrue) {
                      return SizedBox(
                          height: 3,
                          width: 20,
                          child: CircularProgressIndicator());
                    } else {
                      return CircularProfileAvatar(
                        _profileController.user.avatar,
                        radius: 12,
                        onTap: () {
                          Get.toNamed(CommonRoutes.PROFILE);
                        },
                      );
                    }
                  }),
                ),
              ],
            ),
            body: Obx(() {
              if (homeController.isUpcomingTripsLoading.isTrue) {
                return Loading();
              } else {
                timeLeft = '';
                if (homeController.upcomingTrips.isNotEmpty) {
                  firstTripTimeBook = DateTime.tryParse(
                          homeController.upcomingTrips[0].bookTime) ??
                      DateTime.now();
                  if (firstTripTimeBook.hour - currentTime.hour > 0) {
                    timeLeft = timeLeft +
                        (firstTripTimeBook.hour - currentTime.hour).toString() +
                        CustomStrings.kReminderHour.tr;
                  }

                  if (timeLeft.isNotEmpty) {
                    timeLeft = timeLeft +
                        (firstTripTimeBook.minute - currentTime.minute)
                            .abs()
                            .toString() +
                        CustomStrings.kReminderMinute.tr +
                        CustomStrings.kReminderLeft.tr;
                  } else if (firstTripTimeBook.hour == currentTime.hour &&
                      firstTripTimeBook.minute - currentTime.minute > 0) {
                    timeLeft = timeLeft +
                        (firstTripTimeBook.minute - currentTime.minute)
                            .toString() +
                        CustomStrings.kReminderMinute.tr +
                        CustomStrings.kReminderLeft.tr;
                  }
                }

                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 0.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (Biike.role.value == Role.biker) ...[
                                GestureDetector(
                                  child: Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      decoration: BoxDecoration(
                                          color: CustomColors.kLightBlue,
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      )),
                                  onTap: () =>
                                      Get.toNamed(CommonRoutes.CHO_NOW),
                                )
                              ],
                              TopBiker(),
                              if (homeController.upcomingTrips.isNotEmpty) ...[
                                if (firstTripTimeBook.day == currentTime.day &&
                                    firstTripTimeBook.month ==
                                        currentTime.month &&
                                    firstTripTimeBook.year ==
                                        currentTime.year) ...[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 20.0),
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
                                          timeLeft,
                                          style: TextStyle(
                                              color: CustomColors.kBlue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  UpcomingTripCard(
                                      isSearchedTrip: false,
                                      tripId: homeController
                                          .upcomingTrips[0].tripId,
                                      userId: homeController
                                          .upcomingTrips[0].userId,
                                      backgroundColor: CustomColors.kBlue,
                                      foregroundColor: Colors.white,
                                      iconColor: Colors.white,
                                      avatarUrl: homeController
                                          .upcomingTrips[0].avatarUrl,
                                      name:
                                          homeController.upcomingTrips[0].name,
                                      phoneNo: homeController
                                          .upcomingTrips[0].phoneNo,
                                      bookTime: homeController
                                          .upcomingTrips[0].bookTime,
                                      departureStation: homeController
                                          .upcomingTrips[0].departureStation,
                                      destinationStation: homeController
                                          .upcomingTrips[0].destinationStation),
                                  if (homeController.upcomingTrips[0].name !=
                                      CustomStrings.kFinding) ...[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          ConfirmArrivalButton(
                                            tripDetailsController:
                                                tripDetailsController,
                                            tripId: homeController
                                                .upcomingTrips[0].tripId,
                                          ),
                                          ContactButtons(
                                            phoneNo: homeController
                                                .upcomingTrips[0].phoneNo,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ]
                            ]),
                      ),
                      if (homeController.upcomingTrips.isNotEmpty ||
                          Biike.role.value == Role.biker) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Divider(),
                        ),
                        if (Biike.role.value == Role.keer) ...[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AdContainer(),
                                if (homeController
                                    .upcomingTrips.isNotEmpty) ...[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 16.0),
                                    child: Text(
                                      CustomStrings.kUpcomingTrips.tr,
                                      style: TextStyle(
                                          color: CustomColors.kDarkGray),
                                    ),
                                  ),
                                  Container(
                                    height: homeController
                                                .upcomingTrips.length >
                                            2
                                        ? MediaQuery.of(context).size.height / 2
                                        : null,
                                    margin: const EdgeInsets.only(bottom: 75.0),
                                    child: RefreshIndicator(
                                      onRefresh: () => Future.sync(
                                        () => homeController.pagingController
                                            .refresh(),
                                      ),
                                      child: PagedListView<int, dynamic>(
                                        pagingController:
                                            homeController.pagingController,
                                        shrinkWrap: true,
                                        builderDelegate:
                                            PagedChildBuilderDelegate<dynamic>(
                                                animateTransitions: true,
                                                itemBuilder:
                                                    (context, item, index) {
                                                  if (index == 0 &&
                                                      (firstTripTimeBook.day ==
                                                              currentTime.day &&
                                                          firstTripTimeBook
                                                                  .month ==
                                                              currentTime
                                                                  .month &&
                                                          firstTripTimeBook
                                                                  .year ==
                                                              currentTime
                                                                  .year)) {
                                                    return SizedBox.shrink();
                                                  } else {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10.0),
                                                      child: UpcomingTripCard(
                                                          isSearchedTrip: false,
                                                          tripId: homeController
                                                              .pagingController
                                                              .itemList!
                                                              .elementAt(index)
                                                              .tripId,
                                                          userId: homeController
                                                              .pagingController
                                                              .itemList!
                                                              .elementAt(index)
                                                              .userId,
                                                          avatarUrl: homeController
                                                              .pagingController
                                                              .itemList!
                                                              .elementAt(index)
                                                              .avatarUrl,
                                                          name: homeController
                                                              .pagingController
                                                              .itemList!
                                                              .elementAt(index)
                                                              .name,
                                                          phoneNo: homeController
                                                              .pagingController
                                                              .itemList!
                                                              .elementAt(index)
                                                              .phoneNo,
                                                          bookTime: homeController
                                                              .pagingController
                                                              .itemList!
                                                              .elementAt(index)
                                                              .bookTime,
                                                          departureStation: homeController
                                                              .pagingController
                                                              .itemList!
                                                              .elementAt(index)
                                                              .departureStation,
                                                          destinationStation: homeController.pagingController.itemList!.elementAt(index).destinationStation),
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
                                                    homeController
                                                        .pagingController
                                                        .refresh();
                                                  });
                                                }),
                                      ),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            width: 110,
                                            margin: const EdgeInsets.only(
                                                right: 8.0),
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
                                                                  right: 5.0),
                                                          child: Icon(
                                                            Icons
                                                                .event_outlined,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            homeController
                                                                .searchDateString
                                                                .value,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () async {
                                                      homeController.searchDate
                                                              .value =
                                                          await CommonFunctions().selectDate(
                                                              context: context,
                                                              selectedDate:
                                                                  homeController
                                                                      .searchDate,
                                                              isBirthDatePicker:
                                                                  false);
                                                      homeController
                                                          .searchDateString
                                                          .value = DateFormat(
                                                              'dd-MM-yyyy')
                                                          .format(homeController
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
                                                        Expanded(
                                                          child: Text(
                                                            homeController
                                                                .searchTimeString
                                                                .value,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1,
                                                          ),
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
                                                                      homeController
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
                                                        homeController
                                                                .searchTimeString
                                                                .value =
                                                            MaterialLocalizations
                                                                    .of(context)
                                                                .formatTimeOfDay(
                                                                    tempTime,
                                                                    alwaysUse24HourFormat:
                                                                        true);
                                                      } else {
                                                        CommonFunctions()
                                                            .showErrorDialog(
                                                                context:
                                                                    context,
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  color:
                                                      CustomColors.kLightGray,
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
                                                              homeController
                                                                  .departureStationName
                                                                  .value,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                            ),
                                                            onTap: () {
                                                              homeController
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
                                                              homeController
                                                                  .destinationStationName
                                                                  .value,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                            ),
                                                            onTap: () {
                                                              homeController
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
                                                      homeController
                                                          .swapStations();
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
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: CustomTextButton(
                                          width: 120,
                                          backgroundColor:
                                              CustomColors.kLightGray,
                                          foregroundColor:
                                              CustomColors.kDarkGray,
                                          text: CustomStrings.kSearchAgain.tr,
                                          onPressedFunc: () {
                                            homeController.upcomingTripsForBiker
                                                .clear();
                                            homeController.hasSearchedTrips =
                                                false;
                                            homeController
                                                    .searchDateString.value =
                                                CustomStrings.kChooseDate.tr;
                                            homeController
                                                    .searchTimeString.value =
                                                CustomStrings.kChooseTime.tr;
                                            homeController.departureStation
                                                .value.stationId = -1;
                                            homeController.departureStationName
                                                .value = homeController
                                                    .departureStation
                                                    .value
                                                    .name =
                                                CustomStrings
                                                    .kSelectSourceStation.tr;
                                            homeController.destinationStation
                                                .value.stationId = -1;
                                            homeController
                                                .destinationStationName
                                                .value = homeController
                                                    .destinationStation
                                                    .value
                                                    .name =
                                                CustomStrings
                                                    .kSelectDestinationStation
                                                    .tr;
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
                                          onPressedFunc: () {
                                            homeController
                                                .verifyPhoneBeforeBookOrSearchStrip(
                                              context: context,
                                              onSuccess: () {
                                                homeController
                                                    .hasSearchedTrips = true;
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
                            padding: EdgeInsets.fromLTRB(
                                22.0,
                                5.0,
                                22.0,
                                homeController.upcomingTripsForBiker.length > 2
                                    ? 35.0
                                    : 8.0),
                            child: Obx(
                              () {
                                return FutureBuilder(
                                    future: homeController.searchTrips(
                                        date: homeController.searchDate.value,
                                        time: homeController.searchTime.value,
                                        departureId: homeController
                                            .departureStation.value.stationId,
                                        destinationId: homeController
                                            .destinationStation
                                            .value
                                            .stationId),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return ListUpcomingTrips(
                                            listUpcomingTrips: homeController
                                                .upcomingTripsForBiker
                                                .toList(),
                                            itemPadding: 10.0,
                                            hasSearchTrips: homeController
                                                .hasSearchedTrips);
                                      } else {
                                        return Loading();
                                      }
                                    });
                              },
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
                );
              }
            }),
            floatingActionButton: Obx(() {
              if (homeController.isUpcomingTripsLoading.isFalse) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if (homeController.upcomingTrips.isEmpty) ...[
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
                      createTrip: () {
                        homeController.verifyPhoneBeforeBookOrSearchStrip(
                            context: context,
                            onSuccess: () =>
                                Get.toNamed(CommonRoutes.BOOK_TRIP));
                      },
                    ),
                  ],
                );
              } else {
                return SizedBox.shrink();
              }
            }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        });
  }
}
