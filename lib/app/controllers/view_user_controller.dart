import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/trip_status_enum.dart';
import 'package:bikes_user/app/data/providers/view_user_provider.dart';
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
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ViewUserController extends GetxController {
  final int userId;

  ViewUserController({required this.userId});

  final _viewUserProvider = Get.put(ViewUserProvider());
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
      _fetchPage(pageKey);
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
  Future<void> _fetchPage(int pageKey) async {
    try {
      await getHistoryTripsWithPartner();
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
      pagingController.error = error;
    }
  }

  /// Gets partner's profile and shows it on [context] .
  ///
  /// Author: TamNTT
  Future<void> getPartnerProfile() async {
    var partnerProfile =
        await _viewUserProvider.getPartnerProfile(partnerId: userId);
    user = User.fromJson(partnerProfile);
    area = Area.fromJson(partnerProfile);
  }

  /// Gets history trips with partner and shows it on [context].
  ///
  /// Author: TamNTT
  Future<List<HistoryTripCard>> getHistoryTripsWithPartner() async {
    historyTrips.clear();
    Map<String, dynamic> response = await _viewUserProvider.getHistoryPairTrips(
        userId: Biike.userId.value,
        partnerId: userId,
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
  dynamic showReportDialog({required BuildContext context}) {
    showDialog(
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
                              backgroundColor: CustomColors.kBlue,
                              foregroundColor: Colors.white,
                              text: CustomStrings.kReport.tr,
                              onPressedFunc: () {
                                Get.back();
                                _showThankYouForReportDialog(context: context);
                              }),
                          CustomTextButton(
                              backgroundColor: CustomColors.kRed,
                              foregroundColor: Colors.white,
                              text: CustomStrings.kReportAndBlock.tr,
                              onPressedFunc: () {
                                Get.back();
                                _showConfirmBlockDialog(context: context);
                              }),
                          CustomTextButton(
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
  dynamic _showConfirmBlockDialog({required BuildContext context}) {
    showDialog(
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
                              backgroundColor: CustomColors.kBlue,
                              foregroundColor: Colors.white,
                              text: CustomStrings.kSure.tr,
                              onPressedFunc: () {
                                Get.back();
                                _showThankYouForReportDialog(context: context);
                              }),
                          CustomTextButton(
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
  dynamic _showThankYouForReportDialog({required BuildContext context}) {
    showDialog(
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
