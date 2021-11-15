import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/trip_status_enum.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/data/models/area.dart';
import 'package:bikes_user/app/data/models/destination_station.dart';
import 'package:bikes_user/app/data/models/departure_station.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/history_trip_card.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ViewUserController extends GetxController {
  final _userProvider = Get.find<UserProvider>();
  final _tripProvider = Get.find<TripProvider>();
  final PagingController<int, HistoryTripCard> pagingController =
      PagingController(firstPageKey: 0);

  User user = User.empty();
  Area area = Area.empty();
  RxList historyTrips = [].obs;
  Map<String, dynamic> historyTripsPagination = {};
  int _currentPage = 1;
  int _limit = 10;

  @override
  onInit() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, partnerId: Get.arguments['partnerId']);
    });
    super.onInit();
  }

  @override
  dispose() {
    pagingController.dispose();
    super.dispose();
  }

  /// Lazy loading when view upcoming trips or load stations.
  ///
  /// Author: TamNTT
  Future<void> _fetchPage(int pageKey, {required int partnerId}) async {
    try {
      await getHistoryTripsWithPartner(partnerId: partnerId);
      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;
      final bool isLastPage =
          historyTripsPagination['totalRecord'] - previouslyFetchedItemsCount <=
              _limit;
      if (isLastPage) {
        pagingController.appendLastPage(historyTrips.cast());
        _currentPage = 1;
      } else {
        _currentPage += 1;
        int nextPageKey = pageKey + historyTrips.length;
        pagingController.appendPage(historyTrips.cast(), nextPageKey);
      }
    } catch (error) {
      Biike.logger.e('ViewUserController - _fetchPage()', error);
      pagingController.error = error;
      FlutterLogs.logErrorTrace('Biike', 'ViewUserController - _fetchPage()',
          error.toString(), Error());
    }
  }

  /// Gets partner's profile and shows it on [context] .
  ///
  /// Author: TamNTT
  Future<void> getPartnerProfile({required int partnerId}) async {
    var partnerProfile =
        await _userProvider.getPartnerProfile(partnerId: partnerId);
    user = User.fromJson(partnerProfile);
    area = Area.fromJson(partnerProfile);
  }

  /// Gets history trips with partner and shows it on [context].
  ///
  /// Author: TamNTT
  Future<List<HistoryTripCard>> getHistoryTripsWithPartner(
      {required int partnerId}) async {
    historyTrips.clear();
    Map<String, dynamic> response = await _tripProvider.getHistoryPairTrips(
        userId: Biike.userId.value,
        partnerId: partnerId,
        page: _currentPage,
        limit: _limit);
    historyTripsPagination = response['_meta'];

    for (var historyTrip in response['data']) {
      User user = User.fromJson(historyTrip);
      Trip trip = Trip.fromJson(historyTrip);
      DepartureStation startingStation = DepartureStation.fromJson(historyTrip);
      DestinationStation destinationStation =
          DestinationStation.fromJson(historyTrip);
      TripStatus tripStatus;

      switch (trip.tripStatus) {
        case 1:
          tripStatus = TripStatus.finding;
          break;
        case 2:
          tripStatus = TripStatus.waiting;
          break;
        case 3:
          tripStatus = TripStatus.started;
          break;
        case 4:
          tripStatus = TripStatus.finished;
          break;
        case 5:
          tripStatus = TripStatus.canceled;
          break;
        default:
          tripStatus = TripStatus.none;
          Get.defaultDialog(
              title: CustomErrorsString.kError.tr,
              middleText: CustomErrorsString.kErrorMessage.tr);
      }

      HistoryTripCard historyTripCard = HistoryTripCard(
        tripId: trip.tripId,
        userId: user.userId,
        dateTime: DateTime.tryParse(trip.bookTime)!,
        status: tripStatus,
        sourceStation: startingStation.departureName,
        destinationStation: destinationStation.destinationName,
        isOnViewUserPage: true,
      );

      historyTrips.add(historyTripCard);
    }
    return historyTrips.cast();
  }

  /// Display a dialog on [context] to report a user.
  ///
  /// Author: TamNTT
  void showReportDialog({required BuildContext context}) async {
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
                    CustomStrings.kReport.tr,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextFormField(
                      maxLines: 10,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        hintText: CustomStrings.kEnterYourReport.tr,
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
                              backgroundColor: CustomColors.kBlue,
                              foregroundColor: Colors.white,
                              text: CustomStrings.kReport.tr,
                              onPressedFunc: () {
                                Get.back();
                                _showThankYouForReportDialog(context: context);
                              }),
                          CustomTextButton(
                              hasBorder: false,
                              backgroundColor: CustomColors.kRed,
                              foregroundColor: Colors.white,
                              text: CustomStrings.kReportAndBlock.tr,
                              onPressedFunc: () {
                                Get.back();
                                _showConfirmBlockDialog(context: context);
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

  /// Display a dialog on [context] to confirm if user wants to block another user.
  ///
  /// Author: TamNTT
  void _showConfirmBlockDialog({required BuildContext context}) async {
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
                  Text(
                    CustomStrings.kConfirmBlock.tr,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 30.0),
                    child: Text(
                      CustomStrings.kSeeBlacklist.tr,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          CustomTextButton(
                              hasBorder: false,
                              backgroundColor: CustomColors.kBlue,
                              foregroundColor: Colors.white,
                              text: CustomStrings.kYes.tr,
                              onPressedFunc: () {
                                Get.back();
                                _showThankYouForReportDialog(context: context);
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

  /// Display a dialog on [context] to thank you user for their report.
  ///
  /// Author: TamNTT
  void _showThankYouForReportDialog({required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    CustomStrings.kThankYouForReport.tr,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      CustomStrings.kSorryMessage.tr,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Center(
                    child: CustomTextButton(
                        hasBorder: false,
                        width: 100,
                        backgroundColor: CustomColors.kLightGray,
                        foregroundColor: CustomColors.kDarkGray,
                        text: CustomStrings.kBtnExit.tr,
                        onPressedFunc: () {
                          Get.back();
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
