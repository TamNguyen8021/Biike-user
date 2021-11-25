import 'dart:async';

import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/controllers/trip_history_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/android/widgets/others/map_viewer.dart';
import 'package:bikes_user/app/ui/android/widgets/others/user_rating.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/contact_buttons.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

/// 'trip_details' screen
//ignore: must_be_immutable
class TripDetailsPage extends StatelessWidget {
  final _tripProvider = Get.find<TripProvider>();
  final _tripDetailsController = Get.find<TripDetailsController>();
  final _homeController = Get.find<HomeController>();
  final _tripHistoryController = Get.find<TripHistoryController>();
  final Completer<GoogleMapController> completerController = Completer();

  String _statusBarTime = '';
  String _statusBarText = '';
  Rx<String> _cancelReason = ''.obs;

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
      case 4:
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
  Future<void> _showCancelReasonDialog(
      {required BuildContext context, required int tripId}) async {
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
                                  await CommonFunctions().showErrorDialog(
                                      context: context,
                                      message: CustomStrings
                                          .kLetUsKnowYourCancelReason.tr);
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

  void _onBackPressed({required BuildContext context}) {
    if (_tripDetailsController.isTripStarted.isFalse) {
      if (Get.arguments['route'] == 'home') {
        _homeController.pagingController.refresh();
      } else {
        _tripHistoryController.pagingController.refresh();
      }
      Get.back();
    } else {
      CommonFunctions().showErrorDialog(
          context: context,
          message: CustomErrorsString.kCannotGoBackWhenTripStarted.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();

    return OnBackPressed(
      perform: () {
        _onBackPressed(context: context);
      },
      child: GetBuilder<TripDetailsController>(
          init: _tripDetailsController,
          builder: (TripDetailsController controller) {
            return FutureBuilder(
                future:
                    controller.getTripDetails(tripId: Get.arguments['tripId']),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Rx<bool> isStartTripButtonVisible = false.obs;

                    _addStatusBarTextAndTime();

                    if (Biike.role.value == Role.biker &&
                        currentTime.compareTo(
                                DateTime.tryParse(controller.trip.bookTime)!) >=
                            0) {
                      isStartTripButtonVisible.value = true;
                    }

                    return Scaffold(
                      appBar: CustomAppBar(
                        isVisible: true,
                        hasShape: true,
                        hasLeading: true,
                        onPressedFunc: () {
                          _onBackPressed(context: context);
                        },
                        appBar: AppBar(),
                        title: Text(CustomStrings.kTripDetails.tr),
                        actionWidgets: controller.trip.tripStatus != 4 &&
                                controller.trip.tripStatus != 5
                            ? <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 22.0),
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      await controller.getCurrentLocation();
                                      if (controller.userLocation != null) {
                                        controller.showHelpCenter(
                                            context: context);
                                      } else {
                                        await CommonFunctions().showInfoDialog(
                                            context: context,
                                            message: CustomStrings
                                                .kNeedLocationPermission.tr);
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                    ),
                                  ),
                                ),
                              ]
                            : null,
                      ),
                      body: SingleChildScrollView(
                        child: SafeArea(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    22.0, 16.0, 22.0, 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: CustomColors.kDarkGray
                                              .withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                    MapViewer(
                                        isFullMap: false,
                                        completerController:
                                            completerController,
                                        polypoints: controller.polypoints,
                                        departureCoordinate: controller
                                            .departureStation
                                            .departureCoordinate,
                                        destinationCoordinate: controller
                                            .destinationStation
                                            .destinationCoordinate),
                                    Container(
                                      alignment: Alignment.center,
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: CustomTextButton(
                                          hasBorder: true,
                                          width: double.infinity,
                                          backgroundColor: Colors.white,
                                          foregroundColor: CustomColors.kBlue,
                                          text: CustomStrings.kExpandMap.tr,
                                          onPressedFunc: () {
                                            Get.toNamed(
                                                CommonRoutes
                                                    .TRIP_DETAILS_FULL_MAP,
                                                arguments: {
                                                  'tripId':
                                                      controller.trip.tripId
                                                });
                                          }),
                                    ),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                  right: BorderSide(
                                                      color: CustomColors
                                                          .kDarkGray
                                                          .withOpacity(0.1))),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5.0),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 5.0),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: CustomColors
                                                              .kDarkGray
                                                              .withOpacity(0.1),
                                                        ),
                                                      ),
                                                    ),
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
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 8.0),
                                                          child: Text(
                                                            DateFormat(
                                                                    'dd/MM/yyyy')
                                                                .format(DateTime
                                                                    .tryParse(
                                                                        controller
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
                                                        DateFormat('HH:mm').format(
                                                            DateTime.tryParse(
                                                                controller.trip
                                                                    .bookTime)!),
                                                        style: Theme.of(context)
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
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5.0),
                                                          child: Icon(
                                                            Icons.adjust,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller
                                                              .departureStation
                                                              .departureName,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                        ),
                                                      ],
                                                    ),
                                                    Icon(
                                                      Icons.more_vert_outlined,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5.0),
                                                          child: Icon(
                                                            Icons.location_on,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller
                                                              .destinationStation
                                                              .destinationName,
                                                          style:
                                                              Theme.of(context)
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
                                    if (controller.trip.tripStatus == 5 &&
                                        controller.user.userFullname ==
                                            CustomStrings.kFinding)
                                      ...[]
                                    else ...[
                                      GestureDetector(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 16.0),
                                          decoration: BoxDecoration(
                                              color: CustomColors.kLightGray,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            children: <Widget>[
                                              if (controller.trip.tripStatus !=
                                                  1) ...[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: CircleAvatar(
                                                    radius: 45,
                                                    backgroundImage:
                                                        NetworkImage(controller
                                                            .user.avatar),
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
                                                                bottom: 5.0,
                                                                top: 10.0),
                                                        child: Text(
                                                          controller.user
                                                              .userFullname,
                                                          style: TextStyle(
                                                              color:
                                                                  CustomColors
                                                                      .kBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      UserRating(
                                                          score: controller
                                                              .user.userStar
                                                              .toString()),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10.0),
                                                        child: ContactButtons(
                                                          phoneNo: controller
                                                              .user
                                                              .userPhoneNumber,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ] else ...[
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: SvgPicture.asset(
                                                    'assets/images/loading.svg',
                                                  ),
                                                ),
                                                Text(
                                                  CustomStrings.kFinding.tr,
                                                  style: TextStyle(
                                                    color: CustomColors.kBlue,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ]
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          if (controller.trip.tripStatus != 1) {
                                            Get.toNamed(CommonRoutes.VIEW_USER,
                                                arguments: {
                                                  'partnerId':
                                                      Get.arguments['userId']
                                                });
                                          }
                                        },
                                      ),
                                    ],
                                    if (controller.trip.tripStatus != 4 &&
                                        controller.trip.tripStatus != 5) ...[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Obx(
                                            () => Visibility(
                                              visible: !controller
                                                  .isTripStarted.value,
                                              child: CustomElevatedIconButton(
                                                width: 150,
                                                text: CustomStrings
                                                    .kCancelTrip.tr,
                                                backgroundColor:
                                                    CustomColors.kLightGray,
                                                foregroundColor:
                                                    CustomColors.kDarkGray,
                                                elevation: 0.0,
                                                icon: Icons.clear,
                                                onPressedFunc: () {
                                                  CommonFunctions()
                                                      .showConfirmDialog(
                                                          context: context,
                                                          title: CustomStrings
                                                              .kConfirmCancelTrip
                                                              .tr,
                                                          message: CustomStrings
                                                              .kViewCancelTripReminder
                                                              .tr,
                                                          onPressedFunc: () {
                                                            Get.back();
                                                            _showCancelReasonDialog(
                                                                context:
                                                                    context,
                                                                tripId: Get
                                                                        .arguments[
                                                                    'tripId']);
                                                          });
                                                },
                                              ),
                                            ),
                                          ),
                                          if (controller.trip.tripStatus ==
                                              2) ...[
                                            if (Biike.role.value ==
                                                    Role.biker &&
                                                currentTime.compareTo(
                                                        DateTime.tryParse(
                                                            controller.trip
                                                                .bookTime)!) >=
                                                    0) ...[
                                              Obx(
                                                () => Visibility(
                                                  visible:
                                                      isStartTripButtonVisible
                                                          .value,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16.0),
                                                    child:
                                                        CustomElevatedIconButton(
                                                      width: 150,
                                                      onPressedFunc: () async {
                                                        if (controller
                                                            .isTripStarted
                                                            .isFalse) {
                                                          await controller
                                                              .getCurrentLocation();
                                                          if (controller
                                                                  .userLocation !=
                                                              null) {
                                                            GoogleMapController
                                                                googleMapController =
                                                                await completerController
                                                                    .future;
                                                            await googleMapController
                                                                .animateCamera(
                                                                    CameraUpdate
                                                                        .newCameraPosition(
                                                                            CameraPosition(
                                                              target: LatLng(
                                                                  controller
                                                                      .userLocation!
                                                                      .latitude!,
                                                                  controller
                                                                      .userLocation!
                                                                      .longitude!),
                                                              zoom: 12,
                                                            )));
                                                            if (await _tripProvider
                                                                .startTripOrCompleteTrip(
                                                                    tripId: Get
                                                                            .arguments[
                                                                        'tripId'])) {
                                                              controller
                                                                  .isTripStarted
                                                                  .value = true;
                                                              controller
                                                                  .changeToFinishTripButton();
                                                            } else {
                                                              CommonFunctions()
                                                                  .showErrorDialog(
                                                                      context:
                                                                          context,
                                                                      message: CustomErrorsString
                                                                          .kDevelopError
                                                                          .tr);
                                                            }
                                                          } else {
                                                            CommonFunctions()
                                                                .showInfoDialog(
                                                                    context:
                                                                        context,
                                                                    message: CustomStrings
                                                                        .kNeedLocationPermission
                                                                        .tr);
                                                          }
                                                        } else {
                                                          final isTripCompleted =
                                                              await _tripProvider
                                                                  .startTripOrCompleteTrip(
                                                                      tripId: Get
                                                                              .arguments[
                                                                          'tripId']);
                                                          if (isTripCompleted) {
                                                            isStartTripButtonVisible
                                                                .value = false;
                                                            Get.offAllNamed(
                                                                CommonRoutes
                                                                    .FEEDBACK);
                                                          } else {
                                                            CommonFunctions()
                                                                .showErrorDialog(
                                                                    context:
                                                                        context,
                                                                    message: CustomErrorsString
                                                                        .kDevelopError
                                                                        .tr);
                                                          }
                                                        }
                                                      },
                                                      text: controller
                                                          .buttonText.value,
                                                      backgroundColor:
                                                          CustomColors.kBlue,
                                                      foregroundColor:
                                                          Colors.white,
                                                      elevation: 0.0,
                                                      icon: controller
                                                          .buttonIcon.value,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ] else ...[
                                              // Expanded(
                                              //   child: ConfirmArrivalButton(
                                              //     isOnHomeScreen: false,
                                              //   ),
                                              // ),
                                            ]
                                          ],
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              if (controller.trip.tripStatus == 4) ...[
                                _showFeedbacks(
                                    context: context,
                                    title: CustomStrings.kYourFeedback.tr,
                                    star: controller.feedback1.tripStar,
                                    feedbackContent:
                                        controller.feedback1.feedbackContent),
                                _showFeedbacks(
                                    context: context,
                                    title: CustomStrings.kPartnerFeedback.tr,
                                    star: controller.feedback2.tripStar,
                                    feedbackContent:
                                        controller.feedback2.feedbackContent),
                              ]
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Loading();
                  }
                });
          }),
    );
  }
}
