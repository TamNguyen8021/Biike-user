import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_dialog.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/cho_now_settings_controller.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/data/models/station.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:bikes_user/app/ui/android/pages/cho_now_settings/widgets/pick_up_station_card.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/choose_date_time_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
import 'package:bikes_user/app/ui/android/widgets/others/LazyLoadingListErrorBuilder.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChoNowSettingsPage extends StatelessWidget {
  final _userProvider = Get.find<UserProvider>();
  final _tripProvider = Get.find<TripProvider>();
  final _tripDetailsController = Get.find<TripDetailsController>();
  final _choNowSettingsController = Get.find<ChoNowSettingsController>();

  ChoNowSettingsPage({Key? key}) : super(key: key);

  /// Show a dialog when user wants to add station to receive Ke Now trip notification
  ///
  /// Author: TamNTT
  Future<void> _showAddPickUpStationDialog(
      {required BuildContext context,
      String? stationName,
      TimeOfDay? from,
      TimeOfDay? to,
      int? index}) async {
    if (stationName != null) {
      _choNowSettingsController.selectedStation.value.name = stationName;
    }

    if (from != null) {
      _choNowSettingsController.fromTime.value = from;
      _choNowSettingsController.fromTimeString.value =
          CommonFunctions.convertTimeOfDayToString(
              context: context,
              time: _choNowSettingsController.fromTime.value!);
    } else {
      _choNowSettingsController.fromTimeString.value =
          CustomStrings.kChooseTime.tr;
    }

    if (to != null) {
      _choNowSettingsController.toTime.value = to;
      _choNowSettingsController.toTimeString.value =
          CommonFunctions.convertTimeOfDayToString(
              context: context, time: _choNowSettingsController.toTime.value!);
    } else {
      _choNowSettingsController.toTimeString.value =
          CustomStrings.kChooseTime.tr;
    }

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder(
              future: _choNowSettingsController.loadStations(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Dialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            CustomStrings.kAddChoNowStation.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(top: 16.0, bottom: 8.0),
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 8.0),
                            decoration: BoxDecoration(
                              color: CustomColors.kLightGray,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color:
                                      CustomColors.kDarkGray.withOpacity(0.3),
                                  // changes position of shadow
                                  offset: Offset(0, 1.25),
                                )
                              ],
                            ),
                            child: Obx(
                              () => DropdownButtonFormField<Station>(
                                value: _choNowSettingsController
                                    .selectedStation.value,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                items: _choNowSettingsController.stations
                                    .map<DropdownMenuItem<Station>>(
                                        (Station value) {
                                  return DropdownMenuItem<Station>(
                                    value: value,
                                    child: Text(
                                      value.name,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (Station? value) {
                                  _choNowSettingsController
                                      .selectedStation.value = value!;
                                },
                                decoration: InputDecoration(
                                    labelText: CustomStrings.kChooseStation.tr,
                                    fillColor: CustomColors.kLightGray,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )),
                              ),
                            ),
                          ),
                          Text(CustomStrings.kFrom.tr),
                          Obx(
                            () => ChooseDateTimeButton(
                                text: _choNowSettingsController
                                    .fromTimeString.value,
                                onPressedFunc: () async {
                                  _choNowSettingsController.fromTime.value =
                                      await CommonFunctions.selectTime(
                                          context: context,
                                          selectedTime:
                                              _choNowSettingsController
                                                  .fromTime);
                                  _choNowSettingsController
                                          .fromTimeString.value =
                                      CommonFunctions.convertTimeOfDayToString(
                                          context: context,
                                          time: _choNowSettingsController
                                              .fromTime.value!);
                                },
                                isOnProfilePage: false),
                          ),
                          Text(CustomStrings.kTo.tr),
                          Obx(
                            () => ChooseDateTimeButton(
                                text: _choNowSettingsController
                                    .toTimeString.value,
                                onPressedFunc: () async {
                                  _choNowSettingsController.toTime.value =
                                      await CommonFunctions.selectTime(
                                          context: context,
                                          selectedTime:
                                              _choNowSettingsController.toTime);
                                  _choNowSettingsController.toTimeString.value =
                                      CommonFunctions.convertTimeOfDayToString(
                                          context: context,
                                          time: _choNowSettingsController
                                              .toTime.value!);
                                },
                                isOnProfilePage: false),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              if (stationName != null &&
                                  from != null &&
                                  to != null) ...[
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: CustomTextButton(
                                      width: 100,
                                      backgroundColor: CustomColors.kRed,
                                      foregroundColor: Colors.white,
                                      text: CustomStrings.kDelete.tr,
                                      onPressedFunc: () async {
                                        Get.back();

                                        if (await _choNowSettingsController
                                            .deletePickUpStation(
                                                index: index!,
                                                context: context)) {
                                          AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.SUCCES,
                                                  headerAnimationLoop: false,
                                                  desc: CustomStrings
                                                      .kDeleteStationSuccess.tr)
                                              .show();
                                          _choNowSettingsController
                                              .pagingController
                                              .refresh();
                                        } else {
                                          AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.ERROR,
                                                  headerAnimationLoop: false,
                                                  desc: CustomErrorsString
                                                      .kDevelopError.tr)
                                              .show();
                                        }
                                      },
                                      hasBorder: false),
                                ),
                                Obx(
                                  () => CustomTextButton(
                                      width: 100,
                                      backgroundColor: _choNowSettingsController
                                              .isEditButtonDisabled(
                                                  context: context,
                                                  index: index!)
                                              .obs
                                              .isTrue
                                          ? CustomColors.kDarkGray
                                          : CustomColors.kBlue,
                                      foregroundColor: Colors.white,
                                      text: CustomStrings.kEdit.tr,
                                      onPressedFunc: _choNowSettingsController
                                              .isEditButtonDisabled(
                                                  context: context,
                                                  index: index)
                                              .obs
                                              .isTrue
                                          ? () {}
                                          : () async {
                                              if (_choNowSettingsController
                                                  .checkIfFromTimeIsBeforeToTime()) {
                                                AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.ERROR,
                                                        headerAnimationLoop:
                                                            false,
                                                        desc: CustomErrorsString
                                                            .kFromTimeMustBeBeforeToTime
                                                            .tr)
                                                    .show();
                                              } else if (_choNowSettingsController
                                                  .checkIfTimeIsNotBetween5AMAnd9PM()) {
                                                AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.ERROR,
                                                        headerAnimationLoop:
                                                            false,
                                                        desc: CustomErrorsString
                                                            .kCanOnlyAddStationFrom5AMTo9PM
                                                            .tr)
                                                    .show();
                                              } else if (_choNowSettingsController
                                                  .checkIfTimeBetweenFromTimeAndToTimeIsLessThan15Mins()) {
                                                AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.ERROR,
                                                        headerAnimationLoop:
                                                            false,
                                                        desc: CustomErrorsString
                                                            .kTimeBetweenFromTimeAndToTimeMustBeEqualOrGreaterThan15Mins
                                                            .tr)
                                                    .show();
                                              } else if (_choNowSettingsController
                                                  .checkIfStationWereAdded(
                                                      id: _choNowSettingsController
                                                          .rideNowStations
                                                          .elementAt(index)
                                                          .id)) {
                                                AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.ERROR,
                                                        headerAnimationLoop:
                                                            false,
                                                        desc: CustomErrorsString
                                                            .kSameStationWereAdded
                                                            .tr)
                                                    .show();
                                              } else {
                                                if (await _choNowSettingsController.editPickUpStation(
                                                    index: index,
                                                    name:
                                                        _choNowSettingsController
                                                            .selectedStation
                                                            .value
                                                            .name,
                                                    timeRange: CommonFunctions
                                                            .convertTimeOfDayToString(
                                                                context:
                                                                    context,
                                                                time: _choNowSettingsController
                                                                    .fromTime
                                                                    .value!) +
                                                        ' - ' +
                                                        CommonFunctions
                                                            .convertTimeOfDayToString(
                                                                context:
                                                                    context,
                                                                time: _choNowSettingsController
                                                                    .toTime
                                                                    .value!))) {
                                                  Get.back();
                                                  AwesomeDialog(
                                                          context: context,
                                                          dialogType:
                                                              DialogType.SUCCES,
                                                          headerAnimationLoop:
                                                              false,
                                                          desc: CustomStrings
                                                              .kEditStationSuccess
                                                              .tr)
                                                      .show();
                                                  _choNowSettingsController
                                                      .pagingController
                                                      .refresh();
                                                } else {
                                                  AwesomeDialog(
                                                          context: context,
                                                          dialogType:
                                                              DialogType.ERROR,
                                                          headerAnimationLoop:
                                                              false,
                                                          desc:
                                                              CustomErrorsString
                                                                  .kDevelopError
                                                                  .tr)
                                                      .show();
                                                }
                                              }
                                            },
                                      hasBorder: false),
                                ),
                              ] else ...[
                                CustomTextButton(
                                    backgroundColor: CustomColors.kBlue,
                                    foregroundColor: Colors.white,
                                    text: CustomStrings.kAdd.tr,
                                    onPressedFunc: () async {
                                      if (_choNowSettingsController
                                          .checkIfAllFieldsHaveData()) {
                                        if (_choNowSettingsController
                                            .checkIfFromTimeIsBeforeToTime()) {
                                          AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.ERROR,
                                                  headerAnimationLoop: false,
                                                  desc: CustomErrorsString
                                                      .kFromTimeMustBeBeforeToTime
                                                      .tr)
                                              .show();
                                        } else if (_choNowSettingsController
                                            .checkIfTimeIsNotBetween5AMAnd9PM()) {
                                          AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.ERROR,
                                                  headerAnimationLoop: false,
                                                  desc: CustomErrorsString
                                                      .kCanOnlyAddStationFrom5AMTo9PM
                                                      .tr)
                                              .show();
                                        } else {
                                          if (_choNowSettingsController
                                              .checkIfStationWereAdded()) {
                                            AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.ERROR,
                                                    headerAnimationLoop: false,
                                                    desc: CustomErrorsString
                                                        .kSameStationWereAdded
                                                        .tr)
                                                .show();
                                          } else if (_choNowSettingsController
                                              .checkIfTimeBetweenFromTimeAndToTimeIsLessThan15Mins()) {
                                            AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.ERROR,
                                                    headerAnimationLoop: false,
                                                    desc: CustomErrorsString
                                                        .kTimeBetweenFromTimeAndToTimeMustBeEqualOrGreaterThan15Mins
                                                        .tr)
                                                .show();
                                          } else {
                                            if (await _choNowSettingsController
                                                .addPickUpStation(
                                                    context: context)) {
                                              Get.back();
                                              AwesomeDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.SUCCES,
                                                      headerAnimationLoop:
                                                          false,
                                                      desc: CustomStrings
                                                          .kAddStationSuccess
                                                          .tr)
                                                  .show();
                                              _choNowSettingsController
                                                  .pagingController
                                                  .refresh();
                                            } else {
                                              AwesomeDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.ERROR,
                                                      headerAnimationLoop:
                                                          false,
                                                      desc: CustomErrorsString
                                                          .kDevelopError.tr)
                                                  .show();
                                            }
                                          }
                                        }
                                      } else {
                                        AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.ERROR,
                                                headerAnimationLoop: false,
                                                desc: CustomErrorsString
                                                    .kNotFillAllFields.tr)
                                            .show();
                                      }
                                    },
                                    hasBorder: false),
                              ]
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Loading();
                }
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    Rx<bool> isChoNowOn = false.obs;
    Rx<bool> isCountDownEnd = false.obs;

    return Scaffold(
      appBar: CustomAppBar(
        hasShape: false,
        appBar: AppBar(),
        hasLeading: true,
        onPressedFunc: () {
          Get.back();
        },
        title: Text(
          CustomStrings.kChoNow.tr,
          textAlign: TextAlign.center,
        ),
        actionWidgets: <Widget>[
          CommonFunctions().lightBulbIcon(context, CustomStrings.kChoNow,
              contents: CustomStrings.kChoNowDescription),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (Get.arguments['tripId'] != null) ...[
              GetBuilder<TripDetailsController>(
                  init: _tripDetailsController,
                  builder: (TripDetailsController controller) {
                    if (isCountDownEnd.isFalse) {
                      return FutureBuilder(
                          future: controller.getTripDetails(
                              tripId: Get.arguments['tripId']),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              CountdownTimerController
                                  countdownTimerController =
                                  CountdownTimerController(
                                      endTime: DateTime.now()
                                              .millisecondsSinceEpoch +
                                          1000 * 60 * 3,
                                      onEnd: () {
                                        isCountDownEnd.value = true;
                                        controller.update();
                                      });

                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0, vertical: 16.0),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: UpcomingTripCard(
                                              isSearchedTrip: false,
                                              isTripNow: true,
                                              tripId: controller.trip.tripId,
                                              userId: controller.user.userId,
                                              avatarUrl: controller.user.avatar,
                                              name:
                                                  controller.user.userFullname,
                                              phoneNo: controller
                                                  .user.userPhoneNumber,
                                              bookTime:
                                                  controller.trip.bookTime,
                                              departureStation: controller
                                                  .departureStation
                                                  .departureName,
                                              destinationStation: controller
                                                  .destinationStation
                                                  .destinationName),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            CountdownTimer(
                                              controller:
                                                  countdownTimerController,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                              widgetBuilder: (context, time) {
                                                if (time == null)
                                                  return SizedBox.shrink();
                                                return Text(
                                                  CustomStrings
                                                          .kAutoCancelAfter.tr +
                                                      time.min.toString() +
                                                      ':' +
                                                      time.sec.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                );
                                              },
                                            ),
                                            CustomTextButton(
                                                backgroundColor:
                                                    CustomColors.kBlue,
                                                foregroundColor: Colors.white,
                                                text: CustomStrings.kAccept.tr,
                                                onPressedFunc: () async {
                                                  CustomDialog customDialog =
                                                      CustomDialog(
                                                          context: context);
                                                  customDialog.loadingDialog
                                                      .show();

                                                  bool isSuccess =
                                                      await _tripProvider
                                                          .acceptTrip(
                                                              tripId: controller
                                                                  .trip.tripId)
                                                          .catchError((error) {
                                                    customDialog.loadingDialog
                                                        .dismiss();
                                                    AwesomeDialog(
                                                            context: context,
                                                            dialogType:
                                                                DialogType
                                                                    .ERROR,
                                                            headerAnimationLoop:
                                                                false,
                                                            desc: CustomErrorsString
                                                                .kDevelopError
                                                                .tr)
                                                        .show();
                                                  });
                                                  if (isSuccess) {
                                                    isCountDownEnd.value = true;
                                                    controller.update();
                                                    customDialog.loadingDialog
                                                        .dismiss();
                                                    AwesomeDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.SUCCES,
                                                      headerAnimationLoop:
                                                          false,
                                                      desc: CustomStrings
                                                          .kAcceptSuccessful.tr,
                                                    ).show();
                                                  } else {
                                                    customDialog.loadingDialog
                                                        .dismiss();
                                                    AwesomeDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.ERROR,
                                                      headerAnimationLoop:
                                                          false,
                                                      desc: CustomErrorsString
                                                          .kDevelopError.tr,
                                                    ).show();
                                                  }
                                                },
                                                hasBorder: false),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              );
                            } else {
                              return Loading();
                            }
                          });
                    } else {
                      return SizedBox.shrink();
                    }
                  })
            ],
            FutureBuilder(
                future: _userProvider.getRideNowStatus(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data is bool) {
                      isChoNowOn.value = snapshot.data;

                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 22.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(CustomStrings.kChoNowSettings.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(color: CustomColors.kDarkGray)),
                              Container(
                                height: 45,
                                margin: const EdgeInsets.only(
                                    top: 16.0, bottom: 10.0),
                                padding: const EdgeInsets.only(left: 16.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: CustomColors.kLightGray,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: CustomColors.kDarkGray
                                            .withOpacity(0.3),
                                        // changes position of shadow
                                        offset: Offset(0, 1.25),
                                      )
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(CustomStrings.kTurnOnChoNow.tr),
                                    Obx(
                                      () => Switch(
                                        value: isChoNowOn.value,
                                        onChanged: (bool isOn) async {
                                          if (await _userProvider
                                              .changeRideNowStatus()) {
                                            isChoNowOn.value = isOn;
                                            _choNowSettingsController.update();
                                          } else {
                                            AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.ERROR,
                                                    headerAnimationLoop: false,
                                                    desc: CustomErrorsString
                                                        .kDevelopError.tr)
                                                .show();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Obx(
                                () => Visibility(
                                    visible: isChoNowOn.value,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 45,
                                          margin: const EdgeInsets.only(
                                              bottom: 8.0),
                                          padding: const EdgeInsets.only(
                                              left: 16.0, right: 8.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: CustomColors.kLightGray,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: CustomColors.kDarkGray
                                                      .withOpacity(0.3),
                                                  // changes position of shadow
                                                  offset: Offset(0, 1.25),
                                                )
                                              ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(CustomStrings
                                                  .kChoNowStation.tr),
                                              Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 35,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                        PagedListView<int, PickUpStationCard>(
                                          pagingController:
                                              _choNowSettingsController
                                                  .pagingController,
                                          shrinkWrap: true,
                                          builderDelegate:
                                              PagedChildBuilderDelegate<
                                                      PickUpStationCard>(
                                                  animateTransitions: true,
                                                  itemBuilder:
                                                      (context, item, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10.0),
                                                      child: GestureDetector(
                                                        child:
                                                            _choNowSettingsController
                                                                .pagingController
                                                                .itemList!
                                                                .elementAt(
                                                                    index),
                                                        onTap: () {
                                                          String
                                                              stationFromTimeString =
                                                              _choNowSettingsController
                                                                  .pagingController
                                                                  .itemList!
                                                                  .elementAt(
                                                                      index)
                                                                  .timeRange
                                                                  .split(
                                                                      ' - ')[0];
                                                          String
                                                              stationFromTimeHour =
                                                              stationFromTimeString
                                                                  .split(
                                                                      ':')[0];
                                                          String
                                                              stationFromTimeMinute =
                                                              stationFromTimeString
                                                                  .split(
                                                                      ':')[1];
                                                          String
                                                              stationToTimeString =
                                                              _choNowSettingsController
                                                                  .pagingController
                                                                  .itemList!
                                                                  .elementAt(
                                                                      index)
                                                                  .timeRange
                                                                  .split(
                                                                      ' - ')[1];
                                                          String
                                                              stationToTimeHour =
                                                              stationToTimeString
                                                                  .split(
                                                                      ':')[0];
                                                          String
                                                              stationToTimeMinute =
                                                              stationToTimeString
                                                                  .split(
                                                                      ':')[1];
                                                          TimeOfDay
                                                              stationFromTime =
                                                              TimeOfDay(
                                                                  hour: int
                                                                      .tryParse(
                                                                          stationFromTimeHour)!,
                                                                  minute: int
                                                                      .tryParse(
                                                                          stationFromTimeMinute)!);
                                                          TimeOfDay
                                                              stationToTime =
                                                              TimeOfDay(
                                                                  hour: int
                                                                      .tryParse(
                                                                          stationToTimeHour)!,
                                                                  minute: int
                                                                      .tryParse(
                                                                          stationToTimeMinute)!);

                                                          _showAddPickUpStationDialog(
                                                              context: context,
                                                              stationName:
                                                                  _choNowSettingsController
                                                                      .pagingController
                                                                      .itemList!
                                                                      .elementAt(
                                                                          index)
                                                                      .stationName,
                                                              from:
                                                                  stationFromTime,
                                                              to: stationToTime,
                                                              index: index);
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  firstPageErrorIndicatorBuilder:
                                                      (BuildContext context) {
                                                    return LazyLoadingListErrorBuilder(
                                                        onPressed: () {
                                                      _choNowSettingsController
                                                          .pagingController
                                                          .refresh();
                                                    });
                                                  }),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 25.0),
                                          child: CustomTextButton(
                                              width: double.infinity,
                                              backgroundColor: Colors.white,
                                              foregroundColor:
                                                  CustomColors.kBlue,
                                              text: CustomStrings
                                                  .kAddPickUpStation.tr,
                                              onPressedFunc: () {
                                                _showAddPickUpStationDialog(
                                                    context: context);
                                              },
                                              hasBorder: true),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              headerAnimationLoop: false,
                              desc: CustomErrorsString.kDevelopError.tr)
                          .show();
                      return SizedBox.shrink();
                    }
                  } else {
                    return Loading();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
