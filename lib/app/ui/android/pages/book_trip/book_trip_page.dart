import 'dart:async';

import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/values/custom_objects/custom_location.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/ui/android/pages/book_trip/widget/ke_now_button.dart';
import 'package:bikes_user/app/ui/android/pages/book_trip/widget/schedule_trip_button.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/android/widgets/others/map_viewer.dart';
import 'package:bikes_user/app/ui/android/widgets/others/station_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// The 'book_trip' screen
class BookTripPage extends StatelessWidget {
  final _bookTripController = Get.find<BookTripController>();
  final _homeController = Get.find<HomeController>();
  final Completer<GoogleMapController> _controller = Completer();

  _onBackPressed() {
    _homeController.pagingController.refresh();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return OnBackPressed(
        child: Scaffold(
          appBar: CustomAppBar(
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
                future: _bookTripController.init(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Container();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22.0, vertical: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(CustomStrings.kFrom.tr),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Obx(
                              () => StationDropdownButton(
                                  dropdownValue: _bookTripController
                                      .departureStation.value,
                                  dropdownArray:
                                      _bookTripController.listDepartureStation,
                                  onChangedFunc: (value) {
                                    _bookTripController
                                        .updateDepartureStation(value);
                                  }),
                            ),
                          ),
                          Text(CustomStrings.kTo.tr),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Obx(
                              () => StationDropdownButton(
                                  dropdownValue: _bookTripController
                                      .destinationStation.value,
                                  dropdownArray: _bookTripController
                                      .listDestinationStation,
                                  onChangedFunc: (value) {
                                    _bookTripController
                                        .updateDestinationStation(value);
                                  }),
                            ),
                          ),
                          Obx(() => MapViewer(
                                isFullMap: false,
                                completerController: _controller,
                                departure: CustomLocation(
                                    coordinate: _bookTripController
                                        .departureStation.value.coordinate),
                                destination: CustomLocation(
                                    coordinate: _bookTripController
                                        .destinationStation.value.coordinate),
                                markers: {
                                  Marker(
                                      markerId: MarkerId('departure'),
                                      position: LatLng(
                                          CustomLocation(
                                                  coordinate:
                                                      _bookTripController
                                                          .departureStation
                                                          .value
                                                          .coordinate)
                                              .latitude,
                                          CustomLocation(
                                                  coordinate:
                                                      _bookTripController
                                                          .departureStation
                                                          .value
                                                          .coordinate)
                                              .longitude),
                                      infoWindow: InfoWindow(
                                          title:
                                              CustomStrings.kStartLocation.tr,
                                          snippet: _bookTripController
                                              .departureStation.value.name)),
                                  Marker(
                                      markerId: MarkerId('destination'),
                                      position: LatLng(
                                          CustomLocation(
                                                  coordinate:
                                                      _bookTripController
                                                          .destinationStation
                                                          .value
                                                          .coordinate)
                                              .latitude,
                                          CustomLocation(
                                                  coordinate:
                                                      _bookTripController
                                                          .destinationStation
                                                          .value
                                                          .coordinate)
                                              .longitude),
                                      infoWindow: InfoWindow(
                                          title: CustomStrings.kEndLocation.tr,
                                          snippet: _bookTripController
                                              .destinationStation.value.name),
                                      icon:
                                          BitmapDescriptor.defaultMarkerWithHue(
                                              BitmapDescriptor.hueGreen)),
                                },
                                polypoints:
                                    _bookTripController.polypoints.toList(),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, bottom: 30.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
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
                }),
          ),
        ),
        perform: () => _onBackPressed());
  }
}
