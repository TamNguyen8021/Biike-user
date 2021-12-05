import 'dart:convert';

import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/data/enums/trip_status_enum.dart';
import 'package:bikes_user/app/data/models/destination_station.dart';
import 'package:bikes_user/app/data/models/departure_station.dart';
import 'package:bikes_user/app/data/models/notification.dart';
import 'package:bikes_user/app/data/models/trip_feedback.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/pathshare_provider.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/help_center_row.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/services/firebase_realtime_database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:share_plus/share_plus.dart';

class TripDetailsController extends GetxController {
  final _tripProvider = Get.find<TripProvider>();
  final _homeController = Get.find<HomeController>();
  final _profileController = Get.find<ProfileController>();
  final pathshareProvider = Get.find<PathshareProvider>();
  FirebaseRealtimeDatabaseService _databaseService =
      getIt<FirebaseRealtimeDatabaseService>();

  Rx<String> buttonText = CustomStrings.kConfirmArrival.tr.obs;
  Rx<IconData> buttonIcon = Icons.done_all.obs;
  Rx<String> _cancelReason = ''.obs;
  Rx<bool> isArrivedAtPickUpPoint = false.obs;
  Rx<bool> isLocationShared = false.obs;

  Function onPressedFunc = () {};
  Trip trip = Trip.empty();
  User user = User.empty();
  DepartureStation departureStation = DepartureStation.empty();
  DestinationStation destinationStation = DestinationStation.empty();

  /// Feedback of user
  TripFeedback feedback1 = TripFeedback.empty();

  /// Feedback of trip partner
  TripFeedback feedback2 = TripFeedback.empty();

  List<LatLng> polypoints = [];
  LocationData? userLocation;
  String _shareUrl = '';
  String sessionIdentifier = '';
  DateTime? _lastTimeSharedLocation;

  @override
  onInit() async {
    super.onInit();
    userLocation = await CommonFunctions().getCurrentLocation();
  }

  void changeToStartTripButton() {
    if (buttonText.value != CustomStrings.kStart.tr) {
      buttonText.value = CustomStrings.kStart.tr;
    }

    if (buttonIcon.value != Icons.navigation) {
      buttonIcon.value = Icons.navigation;
    }
  }

  void changeToFinishTripButton() {
    if (buttonText.value != CustomStrings.kCompleteTrip.tr) {
      buttonText.value = CustomStrings.kCompleteTrip.tr;
    }

    if (buttonIcon.value != Icons.done_all) {
      buttonIcon.value = Icons.done_all;
    }
  }

  /// Loads trip details.
  ///
  /// Author: TamNTT
  Future<void> getTripDetails({required int tripId}) async {
    var data = await _tripProvider.getTripDetails(tripId: tripId);
    trip = Trip.fromJson(data);
    user = User.fromJson(data);
    departureStation = DepartureStation.fromJson(data);
    destinationStation = DestinationStation.fromJson(data);

    if (data['feedbacks'].length > 0) {
      feedback1 = TripFeedback.fromJson(data['feedbacks'][0]);
      feedback2 = TripFeedback.fromJson(data['feedbacks'][1]);
    }

    if (trip.tripStatus == 3) {
      isArrivedAtPickUpPoint.value = true;
    }
  }

  Future<Map<String, dynamic>> getLocationDetails(
      {required String placeId}) async {
    Map<String, dynamic> data =
        await _tripProvider.getLocationDetails(placeId: placeId);
    return data;
  }

