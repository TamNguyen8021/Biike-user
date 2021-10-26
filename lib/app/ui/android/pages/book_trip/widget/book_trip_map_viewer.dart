import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class BookTripMapViewer extends StatelessWidget {
  final _bookTripController = Get.find<BookTripController>();

  final String departureCoordinate;
  final String destinationCoordinate;

  /// Số chữ số tối đa sau dấu thập phân
  static const int MAX_AFTER_POINT = 3;

  BookTripMapViewer(
      {Key? key,
      required this.departureCoordinate,
      required this.destinationCoordinate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _departureLatitude = departureCoordinate != ''
        ? double.parse(departureCoordinate.split(',')[0])
        : 10.84165;
    double _departureLongitude = departureCoordinate != ''
        ? double.parse(departureCoordinate.split(',')[1])
        : 106.80965;
    double _destinationLatitude = destinationCoordinate != ''
        ? double.parse(destinationCoordinate.split(',')[0])
        : 10.84165;
    double _destinationLongitude = destinationCoordinate != ''
        ? double.parse(destinationCoordinate.split(',')[1])
        : 106.80965;

    print('x');

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 150.0,
          margin: const EdgeInsets.only(top: 16.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: FlutterMap(
                options: MapOptions(
                    onPositionChanged:
                        (MapPosition position, bool isChanged) {},
                    center: LatLng(
                        (_departureLatitude + _destinationLatitude) / 2,
                        (_departureLongitude + _destinationLongitude) / 2),
                    zoom: 12.0),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(markers: <Marker>[
                    Marker(
                        point: LatLng(_departureLatitude, _departureLongitude),
                        builder: (BuildContext context) {
                          return Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 20,
                          );
                        }),
                    Marker(
                        point: LatLng(
                            _destinationLatitude, _destinationLongitude),
                        builder: (BuildContext context) {
                          return Icon(
                            Icons.location_on,
                            color: CustomColors.kRed,
                            size: 20,
                          );
                        }),
                  ]),
                  PolylineLayerOptions(
                      polylineCulling: true,
                      polylines: <Polyline>[
                        Polyline(
                            color: Colors.purpleAccent.withOpacity(0.5),
                            strokeWidth: 5,
                            points: _bookTripController.polypoints
                                .toList()),
                      ]
                  ),
                ],
              )
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Obx(
              () => Text(
                '${(_bookTripController.roadDistance.value).toStringAsFixed(MAX_AFTER_POINT)} km',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
