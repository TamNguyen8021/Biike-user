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
import 'package:intl/intl.dart';

/// 'trip_details' screen
//ignore: must_be_immutable
class TripDetailsPage extends StatelessWidget {
  final _tripProvider = Get.find<TripProvider>();
  final _tripDetailsController = Get.find<TripDetailsController>();
  final _homeController = Get.find<HomeController>();
  final _tripHistoryController = Get.find<TripHistoryController>();

  String _statusBarTime = '';
  String _statusBarText = '';

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

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();

    return OnBackPressed(
      perform: () {
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
      },
      child: GetBuilder(
          init: _tripDetailsController,
          builder: (_) {
            return FutureBuilder(
                future: _tripDetailsController.getTripDetails(
                    tripId: Get.arguments['tripId']),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Rx<bool> isStartTripButtonVisible = false.obs;

                    _addStatusBarTextAndTime();

                    if (Biike.role.value == Role.biker &&
                        currentTime.compareTo(DateTime.tryParse(
                                _tripDetailsController.trip.bookTime)!) >=
                            0) {
                      isStartTripButtonVisible.value = true;
                    }

                    return Scaffold(
                      appBar: CustomAppBar(
                        isVisible: true,
                        hasShape: true,
                        hasLeading: true,
                        onPressedFunc: () {
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
                                message: CustomErrorsString
                                    .kCannotGoBackWhenTripStarted.tr);
                          }
                        },
                        appBar: AppBar(),
                        title: Text(CustomStrings.kTripDetails.tr),
                        actionWidgets: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 22.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (_tripDetailsController.userLocation !=
                                    null) {
                                  _tripDetailsController.showHelpCenter(
                                      context: context);
                                } else {
                                  CommonFunctions().showInfoDialog(
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
                                    borderRadius: BorderRadius.circular(15)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                              ),
                            ),
                          ),
                        ],
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
                                        polypoints:
                                            _tripDetailsController.polypoints,
                                        departureCoordinate:
                                            _tripDetailsController
                                                .departureStation
                                                .departureCoordinate,
                                        destinationCoordinate:
                                            _tripDetailsController
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
                                                      _tripDetailsController
                                                          .trip.tripId,
                                                  'polypoints':
                                                      _tripDetailsController
                                                          .polypoints
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
                                                                        _tripDetailsController
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
                                                                _tripDetailsController
                                                                    .trip
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
                                                          _tripDetailsController
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
                                                          _tripDetailsController
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
                                    if (_tripDetailsController
                                                .trip.tripStatus ==
                                            5 &&
                                        _tripDetailsController
                                                .user.userFullname ==
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
                                              if (_tripDetailsController
                                                      .trip.tripStatus !=
                                                  1) ...[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: CircleAvatar(
                                                    radius: 45,
                                                    backgroundImage: NetworkImage(
                                                        _tripDetailsController
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
                                                          _tripDetailsController
                                                              .user
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
                                                          score:
                                                              _tripDetailsController
                                                                  .user.userStar
                                                                  .toString()),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10.0),
                                                        child: ContactButtons(
                                                          phoneNo:
                                                              _tripDetailsController
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
                                          if (_tripDetailsController
                                                  .trip.tripStatus !=
                                              1) {
                                            Get.toNamed(CommonRoutes.VIEW_USER,
                                                arguments: {
                                                  'partnerId':
                                                      Get.arguments['userId']
                                                });
                                          }
                                        },
                                      ),
                                    ],
                                    if (_tripDetailsController
                                                .trip.tripStatus !=
                                            4 &&
                                        _tripDetailsController
                                                .trip.tripStatus !=
                                            5) ...[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Obx(
                                            () => Visibility(
                                              visible: !_tripDetailsController
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
                                                            _tripDetailsController
                                                                .showCancelReasonDialog(
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
                                          if (_tripDetailsController
                                                  .trip.tripStatus ==
                                              2) ...[
                                            if (Biike.role.value ==
                                                    Role.biker &&
                                                currentTime.compareTo(
                                                        DateTime.tryParse(
                                                            _tripDetailsController
                                                                .trip
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
                                                        if (_tripDetailsController
                                                            .isTripStarted
                                                            .isFalse) {
                                                          if (_tripDetailsController
                                                                  .userLocation !=
                                                              null) {
                                                            if (await _tripProvider
                                                                .startTripOrCompleteTrip(
                                                                    tripId: Get
                                                                            .arguments[
                                                                        'tripId'])) {
                                                              _tripDetailsController
                                                                  .isTripStarted
                                                                  .value = true;
                                                              _tripDetailsController
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
                                                      text:
                                                          _tripDetailsController
                                                              .buttonText.value,
                                                      backgroundColor:
                                                          CustomColors.kBlue,
                                                      foregroundColor:
                                                          Colors.white,
                                                      elevation: 0.0,
                                                      icon:
                                                          _tripDetailsController
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
                              if (_tripDetailsController.trip.tripStatus ==
                                  4) ...[
                                _showFeedbacks(
                                    context: context,
                                    title: CustomStrings.kYourFeedback.tr,
                                    star: _tripDetailsController
                                        .feedback1.tripStar,
                                    feedbackContent: _tripDetailsController
                                        .feedback1.feedbackContent),
                                _showFeedbacks(
                                    context: context,
                                    title: CustomStrings.kPartnerFeedback.tr,
                                    star: _tripDetailsController
                                        .feedback2.tripStar,
                                    feedbackContent: _tripDetailsController
                                        .feedback2.feedbackContent),
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
