import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/pages/trip_history/widgets/map_viewer.dart';
import 'package:bikes_user/app/ui/android/pages/trip_history/widgets/station_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 'book_trip' screen
class BookTripPage extends StatelessWidget {
  final bookTripController = Get.find<BookTripController>();

  final List<String> dropdownFromArray = [
    CustomStrings.kChooseFrom.tr,
    'Đại học FPT TP.HCM',
    'Two',
    'Free',
    'Four'
  ];
  final List<String> dropdownToArray = [
    CustomStrings.kChooseTo.tr,
    'Cổng khu công nghệ cao',
    'Two',
    'Free',
    'Four'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        appBar: AppBar(),
        title: Text(CustomStrings.kBookNewTrip.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(CustomStrings.kFrom.tr),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Obx(
                  () => StationDropdownButton(
                    dropdownValue: '${bookTripController.dropdownFromValue}',
                    dropdownArray: dropdownFromArray,
                    onChangedFunc: (value) =>
                        bookTripController.changeDropdownFromValue(value),
                  ),
                ),
              ),
              Text(CustomStrings.kTo.tr),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Obx(
                  () => StationDropdownButton(
                    dropdownValue: '${bookTripController.dropdownToValue}',
                    dropdownArray: dropdownToArray,
                    onChangedFunc: (value) =>
                        bookTripController.changeDropdownToValue(value),
                  ),
                ),
              ),
              MapViewer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '23 phút',
                    style: TextStyle(
                      color: CustomColors.kBlue,
                    ),
                  ),
                  Text(
                    '15.8km',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: CustomTextButton(
                            backgroundColor: CustomColors.kOrange,
                            foregroundColor: Colors.white,
                            text: CustomStrings.kBookScheduleTrip.tr,
                            onPressedFunc: () =>
                                Get.toNamed(CommonRoutes.BOOK_SCHEDULE_TRIP)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: CustomTextButton(
                            backgroundColor: CustomColors.kBlue,
                            foregroundColor: Colors.white,
                            text: CustomStrings.kBookNowTrip.tr,
                            onPressedFunc: () => Get.toNamed(CommonRoutes.FIND_BIKER)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
