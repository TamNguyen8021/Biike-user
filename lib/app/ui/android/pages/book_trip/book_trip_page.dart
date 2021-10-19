import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/ui/android/pages/book_trip/widget/ke_now_button.dart';
import 'package:bikes_user/app/ui/android/pages/book_trip/widget/schedule_trip_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/android/widgets/others/map_viewer.dart';
import 'package:bikes_user/app/ui/android/widgets/others/station_dropdown_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'book_trip' screen
class BookTripPage extends StatelessWidget {
  final _bookTripController = Get.find<BookTripController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        onPressedFunc: () {
          Get.back();
        },
        appBar: AppBar(),
        title: Text(CustomStrings.kBookNewTrip.tr),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _bookTripController.initial(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return new Container();
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(CustomStrings.kFrom.tr),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Obx(() => StationDropdownButton(
                        dropdownValue: _bookTripController.departureStation.value,
                        dropdownArray: _bookTripController.listDepartureStation,
                        onChangedFunc: (value) {
                          _bookTripController.updateDepartureStation(value);
                          }
                        ),
                      ),
                    ),
                    Text(CustomStrings.kTo.tr),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Obx(() =>
                          StationDropdownButton(
                            dropdownValue: _bookTripController.destinationStation.value,
                            dropdownArray: _bookTripController.listDestinationStation,
                            onChangedFunc: (value) {
                              _bookTripController.updateDestinationStation(value);
                            }
                          ),
                      ),
                    ),
                    Obx(() => MapViewer(
                        departureCoordinate: _bookTripController.departureStation.value.coordinate,
                        destinationCoordinate: _bookTripController.destinationStation.value.coordinate),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Obx(() =>
                            Text(
                              '0 phút', //TODO
                          style: TextStyle(
                            color: CustomColors.kBlue,
                          ),
                        ),
                        // ),
                        // Obx(() =>
                            Text(
                              '0 km', //TODO
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        // ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ScheduleTripButton(),
                          KeNowButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Loading();
            }
          }
        ),
      ),
    );
  }
}
