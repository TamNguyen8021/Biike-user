import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bikes_user/app/common/values/custom_objects/custom_location.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
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
                target: LatLng((departure.latitude + destination.latitude) / 2,
                    (departure.longitude + destination.longitude) / 2),
                zoom: 12,
              ),
              onMapCreated: (GoogleMapController controller) =>
                  _controller.complete(controller),
              markers: <Marker>{
                Marker(
                  markerId: MarkerId('departure'),
                  position: LatLng(departure.latitude, departure.longitude),
                  infoWindow: InfoWindow(
                      title: CustomStrings.kStartLocation.tr, snippet: 'Info'),
                ),
                Marker(
                    markerId: MarkerId('destination'),
                    position:
                        LatLng(destination.latitude, destination.longitude),
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
                    points: _bookTripController.polypoints),
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
              String url = UrlStrings.getGoogleMapUrl(departure, destination);
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
                '${(_bookTripController.roadDuration.value).toStringAsFixed(MAX_AFTER_POINT)} ${CustomStrings.kMins.tr}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: CustomColors.kBlue, fontSize: 12.sp),
              ),
            ),
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
