import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class BookTripMapViewer extends StatelessWidget {
  // final _bookTripController = Get.find<BookTripController>();

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
    double _departureLatitude =
        double.tryParse(departureCoordinate.split(',')[0]) ?? 10.84165;
    double _departureLongtitude =
        double.tryParse(departureCoordinate.split(',')[1]) ?? 106.80965;
    double _destinationLatitude =
        double.tryParse(destinationCoordinate.split(',')[0]) ?? 10.84165;
    double _destinationLongtitude =
        double.tryParse(destinationCoordinate.split(',')[1]) ?? 106.80965;

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
                        (_departureLongtitude + _destinationLongtitude) / 2),
                    zoom: 12.0),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(markers: <Marker>[
                    Marker(
                        point: LatLng(_departureLatitude, _departureLongtitude),
                        builder: (BuildContext context) {
                          return Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 20,
                          );
                        }),
                    Marker(
                        point: LatLng(
                            _destinationLatitude, _destinationLongtitude),
                        builder: (BuildContext context) {
                          return Icon(
                            Icons.location_on,
                            color: CustomColors.kRed,
                            size: 20,
                          );
                        }),
                  ]),
                ],
              )),
        ),
        CustomTextButton(
            hasBorder: true,
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
            // Obx(
            //   () => Text(
            // '',
            // _bookTripController.roadInfo.value.duration != null
            //     ? '${(_bookTripController.roadInfo.value.duration! / 60).toStringAsFixed(MAX_AFTER_POINT)}${CustomStrings.kReminderMinute.tr}'
            //     : '0.0 ${CustomStrings.kReminderMinute.tr}',
            //     style: TextStyle(
            //       color: CustomColors.kBlue,
            //     ),
            //   ),
            // ),
            // Obx(
            //   () => Text(
            //     '',
            // _bookTripController.roadInfo.value.distance != null
            //     ? '${(_bookTripController.roadInfo.value.distance!).toStringAsFixed(MAX_AFTER_POINT)} km'
            //     : '0.0 km',
            //     style: Theme.of(context).textTheme.bodyText1,
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
