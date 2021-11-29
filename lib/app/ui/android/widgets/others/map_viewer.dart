import 'dart:async';

import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_objects/custom_location.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class MapViewer extends StatelessWidget {
  final Completer<GoogleMapController> completerController;
  final List<LatLng> polypoints;
  final LocationData? userLocation;
  final String departureCoordinate;
  final String destinationCoordinate;
  final bool isFullMap;

  MapViewer(
      {Key? key,
      required this.isFullMap,
      required this.completerController,
      required this.polypoints,
      this.userLocation,
      required this.departureCoordinate,
      required this.destinationCoordinate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomLocation departure = CustomLocation(coordinate: departureCoordinate);
    CustomLocation destination =
        CustomLocation(coordinate: destinationCoordinate);

    Rx<bool> isViewRouteInstructionButtonVisible = true.obs;

    if (isFullMap) {
      isViewRouteInstructionButtonVisible.value = false;
    }

    final Widget googleMap = Container(
      width: double.infinity,
      height: isFullMap ? null : 200.0,
      margin: EdgeInsets.only(top: isFullMap ? 0.0 : 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isFullMap ? 0.0 : 5.0),
        child: FutureBuilder(
            future: CommonFunctions().getRoutePoints(
                polypoints: polypoints,
                startLat: departure.latitude,
                startLng: departure.longitude,
                endLat: destination.latitude,
                endLng: destination.longitude),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GoogleMap(
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        (departure.latitude + destination.latitude) / 2,
                        (departure.longitude + destination.longitude) / 2),
                    zoom: isFullMap ? 14 : 12,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    completerController.complete(controller);
                  },
                  markers: <Marker>{
                    Marker(
                      markerId: MarkerId('departure'),
                      position: LatLng(departure.latitude, departure.longitude),
                      infoWindow: InfoWindow(
                          title: CustomStrings.kStartLocation.tr,
                          snippet: 'Info'),
                    ),
                    Marker(
                        markerId: MarkerId('destination'),
                        position:
                            LatLng(destination.latitude, destination.longitude),
                        infoWindow: InfoWindow(
                            title: CustomStrings.kEndLocation.tr,
                            snippet: 'Info'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueGreen)),
                  },
                  polylines: <Polyline>{
                    Polyline(
                        polylineId: PolylineId('route'),
                        color: CustomColors.kBlue.withOpacity(0.5),
                        width: 5,
                        points: polypoints)
                  },
                );
              } else {
                return Loading();
              }
            }),
      ),
    );

    return Column(
      children: <Widget>[
        if (isFullMap) ...[
          Expanded(child: googleMap),
        ] else ...[
          googleMap,
        ],
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
                        'http://maps.google.com/maps?saddr=${departure.latitude},${departure.longitude}&daddr=${destination.latitude},${destination.longitude}&travelmode=driving';
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