  /// Displays a dialog which shows location details when user tap on map.
  ///
  /// Author: TamNTT
  void showLocationDetails(
      {required BuildContext context, required String placeId}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder(
              future: getLocationDetails(placeId: placeId),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Dialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if ((snapshot.data as Map).containsKey('name') &&
                              snapshot.data['name'] != null) ...[
                            Text(
                              snapshot.data['name'],
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                          if ((snapshot.data['address'] as Map)
                                  .containsKey('road') &&
                              snapshot.data['address']['road'] != null) ...[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                CustomStrings.kRoad.tr +
                                    ': ' +
                                    snapshot.data['address']['road'],
                                style: TextStyle(color: CustomColors.kDarkGray),
                              ),
                            ),
                          ],
                          if ((snapshot.data['address'] as Map)
                                  .containsKey('suburb') &&
                              snapshot.data['address']['suburb'] != null) ...[
                            Text(
                              CustomStrings.kSuburb.tr +
                                  ': ' +
                                  snapshot.data['address']['suburb'],
                              style: TextStyle(color: CustomColors.kDarkGray),
                            ),
                          ],
                          if ((snapshot.data['address'] as Map)
                                  .containsKey('town') &&
                              snapshot.data['address']['town'] != null) ...[
                            Text(
                              CustomStrings.kTown.tr +
                                  ': ' +
                                  snapshot.data['address']['town'],
                              style: TextStyle(color: CustomColors.kDarkGray),
                            ),
                          ],
                          if ((snapshot.data['address'] as Map)
                                  .containsKey('city') &&
                              snapshot.data['address']['city'] != null) ...[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                CustomStrings.kCity.tr +
                                    ': ' +
                                    snapshot.data['address']['city'],
                                style: TextStyle(color: CustomColors.kDarkGray),
                              ),
                            ),
                          ],
                          if ((snapshot.data['address'] as Map)
                                  .containsKey('country') &&
                              snapshot.data['address']['country'] != null) ...[
                            Text(
                              CustomStrings.kCountry.tr +
                                  ': ' +
                                  snapshot.data['address']['country'],
                              style: TextStyle(color: CustomColors.kDarkGray),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                } else {
                  return Loading();
                }
              });
        });
  }

  /// Cancel a trip based on [tripId].
  ///
  /// Author: TamNTT
  /// Updater: UyenNLP
  Future<void> cancelTrip(
      {required BuildContext context,
      required int tripId,
      required String cancelReason}) async {
    Map<String, String> body = {'cancelReason': cancelReason};
    bool response =
        await _tripProvider.cancelTrip(tripId: tripId, body: jsonEncode(body));
    if (response) {
      // await _sendNoti(tripId: tripId, status: TripStatus.canceled);

      Get.back(closeOverlays: true);
      Get.back();
      _homeController.pagingController.refresh();
      CommonFunctions().showSuccessDialog(
          context: context, message: CustomStrings.kCancelTripSuccess);
    } else {
      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kDevelopError.tr);
    }
  }

  /// Send noti to partner when cancel trip
  ///
  /// Author: UyenNLP
  // TODO: handle send noti
  // ignore: unused_element
  _sendNoti({required tripId, required TripStatus status}) async {
    var data = await _tripProvider.getTripDetails(tripId: tripId);
    Trip trip = Trip.fromJson(data);

    // has partner
    if (trip.keerId != null && trip.bikerId != null) {
      var receiverId = Biike.userId.value != trip.keerId // send noti to partner
          ? trip.keerId
          : trip.bikerId;
      BiikeNoti notification = BiikeNoti(
          receiverId: receiverId,
          title: _getNotiTitleByStatus(status),
          content: _getNotiContentByStatus(status),
          url: UrlStrings.tripUrl + '$tripId/details',
          createdDate: DateTime.now());

      await _databaseService.sendNotification(
          receiverId: Biike.userId.value, notification: notification);
    }
  }

  _getNotiTitleByStatus(TripStatus status) {
    switch (status) {
      case TripStatus.canceled:
        return 'Trip canceled';
      case TripStatus.started:
        return 'Trip started';
      default:
        return 'Title';
    }
  }

  _getNotiContentByStatus(TripStatus status) {
    switch (status) {
      case TripStatus.canceled:
        return 'Your trip has been cancel';
      case TripStatus.started:
        return 'Your partner has arrived';
      default:
        return 'Content';
    }
  }

  /// Copies a link which contains user's real-time location to clipboard and shows a share dialog
  ///
  /// Author: TamNTT
  void _shareLink({required BuildContext context}) async {
    if (isLocationShared.isFalse) {
      if (Biike.pathshareUserToken.isEmpty ||
          Biike.pathshareUserIdentifier.isEmpty) {
        Map<String, dynamic> data = await pathshareProvider.createUser(
            userName: _profileController.user.userFullname,
            userPhoneNumber: _profileController.user.userPhoneNumber);
        Biike.pathshareUserToken = data['user']['token'];
        Biike.pathshareUserIdentifier = data['user']['identifier'];
        Biike.localAppData.savePathshareUserToken(Biike.pathshareUserToken);
        Biike.localAppData
            .savePathshareUserIdentifier(Biike.pathshareUserIdentifier);
      }

      if (await pathshareProvider.createUserLocation(
          userLat: userLocation!.latitude!,
          userLng: userLocation!.longitude!)) {
        if (sessionIdentifier.isEmpty ||
            DateTime.now()
                .subtract(Duration(minutes: 30))
                .isAfter(_lastTimeSharedLocation!)) {
          Map<String, dynamic> data = await pathshareProvider.createSession();
          if (data.isNotEmpty) {
            isLocationShared.value = true;
            sessionIdentifier = data['session']['identifier'];
            _shareUrl = data['session']['users'][0]['invitation_url'];
            if (_lastTimeSharedLocation == null) {
              _lastTimeSharedLocation = DateTime.now();
            }
          } else {
            CommonFunctions().showErrorDialog(
                context: context, message: CustomErrorsString.kDevelopError.tr);
          }
        } else {
          isLocationShared.value =
              await pathshareProvider.startOrStopLocationSharing(
                  isShared: true, sessionIdentifier: sessionIdentifier);
        }
      } else {
        CommonFunctions().showErrorDialog(
            context: context, message: CustomErrorsString.kDevelopError.tr);
      }
    }

    Clipboard.setData(ClipboardData(text: _shareUrl));
    Share.share(_shareUrl, subject: CustomStrings.kMyLocation.tr);
  }

  void showCancelReasonDialog(
      {required BuildContext context, required int tripId}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    CustomStrings.kLetUsKnowYourCancelReason.tr,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextFormField(
                      maxLines: 10,
                      style: Theme.of(context).textTheme.bodyText1,
                      onChanged: (String text) {
                        _cancelReason.value = text;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        hintText: CustomStrings.kEnterYourCancelReason.tr,
                        filled: true,
                        fillColor: CustomColors.kLightGray,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          CustomTextButton(
                              hasBorder: false,
                              backgroundColor: CustomColors.kRed,
                              foregroundColor: Colors.white,
                              text: CustomStrings.kCancel.tr,
                              onPressedFunc: () {
                                cancelTrip(
                                    context: context,
                                    tripId: tripId,
                                    cancelReason: _cancelReason.value);
                              }),
                          CustomTextButton(
                              hasBorder: false,
                              backgroundColor: CustomColors.kLightGray,
                              foregroundColor: CustomColors.kDarkGray,
                              text: CustomStrings.kBtnExit.tr,
                              onPressedFunc: () {
                                Get.back();
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Author: TamNTT
  void showHelpCenter({required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      CustomStrings.kHelpCenter.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  HelpCenterRow(
                    icon: Icons.share_outlined,
                    text: CustomStrings.kShareLocation.tr,
                    isLastRow: false,
                    onTapFunc: () async {
                      _shareLink(context: context);
                    },
                  ),
                  Obx(
                    () => Visibility(
                      visible: isLocationShared.value,
                      child: HelpCenterRow(
                        icon: Icons.wrong_location,
                        text: CustomStrings.kStopSharingLocation.tr,
                        isLastRow: false,
                        onTapFunc: () async {
                          if (await pathshareProvider
                              .startOrStopLocationSharing(
                                  isShared: false,
                                  sessionIdentifier: sessionIdentifier)) {
                            isLocationShared.value = false;
                          } else {
                            CommonFunctions().showErrorDialog(
                                context: context,
                                message: CustomErrorsString.kDevelopError.tr);
                          }
                        },
                      ),
                    ),
                  ),
                  HelpCenterRow(
                    icon: Icons.dialpad,
                    text: CustomStrings.kSOSCenter.tr,
                    isLastRow: false,
                    onTapFunc: () {
                      if (isLocationShared.isTrue) {
                        final TextEditingController controller =
                            TextEditingController();
                        Get.defaultDialog(
                          content: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: CustomStrings.kPhoneNo.tr,
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                CommonFunctions().makingSms(
                                    phoneNo: [controller.text],
                                    body: '(Nội dung tiếng Việt): ' +
                                        _shareUrl +
                                        '\n\n(English content): ' +
                                        _shareUrl);
                              },
                              child: Text(CustomStrings.kBtnSend.tr),
                            ),
                          ],
                        );
                      } else {
                        CommonFunctions().showInfoDialog(
                            context: context,
                            message:
                                CustomStrings.kNeedSharingLocationToUseSOS.tr);
                      }
                    },
                  ),
                  HelpCenterRow(
                    icon: Icons.local_police_outlined,
                    text: CustomStrings.kNearestPoliceStation.tr,
                    isLastRow: false,
                    onTapFunc: () async {
                      await CommonFunctions().openMap(
                          keyword: 'công+an',
                          latitude: userLocation!.latitude,
                          longitude: userLocation!.longitude,
                          context: context);
                    },
                  ),
                  HelpCenterRow(
                    icon: Icons.add_box_outlined,
                    text: CustomStrings.kNearestHospital.tr,
                    isLastRow: false,
                    onTapFunc: () async {
                      await CommonFunctions().openMap(
                          keyword: 'bệnh+viện',
                          latitude: userLocation!.latitude,
                          longitude: userLocation!.longitude,
                          context: context);
                    },
                  ),
                  HelpCenterRow(
                    icon: Icons.build_circle_outlined,
                    text: CustomStrings.kNearestMechanicShop.tr,
                    isLastRow: false,
                    onTapFunc: () async {
                      await CommonFunctions().openMap(
                          keyword: 'tiệm+sửa+xe',
                          latitude: userLocation!.latitude,
                          longitude: userLocation!.longitude,
                          context: context);
                    },
                  ),
                  HelpCenterRow(
                    icon: Icons.local_gas_station,
                    text: CustomStrings.kNearestGasStation.tr,
                    isLastRow: true,
                    onTapFunc: () async {
                      await CommonFunctions().openMap(
                          keyword: 'trạm+xăng',
                          latitude: userLocation!.latitude,
                          longitude: userLocation!.longitude,
                          context: context);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30.0),
                    alignment: Alignment.center,
                    child: CustomTextButton(
                      hasBorder: false,
                      backgroundColor: CustomColors.kLightGray,
                      foregroundColor: CustomColors.kDarkGray,
                      text: CustomStrings.kBtnExit.tr,
                      onPressedFunc: () {
                        Get.back();
                      },
                      elevation: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
