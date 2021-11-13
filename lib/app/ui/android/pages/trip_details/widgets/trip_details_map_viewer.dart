import 'dart:async';

import 'package:bikes_user/app/common/values/custom_objects/custom_location.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class TripDetailsMapViewer extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();
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
    CustomLocation departure = CustomLocation(coordinate: departureCoordinate);
    CustomLocation destination =
        CustomLocation(coordinate: destinationCoordinate);

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
              : 200.0,
          margin: EdgeInsets.only(top: isFullMap ? 0.0 : 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isFullMap ? 0.0 : 5.0),
            child: FutureBuilder(
                future: tripDetailsController.getRoutePoints(
                    departure.longitude,
                    departure.latitude,
                    destination.longitude,
                    destination.latitude),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            (departure.latitude + destination.latitude) / 2,
                            (departure.longitude + destination.longitude) / 2),
                        zoom: 12,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      markers: <Marker>{
                        Marker(
                          markerId: MarkerId('departure'),
                          position:
                              LatLng(departure.latitude, departure.longitude),
                          infoWindow: InfoWindow(
                              title: CustomStrings.kStartLocation.tr,
                              snippet: 'Info'),
                        ),
                        Marker(
                            markerId: MarkerId('destination'),
                            position: LatLng(
                                destination.latitude, destination.longitude),
                            infoWindow: InfoWindow(
                                title: CustomStrings.kEndLocation.tr,
                                snippet: 'Info'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueGreen)),
                        if (tripDetailsController.userLocation != null) ...[
                          Marker(
                              markerId: MarkerId('user'),
                              position: LatLng(
                                  tripDetailsController.userLocation!.latitude!,
                                  tripDetailsController
                                      .userLocation!.longitude!),
                              infoWindow: InfoWindow(
                                  title: CustomStrings.kYourLocation.tr,
                                  snippet: 'Info'),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueAzure)),
                        ]
                      },
                      polylines: <Polyline>{
                        Polyline(
                            polylineId: PolylineId('route'),
                            color: CustomColors.kBlue,
                            width: 5,
                            points: tripDetailsController.polypoints)
                      },
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
                    String url = UrlStrings.getGoogleMapUrl(departure, destination);
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
