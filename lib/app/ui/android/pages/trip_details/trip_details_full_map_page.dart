import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/trip_details_controller.dart';
import 'package:bikes_user/app/ui/android/pages/trip_details/widgets/trip_details_map_viewer.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TripDetailsFullMapPage extends StatelessWidget {
  final _tripDetailsController = Get.find<TripDetailsController>();

  TripDetailsFullMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _departureCoordinate =
        _tripDetailsController.departureStation.departureCoordinate;
    final String _destinationCoordinate =
        _tripDetailsController.destinationStation.destinationCoordinate;

    return GetBuilder(
        init: _tripDetailsController,
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              isVisible: true,
              hasShape: true,
              hasLeading: true,
              onPressedFunc: () async {
                await _tripDetailsController.getTripDetails(
                    tripId: Get.arguments['tripId']);
                Get.back();
              },
              appBar: AppBar(),
              title: Text(CustomStrings.kTripDetails.tr),
              actionWidgets: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 22.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _tripDetailsController.showHelpCenter(context: context);
                    },
                    icon: Icon(
                      Icons.support,
                      color: CustomColors.kBlue,
                    ),
                    label: Text(
                      CustomStrings.kSupport.tr,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: CustomColors.kBlue),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: <Widget>[
                TripDetailsMapViewer(
                    isFullMap: true,
                    // mapController: mapController,
                    tripDetailsController: _tripDetailsController,
                    departureCoordinate: _departureCoordinate,
                    destinationCoordinate: _destinationCoordinate),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 16.0),
                  child: CustomTextButton(
                      hasBorder: true,
                      width: double.infinity,
                      backgroundColor: Colors.white,
                      foregroundColor: CustomColors.kBlue,
                      text: CustomStrings.kMinimizeMap.tr,
                      onPressedFunc: () async {
                        await _tripDetailsController.getTripDetails(
                            tripId: Get.arguments['tripId']);
                        Get.back();
                      }),
                )
              ],
            ),
          );
        });
  }
}
