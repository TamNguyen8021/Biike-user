import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_dialog.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_objects/custom_location.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/controllers/trip_history_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/android/widgets/others/map_viewer.dart';
import 'package:bikes_user/app/ui/android/widgets/others/user_rating.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/contact_buttons.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

/// 'trip_details' screen
//ignore: must_be_immutable
class TripDetailsPage extends StatelessWidget {
  final _tripProvider = Get.find<TripProvider>();
  final _tripDetailsController = Get.find<TripDetailsController>();
  final _homeController = Get.find<HomeController>();
  final _tripHistoryController = Get.find<TripHistoryController>();
  final Completer<GoogleMapController> completerController = Completer();

  int tripId = Get.arguments['tripId'];
  String _statusBarTime = '';
  String _statusBarText = '';
  Rx<String> _cancelReason = ''.obs;
  Rx<String> buttonText = CustomStrings.kConfirmArrival.tr.obs;
  Rx<IconData> buttonIcon = Icons.done_all.obs;

  TripDetailsPage({
    Key? key,
  }) : super(key: key);

  Widget _image(String asset) {
    return SvgPicture.asset(
      asset,
      height: 10.0,
      width: 10.0,
    );
  }

  /// Author: TamNTT
  void _addStatusBarTextAndTime() {
    const String _timeFormat = 'HH:mm, dd-MM-yyyy';
    switch (_tripDetailsController.trip.tripStatus) {
      case 5:
        _statusBarText = CustomStrings.kTripHasFinished.tr;
        _statusBarTime = DateFormat(_timeFormat).format(
            DateTime.tryParse(_tripDetailsController.trip.finishedTime)!);
        break;
      default:
        _statusBarText = CustomStrings.kNewTrip.tr;
        _statusBarTime = DateFormat(_timeFormat).format(
            DateTime.tryParse(_tripDetailsController.trip.createdDate)!);
        break;
    }
  }

