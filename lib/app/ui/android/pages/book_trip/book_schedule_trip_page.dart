import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/data/enums/date_enum.dart';
import 'package:bikes_user/app/ui/android/pages/book_trip/widget/book_scheduled_trip_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/choose_date_time_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/date_button.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'book_schedule_trip' screen
class BookScheduleTripPage extends StatelessWidget {
  final _bookTripController = Get.find<BookTripController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.lightbulb),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Obx(
                      () => ChooseDateTimeButton(
                          isOnProfilePage: false,
                          text: _bookTripController.isDateSelected.value
                              ? '${_bookTripController.selectedDate.value.toLocal()}'
                                  .split(' ')[0]
                              : CustomStrings.kChooseDate.tr,
                          onPressedFunc: () =>
                              _bookTripController.selectDate(context)),
                    ),
                    Obx(
                      () => ChooseDateTimeButton(
                          isOnProfilePage: false,
                          text: _bookTripController.isTimeSelected.value
                              ? '${_bookTripController.selectedTime.value.format(context)}'
                                  .split(' ')[0]
                              : CustomStrings.kChooseTime.tr,
                          onPressedFunc: () =>
                              _bookTripController.selectTime(context)),
                    ),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     TimeButton(time: '06:30'),
              //     TimeButton(time: '07:15'),
              //     TimeButton(time: '10:00'),
              //     TimeButton(time: '12:00'),
              //     TimeButton(time: '13:45'),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      CustomStrings.kRepeat.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    Obx(
                      () => Switch(
                        value: _bookTripController.isRepeated.value,
                        onChanged: (bool value) {
                          _bookTripController.changeRepeat();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Visibility(
                  visible: _bookTripController.isRepeated.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      DateButton(date: Date.monday),
                      DateButton(date: Date.tuesday),
                      DateButton(date: Date.wednesday),
                      DateButton(date: Date.thursday),
                      DateButton(date: Date.friday),
                      DateButton(date: Date.saturday),
                      DateButton(date: Date.sunday),
                    ],
                  ),
                ),
              ),
              BookScheduledTripButton(),
            ],
          ),
        ),
      ),
    );
  }
}
