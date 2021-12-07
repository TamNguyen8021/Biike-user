import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/ui/android/pages/book_trip/widget/book_scheduled_trip_button.dart';
import 'package:bikes_user/app/ui/android/pages/book_trip/widget/date_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/choose_date_time_button.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'book_schedule_trip' screen
class BookScheduleTripPage extends StatelessWidget {
  final _bookTripController = Get.find<BookTripController>();

  @override
  Widget build(BuildContext context) {
    return OnBackPressed(
        perform: () => Get.back(),
        child: Scaffold(
          appBar: CustomAppBar(
            hasShape: true,
            hasLeading: true,
            onPressedFunc: () {
              Get.back();
            },
            isVisible: true,
            appBar: AppBar(),
            title: Text(CustomStrings.kBookScheduleTrip.tr),
            actionWidgets: <Widget>[
              CommonFunctions().lightBulbIcon(
                  context, CustomStrings.kRuleWhenBookTrip,
                  contents: CustomStrings.kRulesWhenBookTrip),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    CustomStrings.kTime.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Wrap(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DateButton(
                              date: _bookTripController.dateList.elementAt(0)),
                          DateButton(
                              date: _bookTripController.dateList.elementAt(1)),
                          DateButton(
                              date: _bookTripController.dateList.elementAt(2)),
                          DateButton(
                              date: _bookTripController.dateList.elementAt(3)),
                          DateButton(
                              date: _bookTripController.dateList.elementAt(4)),
                          DateButton(
                              date: _bookTripController.dateList.elementAt(5)),
                          DateButton(
                              date: _bookTripController.dateList.elementAt(6)),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    CustomStrings.kTime.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                    child: Obx(
                      () => ChooseDateTimeButton(
                          isOnProfilePage: false,
                          text: _bookTripController.isTimeSelected.value
                              ? '${_bookTripController.selectedTime.value.format(context)}'
                                  .split(' ')[0]
                              : CustomStrings.kChooseTime.tr,
                          onPressedFunc: () =>
                              _bookTripController.selectTime(context)),
                    ),
                  ),
                  BookScheduledTripButton(),
                ],
              ),
            ),
          ),
        ));
  }
}
