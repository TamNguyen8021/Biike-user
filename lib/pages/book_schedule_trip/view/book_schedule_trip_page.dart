import 'package:bikes_user/pages/book_schedule_trip/controller/book_schedule_trip_controller.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/choose_date_time_button.dart';
import 'package:bikes_user/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/widgets/buttons/date_button.dart';
import 'package:bikes_user/widgets/buttons/time_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 'book_schedule_trip' screen
class BookScheduleTripPage extends StatelessWidget {
  final bookScheduleTripController = Get.find<BookScheduleTripController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        hasShape: true,
        hasLeading: true,
        isVisible: true,
        appBar: AppBar(),
        title: Text(CustomStrings.kBookScheduleTrip),
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
                CustomStrings.kTime,
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
                          text: bookScheduleTripController.isDateSelected.value
                              ? '${bookScheduleTripController.selectedDate.value.toLocal()}'
                                  .split(' ')[0]
                              : CustomStrings.kChooseDate,
                          onPressedFunc: () =>
                              bookScheduleTripController.selectDate(context)),
                    ),
                    Obx(
                      () => ChooseDateTimeButton(
                          text: bookScheduleTripController.isTimeSelected.value
                              ? '${bookScheduleTripController.selectedTime.value.format(context)}'
                                  .split(' ')[0]
                              : CustomStrings.kChooseTime,
                          onPressedFunc: () =>
                              bookScheduleTripController.selectTime(context)),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TimeButton(time: '06:30'),
                  TimeButton(time: '07:15'),
                  TimeButton(time: '10:00'),
                  TimeButton(time: '12:00'),
                  TimeButton(time: '13:45'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      CustomStrings.kRepeat,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    Obx(
                      () => Switch(
                        value: bookScheduleTripController.isRepeated.value,
                        onChanged: (bool value) {
                          bookScheduleTripController.changeRepeat();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Visibility(
                  visible: bookScheduleTripController.isRepeated.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          DateButton(date: 'T2'),
                          DateButton(date: 'T3'),
                          DateButton(date: 'T4'),
                          DateButton(date: 'T5'),
                          DateButton(date: 'T6'),
                          DateButton(date: 'T7'),
                          DateButton(date: 'CN'),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
                        child: Text(
                          CustomStrings.kRepeatTo,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                      Obx(
                        () => ChooseDateTimeButton(
                            text: bookScheduleTripController
                                    .isRepeatedDateSelected.value
                                ? '${bookScheduleTripController.repeatedDate.value.toLocal()}'
                                    .split(' ')[0]
                                : CustomStrings.kChooseDate,
                            onPressedFunc: () => bookScheduleTripController
                                .selectRepeatingDate(context)),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: CustomTextButton(
                    backgroundColor: CustomColors.kOrange,
                    foregroundColor: Colors.white,
                    width: 135,
                    text: CustomStrings.kBookScheduleTrip,
                    onPressedFunc: () => Get.offAllNamed('/customerHome'),
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
