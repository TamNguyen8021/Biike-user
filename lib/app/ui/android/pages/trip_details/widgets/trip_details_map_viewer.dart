import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class TripDetailsMapViewer extends StatelessWidget {
  final TripDetailsController tripDetailsController;
  final String departureCoordinate;
  final String destinationCoordinate;
  final bool isFullMap;

  TripDetailsMapViewer(
      {Key? key,
      required this.isFullMap,
      required this.tripDetailsController,
      required this.departureCoordinate,
      required this.destinationCoordinate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _departureLatitude =
        double.tryParse(departureCoordinate.split(',')[0]) ?? 10.84165;
    double _departureLongtitude =
        double.tryParse(departureCoordinate.split(',')[1]) ?? 106.80965;
    double _destinationLatitude =
        double.tryParse(destinationCoordinate.split(',')[0]) ?? 10.84165;
    double _destinationLongtitude =
        double.tryParse(destinationCoordinate.split(',')[1]) ?? 106.80965;

    Rx<bool> isViewRouteInstructionButtonVisible = true.obs;

    if (isFullMap) {
      isViewRouteInstructionButtonVisible.value = false;
    }

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: isFullMap
              ? MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  88.0
              : 150.0,
          margin: EdgeInsets.only(top: isFullMap ? 0.0 : 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isFullMap ? 0.0 : 5.0),
            child: FutureBuilder(
                future: tripDetailsController.getRoutePoints(
                    _departureLongtitude.toString(),
                    _departureLatitude.toString(),
                    _destinationLongtitude.toString(),
                    _destinationLatitude.toString()),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return FlutterMap(
                      options: MapOptions(
                          onPositionChanged:
                              (MapPosition position, bool isChanged) {},
                          center: LatLng(
                              (_departureLatitude + _destinationLatitude) / 2,
                              (_departureLongtitude + _destinationLongtitude) /
                                  2),
                          zoom: isFullMap ? 14.0 : 12.0,
                          onTap:
                              (TapPosition tapPosition, LatLng latLng) async {
                            tripDetailsController.showLocationDetails(
                                context: context,
                                latitude: latLng.latitude,
                                longtitude: latLng.longitude);
                          }),
                      layers: <LayerOptions>[
                        TileLayerOptions(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                          retinaMode: true &&
                              MediaQuery.of(context).devicePixelRatio > 1.0,
                          attributionBuilder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: <Widget>[
                                  Text(
                                    '© OpenStreetMap contributors',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3
                                        ..color = Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '© OpenStreetMap contributors',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        MarkerLayerOptions(markers: <Marker>[
                          Marker(
                              rotate: true,
                              point: LatLng(
                                  _departureLatitude, _departureLongtitude),
                              builder: (BuildContext context) {
                                return Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                  size: 25,
                                );
                              }),
                          Marker(
                              rotate: true,
                              point: LatLng(
                                  _destinationLatitude, _destinationLongtitude),
                              builder: (BuildContext context) {
                                return Icon(
                                  Icons.location_on,
                                  color: CustomColors.kRed,
                                  size: 25,
                                );
                              }),
                        ]),
                        PolylineLayerOptions(
                            polylineCulling: true,
                            polylines: <Polyline>[
                              Polyline(
                                  color: Colors.purple.withOpacity(0.5),
                                  strokeWidth: 5,
                                  points: tripDetailsController.polypoints
                                      .toList()),
                            ])
                      ],
                    );
                  } else {
                    return Loading();
                  }
                }),
          ),
        ),
        Obx(
          () => Visibility(
            visible: isViewRouteInstructionButtonVisible.value,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomTextButton(
                  hasBorder: true,
                  width: double.infinity,
                  backgroundColor: Colors.white,
                  foregroundColor: CustomColors.kBlue,
                  text: CustomStrings.kViewRouteInstruction.tr,
                  onPressedFunc: () async {
                    String url =
                        'https://www.openstreetmap.org/directions?engine=fossgis_osrm_bike&route=10.8414%2C106.8100%3B10.8491%2C106.7740';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
