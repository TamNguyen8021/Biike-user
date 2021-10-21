import 'dart:async';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class MapViewer extends StatelessWidget {
  final _bookTripController = Get.find<BookTripController>();
  final MapController _mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 10.84165, longitude: 106.80965)
  );

  final String departureCoordinate;
  final String destinationCoordinate;

  static const int MAX_AFTER_POINT = 3; // số chữ số tối đa sau dấu thập phân

  MapViewer(
      {Key? key,
        required this.departureCoordinate,
        required this.destinationCoordinate}) : super(key: key);

  Future<void> displayMap() async {
    double departureLatitude = double.parse(departureCoordinate.split(',')[0]);
    double departureLongitude = double.parse(departureCoordinate.split(',')[1]);
    double destinationLatitude = double.parse(destinationCoordinate.split(',')[0]);
    double destinationLongitude = double.parse(destinationCoordinate.split(',')[1]);

    _bookTripController.roadInfo.value = await _mapController.drawRoad(
      GeoPoint(latitude: departureLatitude, longitude: departureLongitude),
      GeoPoint(latitude: destinationLatitude, longitude: destinationLongitude),
      roadType: RoadType.bike,
      roadOption: RoadOption(
        roadWidth: 10,
        roadColor: Colors.deepPurple[200],
        showMarkerOfPOI: true,
      ),
    );
    // print("${roadInfo.distance}km");
    // print("${roadInfo.duration}sec");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 150.0,
          margin: const EdgeInsets.only(top: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child:
            // Obx(() =>
                OSMFlutter(
                  controller: _mapController,
                  trackMyPosition: false,
                  initZoom: 12,
                  minZoomLevel: 8,
                  stepZoom: 1.0,
                  showZoomController: true,
                  showContributorBadgeForOSM: true,
                  userLocationMarker: UserLocationMaker(
                    personMarker: MarkerIcon(
                      icon: Icon(
                        Icons.location_history_rounded,
                        color: Colors.red,
                        size: 48,
                      ),
                    ),
                    directionArrowMarker: MarkerIcon(
                      icon: Icon(
                        Icons.double_arrow,
                        size: 48,
                      ),
                    ),
                  ),
                  road: Road(
                    startIcon: MarkerIcon(
                      icon: Icon(
                        Icons.location_on,
                        size: 64,
                        color: Colors.green,
                      ),
                    ),
                    roadColor: Colors.yellowAccent,
                  ),
                  markerOption: MarkerOption(
                      defaultMarker: MarkerIcon(
                        icon: Icon(
                          Icons.location_on,
                          color: CustomColors.kRed,
                          size: 56,
                        ),
                      )),
                  onMapIsReady: (bool isReady) async {
                    if (isReady) {
                      await displayMap();
                    }
                  },
                ),
            // ),
          ),
        ),
        CustomTextButton(
            backgroundColor: Colors.white,
            foregroundColor: CustomColors.kBlue,
            text: CustomStrings.kOpenStreetMap.tr,
            onPressedFunc: () async {
              String url =
                  'https://www.openstreetmap.org/directions?engine=fossgis_osrm_bike&route=10.8414%2C106.8100%3B10.8491%2C106.7740';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Obx(() =>
              Text(
                _bookTripController.roadInfo.value.duration != null
                ? '${(_bookTripController.roadInfo.value.duration! / 60).toStringAsFixed(MAX_AFTER_POINT)}${CustomStrings.kReminderMinute.tr}'
                : '0.0 ${CustomStrings.kReminderMinute.tr}',
                style: TextStyle(
                  color: CustomColors.kBlue,
                ),
              ),
            ),
            Obx(() =>
              Text(
                _bookTripController.roadInfo.value.distance != null
                    ? '${(_bookTripController.roadInfo.value.distance!).toStringAsFixed(MAX_AFTER_POINT)} km'
                    : '0.0 km',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