  /// Author: TamNTT
  Widget _showFeedbacks(
      {required BuildContext context,
      required String title,
      required double star,
      required String feedbackContent}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 22.0, right: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: CustomColors.kDarkGray),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RatingBar(
                    ignoreGestures: true,
                    initialRating: star,
                    minRating: 1,
                    allowHalfRating: false,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                      full: _image('assets/images/full_star.svg'),
                      half: _image(''),
                      empty: _image('assets/images/empty_star.svg'),
                    ),
                    itemPadding: EdgeInsets.only(right: 16.0),
                    onRatingUpdate: (double star) {},
                  ),
                ),
                Text(
                  feedbackContent,
                  style: TextStyle(color: CustomColors.kDarkGray),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Display a dialog on [context] to enter cancel reason.
  ///
  /// Author: TamNTT
  Future<void> _showCancelReasonDialog({required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    CustomStrings.kLetUsKnowYourCancelReason.tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextFormField(
                      maxLines: 10,
                      style: Theme.of(context).textTheme.bodyText1,
                      onChanged: (String text) {
                        _cancelReason.value = text;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        hintText: CustomStrings.kEnterYourCancelReason.tr,
                        filled: true,
                        fillColor: CustomColors.kLightGray,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          CustomTextButton(
                              hasBorder: false,
                              backgroundColor: CustomColors.kRed,
                              foregroundColor: Colors.white,
                              text: CustomStrings.kCancel.tr,
                              onPressedFunc: () async {
                                if (_cancelReason.isNotEmpty) {
                                  await _tripDetailsController.cancelTrip(
                                      context: context,
                                      tripId: tripId,
                                      cancelReason: _cancelReason.value);
                                } else {
                                  AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.ERROR,
                                          headerAnimationLoop: false,
                                          desc: CustomStrings
                                              .kLetUsKnowYourCancelReason.tr)
                                      .show();
                                }
                              }),
                          CustomTextButton(
                              hasBorder: false,
                              backgroundColor: CustomColors.kLightGray,
                              foregroundColor: CustomColors.kDarkGray,
                              text: CustomStrings.kBtnExit.tr,
                              onPressedFunc: () {
                                Get.back();
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _onBackPressed({required BuildContext context}) async {
    // if (_tripDetailsController.isTripStarted.isFalse) {
    if (Get.arguments['route'] == 'home') {
      _homeController.pagingController.refresh();
    } else if (Get.arguments['route'] == 'getTripSuccess') {
      _homeController.upcomingTrips.clear();
      _homeController.pagingController.itemList!.clear();
      _homeController.pagingController.notifyPageRequestListeners(0);
      await _homeController.searchTrips(
          date: _homeController.searchDate.value,
          time: _homeController.searchTime.value,
          departureId: _homeController.departureStation.value.stationId,
          destinationId: _homeController.destinationStation.value.stationId);
    } else {
      _tripHistoryController.pagingController.refresh();
    }
    Get.back();
    // } else {
    //   CommonFunctions().showErrorDialog(
    //       context: context,
    //       message: CustomErrorsString.kCannotGoBackWhenTripStarted.tr);
    // }
  }

  void changeToStartTripButton() {
    if (buttonText.value != CustomStrings.kStart.tr) {
      buttonText.value = CustomStrings.kStart.tr;
    }

    if (buttonIcon.value != Icons.navigation) {
      buttonIcon.value = Icons.navigation;
    }
  }

  void changeToFinishTripButton() {
    if (buttonText.value != CustomStrings.kCompleteTrip.tr) {
      buttonText.value = CustomStrings.kCompleteTrip.tr;
    }

    if (buttonIcon.value != Icons.done_all) {
      buttonIcon.value = Icons.done_all;
    }
  }

  @override
  Widget build(BuildContext context) {
    Rx<bool> isArrivedAtPickUpPoint = false.obs;
    // CustomDialog customDialog = CustomDialog(context: context);

    return OnBackPressed(
      perform: () {
        _onBackPressed(context: context);
      },
      child: GetBuilder<TripDetailsController>(
          init: _tripDetailsController,
          builder: (TripDetailsController controller) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: CustomAppBar(
                hasShape: true,
                hasLeading: true,
                onPressedFunc: () {
                  _onBackPressed(context: context);
                },
                appBar: AppBar(),
                title: Text(CustomStrings.kTripDetails.tr),
                actionWidgets: [
                  GetBuilder<TripDetailsController>(
                      id: 'helpCenter',
                      init: controller,
                      builder: (TripDetailsController controller) {
                        if (controller.trip.tripStatus != 5 &&
                            controller.trip.tripStatus != 6) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 22.0),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                controller.userLocation =
                                    await CommonFunctions.getCurrentLocation();
                                if (controller.userLocation != null) {
                                  controller.showHelpCenter(context: context);
                                } else {
                                  AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.INFO_REVERSED,
                                          headerAnimationLoop: false,
                                          desc: CustomStrings
                                              .kNeedLocationPermission.tr)
                                      .show();
                                }
                              },
                              icon: Icon(
                                Icons.support,
                                color: CustomColors.kBlue,
                              ),
                              label: Text(
                                CustomStrings.kSupport.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: CustomColors.kBlue),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }),
                ],
              ),
              body: FutureBuilder(
                  future: controller.getTripDetails(tripId: tripId),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      CustomLocation departure = CustomLocation(
                          coordinate:
                              controller.departureStation.departureCoordinate);
                      CustomLocation destination = CustomLocation(
                          coordinate: controller
                              .destinationStation.destinationCoordinate);

                      RxSet<Marker> markers = {
                        Marker(
                            markerId: MarkerId('departure'),
                            position:
                                LatLng(departure.latitude, departure.longitude),
                            infoWindow: InfoWindow(
                                title: CustomStrings.kStartLocation.tr,
                                snippet:
                                    controller.departureStation.departureName)),
                        Marker(
                            markerId: MarkerId('destination'),
                            position: LatLng(
                                destination.latitude, destination.longitude),
                            infoWindow: InfoWindow(
                                title: CustomStrings.kEndLocation.tr,
                                snippet: controller
                                    .destinationStation.destinationName),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueGreen)),
                        Marker(
                          markerId: MarkerId('user'),
                          position:
                              LatLng(departure.latitude, departure.longitude),
                        ),
                      }.obs;

                      return FutureBuilder(
                          future: _tripProvider.isArrivedAtPickUpPoint(
                              tripId: tripId),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              DateTime currentTime = DateTime.now();
                              DateTime tempBookTime =
                                  DateTime.tryParse(controller.trip.bookTime)!;

                              _addStatusBarTextAndTime();

                              switch (controller.trip.tripStatus) {
                                case 3:
                                  isArrivedAtPickUpPoint.value = true;

                                  if (Biike.role.value == Role.biker) {
                                    changeToStartTripButton();
                                  }
                                  break;
                                case 4:
                                  if (Biike.role.value == Role.biker) {
                                    changeToFinishTripButton();
                                  }
                                  break;
                                default:
                              }

                              isArrivedAtPickUpPoint.value = snapshot.data;
                              if (isArrivedAtPickUpPoint.isTrue) {
                                if (Biike.role.value == Role.keer) {
                                  buttonText.value =
                                      CustomStrings.kArriveAtDestination.tr;
                                }
                              }

                              return SingleChildScrollView(
                                child: SafeArea(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            22.0, 16.0, 22.0, 0.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  color: CustomColors.kDarkGray
                                                      .withOpacity(0.05),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    _statusBarText,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    _statusBarTime,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (controller.trip.tripStatus !=
                                                    5 &&
                                                controller.trip.tripStatus !=
                                                    6) ...[
                                              // CustomTextButton(
                                              //     backgroundColor: Colors.white,
                                              //     foregroundColor:
                                              //         CustomColors.kBlue,
                                              //     text: 'test',
                                              //     onPressedFunc: () async {
                                              //       await FirebaseFirestore
                                              //           .instance
                                              //           .collection('locations')
                                              //           .add({
                                              //         'tripId': tripId,
                                              //         'userId':
                                              //             Biike.userId.value,
                                              //         'position': Geoflutterfire()
                                              //             .point(
                                              //                 latitude: controller
                                              //                     .userLocation!
                                              //                     .latitude!,
                                              //                 longitude: controller
                                              //                     .userLocation!
                                              //                     .longitude!)
                                              //             .data,
                                              //         'time': DateTime.now()
                                              //       });
                                              //     },
                                              //     hasBorder: false),
                                              Obx(
                                                () => MapViewer(
                                                  isFullMap: false,
                                                  completerController:
                                                      completerController,
                                                  polypoints:
                                                      controller.polypoints,
                                                  departure: departure,
                                                  destination: destination,
                                                  markers: markers.toSet(),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: CustomTextButton(
                                                    hasBorder: true,
                                                    width: double.infinity,
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        CustomColors.kBlue,
                                                    text: CustomStrings
                                                        .kExpandMap.tr,
                                                    onPressedFunc: () {
                                                      Get.toNamed(
                                                          CommonRoutes
                                                              .TRIP_DETAILS_FULL_MAP,
                                                          arguments: {
                                                            'tripId': controller
                                                                .trip.tripId,
                                                            'departure':
                                                                departure,
                                                            'destination':
                                                                destination,
                                                            'markers': markers,
                                                          });
                                                    }),
                                              ),
                                            ],
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0),
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border(
                                                            right: BorderSide(
                                                                color: CustomColors
                                                                    .kDarkGray
                                                                    .withOpacity(
                                                                        0.1))),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          5.0),
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          5.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  bottom:
                                                                      BorderSide(
                                                                    color: CustomColors
                                                                        .kDarkGray
                                                                        .withOpacity(
                                                                            0.1),
                                                                  ),
                                                                ),
                                                              ),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .event_outlined,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8.0),
                                                                    child: Text(
                                                                      DateFormat(
                                                                              'dd/MM/yyyy')
                                                                          .format(DateTime.tryParse(controller
                                                                              .trip
                                                                              .bookTime)!),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          5.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .access_time,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  DateFormat(
                                                                          'HH:mm')
                                                                      .format(DateTime.tryParse(controller
                                                                          .trip
                                                                          .bookTime)!),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .adjust,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    controller
                                                                        .departureStation
                                                                        .departureName,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1,
                                                                  ),
                                                                ],
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .more_vert_outlined,
                                                              ),
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .location_on,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    controller
                                                                        .destinationStation
                                                                        .destinationName,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            if (controller.trip.tripStatus ==
                                                    6 &&
                                                controller.user.userFullname ==
                                                    CustomStrings.kFinding)
                                              ...[]
                                            else ...[
                                              GestureDetector(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 16.0),
                                                  decoration: BoxDecoration(
                                                      color: CustomColors
                                                          .kLightGray,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Row(
                                                    children: <Widget>[
                                                      if (controller.trip
                                                              .tripStatus !=
                                                          1) ...[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 8.0),
                                                          child: CircleAvatar(
                                                            radius: 45,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    controller
                                                                        .user
                                                                        .avatar),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            5.0,
                                                                        top:
                                                                            10.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        controller
                                                                            .user
                                                                            .userFullname,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color:
                                                                                CustomColors.kBlue,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    if (Biike.role.value ==
                                                                            Role
                                                                                .keer &&
                                                                        (controller.trip.tripStatus != 5 &&
                                                                            controller.trip.tripStatus !=
                                                                                6 &&
                                                                            controller.trip.tripStatus !=
                                                                                1)) ...[
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 4.0),
                                                                        child:
                                                                            Text(
                                                                          controller
                                                                              .bike
                                                                              .plateNumber!,
                                                                          style: TextStyle(
                                                                              color: CustomColors.kDarkGray,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ],
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  UserRating(
                                                                      score: controller
                                                                          .user
                                                                          .userStar
                                                                          .toString()),
                                                                  if (Biike.role
                                                                              .value ==
                                                                          Role
                                                                              .keer &&
                                                                      (controller.trip.tripStatus != 5 &&
                                                                          controller.trip.tripStatus !=
                                                                              6 &&
                                                                          controller.trip.tripStatus !=
                                                                              1)) ...[
                                                                    Text(
                                                                      controller
                                                                              .bike
                                                                              .brand! +
                                                                          ' - ' +
                                                                          controller
                                                                              .bike
                                                                              .color!,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1,
                                                                    ),
                                                                  ],
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10.0),
                                                                child:
                                                                    ContactButtons(
                                                                  phoneNo:
                                                                      controller
                                                                          .user
                                                                          .userPhoneNumber,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ] else ...[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/images/loading.svg',
                                                          ),
                                                        ),
                                                        Text(
                                                          CustomStrings
                                                              .kFinding.tr,
                                                          style: TextStyle(
                                                            color: CustomColors
                                                                .kBlue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ]
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  if (controller
                                                          .trip.tripStatus !=
                                                      1) {
                                                    Get.toNamed(
                                                        CommonRoutes.VIEW_USER,
                                                        arguments: {
                                                          'partnerId':
                                                              controller
                                                                  .user.userId
                                                        });
                                                  }
                                                },
                                              ),
                                            ],
                                            if (controller.trip.tripStatus !=
                                                    5 &&
                                                controller.trip.tripStatus !=
                                                    6) ...[
                                              Container(
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    if (tempBookTime.day ==
                                                            currentTime.day &&
                                                        tempBookTime.month ==
                                                            currentTime.month &&
                                                        tempBookTime.year ==
                                                            currentTime
                                                                .year) ...[
                                                      if (controller.trip.tripStatus == 2 ||
                                                          controller.trip
                                                                  .tripStatus ==
                                                              3 ||
                                                          controller.trip
                                                                  .tripStatus ==
                                                              4) ...[
                                                        Obx(
                                                          () => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        16.0),
                                                            child:
                                                                CustomElevatedIconButton(
                                                              width: 180,
                                                              text: buttonText
                                                                  .value,
                                                              backgroundColor: buttonText
                                                                          .value ==
                                                                      CustomStrings
                                                                          .kArriveAtDestination
                                                                          .tr
                                                                  ? CustomColors
                                                                      .kDarkGray
                                                                  : CustomColors
                                                                      .kBlue,
                                                              foregroundColor:
                                                                  Colors.white,
                                                              elevation: 0.0,
                                                              icon: buttonIcon
                                                                  .value,
                                                              onPressedFunc: buttonText
                                                                          .value ==
                                                                      CustomStrings
                                                                          .kArriveAtDestination
                                                                          .tr
                                                                  ? () {}
                                                                  : () async {
                                                                      CustomLocation
                                                                          departureLocation =
                                                                          CustomLocation(
                                                                              coordinate: controller.departureStation.departureCoordinate);

                                                                      if (isArrivedAtPickUpPoint
                                                                          .isFalse) {
                                                                        controller.userLocation =
                                                                            await CommonFunctions.getCurrentLocation();

                                                                        if (controller.userLocation !=
                                                                            null) {
                                                                          CommonFunctions.showConfirmDialog(
                                                                              context: context,
                                                                              isCancel: false,
                                                                              title: CustomStrings.kConfirmArrivalTitle.tr,
                                                                              message: Biike.role.value == Role.keer ? CustomStrings.kConfirmArrivalMessageForKeer.tr : CustomStrings.kConfirmArrivalMessageForBiker.tr,
                                                                              onPressedFunc: () async {
                                                                                controller.userLocation = await CommonFunctions.getCurrentLocation();

                                                                                if (CommonFunctions().isArrivedAtPickUpPoint(userLat: controller.userLocation!.latitude!, userLng: controller.userLocation!.longitude!, departureLat: departureLocation.latitude, departureLng: departureLocation.longitude)) {
                                                                                  Get.back();

                                                                                  CustomDialog(context: context).loadingDialog.show();

                                                                                  if (await _tripProvider.markArrivedAtPickUpPoint(tripId: tripId)) {
                                                                                    isArrivedAtPickUpPoint.value = true;

                                                                                    if (Biike.role.value == Role.keer) {
                                                                                      buttonText.value = CustomStrings.kArriveAtDestination.tr;
                                                                                    } else {
                                                                                      changeToStartTripButton();
                                                                                    }

                                                                                    CustomDialog(context: context).loadingDialog.dismiss();
                                                                                  } else {
                                                                                    AwesomeDialog(context: context, dialogType: DialogType.ERROR, headerAnimationLoop: false, desc: CustomErrorsString.kDevelopError.tr).show();
                                                                                  }
                                                                                } else {
                                                                                  AwesomeDialog(context: context, dialogType: DialogType.ERROR, headerAnimationLoop: false, desc: CustomErrorsString.kNotArrivedAtPickUpPoint.tr).show();
                                                                                }
                                                                              });
                                                                        } else {
                                                                          AwesomeDialog(context: context, dialogType: DialogType.INFO_REVERSED, headerAnimationLoop: false, desc: CustomStrings.kNeedLocationPermission.tr)
                                                                              .show();
                                                                        }
                                                                      } else {
                                                                        if (buttonText.value ==
                                                                            CustomStrings.kStart.tr) {
                                                                          GoogleMapController
                                                                              googleMapController =
                                                                              await completerController.future;

                                                                          await googleMapController
                                                                              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                                                            target:
                                                                                LatLng(controller.userLocation!.latitude!, controller.userLocation!.longitude!),
                                                                            zoom:
                                                                                12,
                                                                          )));

                                                                          if (await _tripProvider.startTrip(
                                                                              tripId: tripId)) {
                                                                            // FirebaseFirestore
                                                                            //     firebaseFirestore =
                                                                            //     FirebaseFirestore.instance;
                                                                            // Geoflutterfire
                                                                            //     geo =
                                                                            //     Geoflutterfire();
                                                                            Location
                                                                                location =
                                                                                Location();
                                                                            location.onLocationChanged.listen((LocationData
                                                                                currentLocation) async {
                                                                              await googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                                                                target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
                                                                                zoom: 12,
                                                                              )));

                                                                              // firebaseFirestore.collection('locations').add({
                                                                              //   'tripId': tripId,
                                                                              //   'userId': Biike.userId.value,
                                                                              //   'position': geo.point(latitude: controller.userLocation!.latitude!, longitude: controller.userLocation!.longitude!).data,
                                                                              //   'time': DateTime.now()
                                                                              // });

                                                                              // QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore.collection('locations').where('tripId', isEqualTo: tripId).where('userId', isEqualTo: controller.user.userId).limit(1).orderBy('time', descending: true).get();

                                                                              // List<QueryDocumentSnapshot> docs = snapshot.docs;

                                                                              // for (var doc in docs) {
                                                                              //   if (doc.data() != null) {
                                                                              //     var data = doc.data() as Map<String, dynamic>;
                                                                              //     GeoPoint pos = data['position']['geopoint']; // You can get other data in this manner.
                                                                              //     Marker marker = Marker(
                                                                              //       markerId: MarkerId('user'),
                                                                              //       position: LatLng(pos.latitude, pos.longitude),
                                                                              //       icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(10, 10)), 'assets/images/user-marker-1.png'),
                                                                              //     );

                                                                              //     markers.removeWhere((element) => element.markerId.value == 'user');
                                                                              //     markers.add(marker);
                                                                              //   }
                                                                              // }
                                                                            });
                                                                            changeToFinishTripButton();
                                                                          } else {
                                                                            AwesomeDialog(context: context, dialogType: DialogType.ERROR, headerAnimationLoop: false, desc: CustomErrorsString.kDevelopError.tr).show();
                                                                          }
                                                                        } else {
                                                                          if (CommonFunctions().isArrivedAtPickUpPoint(
                                                                              userLat: controller.userLocation!.latitude!,
                                                                              userLng: controller.userLocation!.longitude!,
                                                                              departureLat: destination.latitude,
                                                                              departureLng: destination.longitude)) {
                                                                            if (await _tripProvider.completeTrip(tripId: tripId)) {
                                                                              if (controller.isLocationShared.isTrue) {
                                                                                await controller.pathshareProvider.startOrStopLocationSharing(isShared: false, sessionIdentifier: controller.sessionIdentifier);
                                                                              }

                                                                              Get.offAllNamed(CommonRoutes.FEEDBACK, arguments: controller.trip.tripId);
                                                                            } else {
                                                                              AwesomeDialog(context: context, dialogType: DialogType.ERROR, headerAnimationLoop: false, desc: CustomErrorsString.kDevelopError.tr).show();
                                                                            }
                                                                          } else {
                                                                            AwesomeDialog(context: context, dialogType: DialogType.ERROR, headerAnimationLoop: false, desc: CustomErrorsString.kNotArrivedAtPickUpPoint.tr).show();
                                                                          }
                                                                        }
                                                                      }
                                                                    },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ],
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 16.0),
                                                      child:
                                                          CustomElevatedIconButton(
                                                        width: 180,
                                                        text: CustomStrings
                                                            .kCancelTrip.tr,
                                                        backgroundColor:
                                                            CustomColors
                                                                .kLightGray,
                                                        foregroundColor:
                                                            CustomColors
                                                                .kDarkGray,
                                                        elevation: 0.0,
                                                        icon: Icons.clear,
                                                        onPressedFunc: () {
                                                          if (controller.trip
                                                              .isCancellationLimitExceeded!) {
                                                            AwesomeDialog(
                                                                    context:
                                                                        context,
                                                                    dialogType:
                                                                        DialogType
                                                                            .ERROR,
                                                                    headerAnimationLoop:
                                                                        false,
                                                                    desc: CustomErrorsString
                                                                        .kYouCanOnlyCancel5TripsPerDay
                                                                        .tr)
                                                                .show();
                                                          } else {
                                                            CommonFunctions
                                                                .showConfirmDialog(
                                                                    context:
                                                                        context,
                                                                    isCancel:
                                                                        true,
                                                                    title: CustomStrings
                                                                        .kConfirmCancelTrip
                                                                        .tr,
                                                                    message:
                                                                        CustomStrings
                                                                            .kViewCancelTripReminder
                                                                            .tr,
                                                                    onPressedFunc:
                                                                        () {
                                                                      Get.back();

                                                                      _showCancelReasonDialog(
                                                                          context:
                                                                              context);
                                                                    });
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      if (controller.trip.tripStatus == 5) ...[
                                        _showFeedbacks(
                                            context: context,
                                            title:
                                                CustomStrings.kYourFeedback.tr,
                                            star: controller.feedback1.tripStar,
                                            feedbackContent: controller
                                                .feedback1.feedbackContent),
                                        _showFeedbacks(
                                            context: context,
                                            title: CustomStrings
                                                .kPartnerFeedback.tr,
                                            star: controller.feedback2.tripStar,
                                            feedbackContent: controller
                                                .feedback2.feedbackContent),
                                      ]
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Loading();
                            }
                          });
                    } else {
                      return Loading();
                    }
                  }),
            );
          }),
    );
  }
}
