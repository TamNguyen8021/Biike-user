import 'dart:async';

import 'package:bikes_user/app/common/values/custom_objects/custom_location.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class BookTripMapViewer extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();
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
    CustomLocation departure = CustomLocation(coordinate: departureCoordinate);
    CustomLocation destination =
        CustomLocation(coordinate: destinationCoordinate);

    double departureLatitude = departure.latitude;
    double departureLongtitude = departure.longitude;
    double destinationLatitude = destination.latitude;
    double destinationLongtitude = destination.longitude;

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 150.0,
          margin: const EdgeInsets.only(top: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng((departureLatitude + destinationLatitude) / 2,
                    (departureLongtitude + destinationLongtitude) / 2),
                zoom: 12,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: <Marker>{
                Marker(
                  markerId: MarkerId('departure'),
                  position: LatLng(departureLatitude, departureLongtitude),
                  infoWindow: InfoWindow(
                      title: CustomStrings.kStartLocation.tr, snippet: 'Info'),
                ),
                Marker(
                    markerId: MarkerId('destination'),
                    position:
                        LatLng(destinationLatitude, destinationLongtitude),
                    infoWindow: InfoWindow(
                        title: CustomStrings.kEndLocation.tr, snippet: 'Info'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen)),
              },
              polylines: <Polyline>{
                Polyline(
                    polylineId: PolylineId('route'),
                    color: CustomColors.kBlue,
                    width: 5,
                    points: _bookTripController.polypoints.toList())
              },
            ),
          ),
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
