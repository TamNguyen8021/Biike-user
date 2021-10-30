import 'package:bikes_user/app/common/values/custom_objects/custom_location.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class TripDetailsMapViewer extends StatelessWidget {
  final TripDetailsController tripDetailsController;
  final String departureCoordinate;
  final String destinationCoordinate;

  TripDetailsMapViewer(
      {Key? key,
      required this.tripDetailsController,
      required this.departureCoordinate,
      required this.destinationCoordinate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomLocation departure = CustomLocation(coordinate: departureCoordinate);
    CustomLocation destination = CustomLocation(coordinate: destinationCoordinate);

    double departureLatitude = departure.latitude;
    double departureLongitude = departure.longitude;
    double destinationLatitude = destination.latitude;
    double destinationLongitude = destination.longitude;

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 150.0,
          margin: const EdgeInsets.only(top: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FutureBuilder(
                future: tripDetailsController.getRoutePoints(
                    departureLongitude.toString(),
                    departureLatitude.toString(),
                    destinationLongitude.toString(),
                    destinationLatitude.toString()),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return FlutterMap(
                      options: MapOptions(
                          onPositionChanged:
                              (MapPosition position, bool isChanged) {},
                          center: LatLng(
                              (departureLatitude + destinationLatitude) / 2,
                              (departureLongitude + destinationLongitude) /
                                  2),
                          zoom: 12.0),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayerOptions(markers: <Marker>[
                          Marker(
                              point: LatLng(
                                  departureLatitude, departureLongitude),
                              builder: (BuildContext context) {
                                return Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                  size: 25,
                                );
                              }),
                          Marker(
                              point: LatLng(
                                  destinationLatitude, destinationLongitude),
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
                                  color: Colors.purpleAccent.withOpacity(0.5),
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
        CustomTextButton(
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
      ],
    );
  }
}
