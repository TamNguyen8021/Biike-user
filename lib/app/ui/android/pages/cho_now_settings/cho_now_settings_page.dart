import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/cho_now_settings_controller.dart';
import 'package:bikes_user/app/data/models/station.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/choose_date_time_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoNowSettingsPage extends StatelessWidget {
  final _choNowSettingsController = Get.find<ChoNowSettingsController>();

  ChoNowSettingsPage({Key? key}) : super(key: key);

  /// Show dialog when user taps lightbulb icon
  ///
  /// Author: TamNTT
  Future<void> _showHintDialog({required BuildContext context}) async {
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
                    CustomStrings.kChoNow.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: CustomColors.kDarkGray),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      CustomStrings.kChoNowDescription1.tr,
                      style: TextStyle(
                        color: CustomColors.kDarkGray,
                      ),
                    ),
                  ),
                  Text(
                    CustomStrings.kChoNowDescription2.tr,
                    style: TextStyle(
                      color: CustomColors.kDarkGray,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      CustomStrings.kChoNowDescription3.tr,
                      style: TextStyle(
                        color: CustomColors.kDarkGray,
                      ),
                    ),
                  ),
                  Center(
                    child: CustomTextButton(
                        backgroundColor: CustomColors.kBlue,
                        foregroundColor: Colors.white,
                        text: CustomStrings.kGotIt.tr,
                        onPressedFunc: () {
                          Get.back();
                        },
                        hasBorder: false),
                  )
                ],
              ),
            ),
          );
        });
  }

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
          MaterialLocalizations.of(context).formatTimeOfDay(
              _choNowSettingsController.fromTime.value!,
              alwaysUse24HourFormat: true);
    }

    if (to != null) {
      _choNowSettingsController.toTime.value = to;
      _choNowSettingsController.toTimeString.value =
          MaterialLocalizations.of(context).formatTimeOfDay(
              _choNowSettingsController.toTime.value!,
              alwaysUse24HourFormat: true);
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
                          Obx(
                            () => Container(
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
                              child: DropdownButtonFormField<Station>(
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
                                      await CommonFunctions().selectTime(
                                          context: context,
                                          selectedTime:
                                              _choNowSettingsController
                                                  .fromTime);
                                  _choNowSettingsController
                                          .fromTimeString.value =
                                      MaterialLocalizations.of(context)
                                          .formatTimeOfDay(
                                              _choNowSettingsController
                                                  .fromTime.value!,
                                              alwaysUse24HourFormat: true);
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
                                      await CommonFunctions().selectTime(
                                          context: context,
                                          selectedTime:
                                              _choNowSettingsController.toTime);
                                  _choNowSettingsController.toTimeString.value =
                                      MaterialLocalizations.of(context)
                                          .formatTimeOfDay(
                                              _choNowSettingsController
                                                  .toTime.value!,
                                              alwaysUse24HourFormat: true);
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
                                      width: 80,
                                      backgroundColor: CustomColors.kRed,
                                      foregroundColor: Colors.white,
                                      text: CustomStrings.kDelete.tr,
                                      onPressedFunc: () {
                                        _choNowSettingsController
                                            .deletePickUpStation(index: index!);
                                      },
                                      hasBorder: false),
                                ),
                                CustomTextButton(
                                    width: 80,
                                    backgroundColor: CustomColors.kBlue,
                                    foregroundColor: Colors.white,
                                    text: CustomStrings.kEdit.tr,
                                    onPressedFunc: () {
                                      _choNowSettingsController.editPickUpStation(
                                          index: index!,
                                          name: _choNowSettingsController
                                              .selectedStation.value.name,
                                          timeRange: MaterialLocalizations.of(
                                                      context)
                                                  .formatTimeOfDay(
                                                      _choNowSettingsController
                                                          .fromTime.value!,
                                                      alwaysUse24HourFormat:
                                                          true) +
                                              ' - ' +
                                              MaterialLocalizations.of(context)
                                                  .formatTimeOfDay(
                                                      _choNowSettingsController
                                                          .toTime.value!,
                                                      alwaysUse24HourFormat:
                                                          true));
                                    },
                                    hasBorder: false),
                              ] else ...[
                                CustomTextButton(
                                    backgroundColor: CustomColors.kBlue,
                                    foregroundColor: Colors.white,
                                    text: CustomStrings.kAdd.tr,
                                    onPressedFunc: () {
                                      if (_choNowSettingsController
                                          .checkIfAllFieldsHaveData()) {
                                        if ((_choNowSettingsController
                                                        .fromTime.value!.hour *
                                                    60 +
                                                _choNowSettingsController
                                                    .fromTime.value!.minute) >=
                                            _choNowSettingsController
                                                        .toTime.value!.hour *
                                                    60 +
                                                _choNowSettingsController
                                                    .toTime.value!.minute) {
                                          CommonFunctions().showErrorDialog(
                                              context: context,
                                              message: CustomErrorsString
                                                  .kFromTimeMustBeBeforeToTime
                                                  .tr);
                                        } else {
                                          _choNowSettingsController
                                              .addPickUpStation(
                                                  context: context);
                                        }
                                      } else {
                                        CommonFunctions().showErrorDialog(
                                            context: context,
                                            message: CustomErrorsString
                                                .kNotFillAllFields.tr);
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
    Rx<bool> _isStationShowed = true.obs;

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
        ),
        actionWidgets: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                _showHintDialog(context: context);
              },
              icon: Icon(Icons.lightbulb),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22.0),
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
                margin: const EdgeInsets.only(top: 16.0, bottom: 10.0),
                padding: const EdgeInsets.only(left: 16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CustomColors.kLightGray,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: CustomColors.kDarkGray.withOpacity(0.3),
                        // changes position of shadow
                        offset: Offset(0, 1.25),
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(CustomStrings.kTurnOnChoNow.tr),
                    Obx(
                      () => Switch(
                        value: _choNowSettingsController.isChoNowOn.value,
                        onChanged: (bool isOn) {
                          _choNowSettingsController.isChoNowOn.value = isOn;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Visibility(
                  visible: _choNowSettingsController.isChoNowOn.value,
                  child: Container(
                    height: 45,
                    margin: const EdgeInsets.only(bottom: 8.0),
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: CustomColors.kLightGray,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: CustomColors.kDarkGray.withOpacity(0.3),
                            // changes position of shadow
                            offset: Offset(0, 1.25),
                          )
                        ]),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(CustomStrings.kChoNowStation.tr),
                          Icon(
                            _isStationShowed.value
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            size: 35,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      onTap: () {
                        _isStationShowed.value = !_isStationShowed.value;
                      },
                    ),
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: _choNowSettingsController.isChoNowOn.value &&
                      _isStationShowed.value,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount:
                          _choNowSettingsController.pickUpStations.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: _choNowSettingsController.pickUpStations
                              .elementAt(index),
                          onTap: () {
                            String stationFromTimeString =
                                _choNowSettingsController.pickUpStations
                                    .elementAt(index)
                                    .timeRange
                                    .value
                                    .split(' - ')[0];
                            String stationFromTimeHour =
                                stationFromTimeString.split(':')[0];
                            String stationFromTimeMinute =
                                stationFromTimeString.split(':')[1];
                            String stationToTimeString =
                                _choNowSettingsController.pickUpStations
                                    .elementAt(index)
                                    .timeRange
                                    .value
                                    .split(' - ')[1];
                            String stationToTimeHour =
                                stationToTimeString.split(':')[0];
                            String stationToTimeMinute =
                                stationToTimeString.split(':')[1];
                            TimeOfDay stationFromTime = TimeOfDay(
                                hour: int.tryParse(stationFromTimeHour)!,
                                minute: int.tryParse(stationFromTimeMinute)!);
                            TimeOfDay stationToTime = TimeOfDay(
                                hour: int.tryParse(stationToTimeHour)!,
                                minute: int.tryParse(stationToTimeMinute)!);

                            _showAddPickUpStationDialog(
                                context: context,
                                stationName: _choNowSettingsController
                                    .pickUpStations
                                    .elementAt(index)
                                    .stationName
                                    .value,
                                from: stationFromTime,
                                to: stationToTime,
                                index: index);
                          },
                        );
                      }),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: _choNowSettingsController.isChoNowOn.value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: CustomTextButton(
                        width: double.infinity,
                        backgroundColor: Colors.white,
                        foregroundColor: CustomColors.kBlue,
                        text: CustomStrings.kAddPickUpStation.tr,
                        onPressedFunc: () {
                          _showAddPickUpStationDialog(context: context);
                        },
                        hasBorder: true),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
