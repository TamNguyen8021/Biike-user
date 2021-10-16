import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/trip_status_enum.dart';
import 'package:bikes_user/app/data/models/destination_station.dart';
import 'package:bikes_user/app/data/models/departure_station.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/trip_history_provider.dart';
import 'package:bikes_user/app/ui/android/pages/trip_history/trip_history_page.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/history_trip_card.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// Manage states of [TripHistoryPage]
class TripHistoryController extends GetxController {
  final TripHistoryProvider _tripHistoryProvider =
      Get.put(TripHistoryProvider());
  final PagingController<int, HistoryTripCard> pagingController =
      PagingController(firstPageKey: 0);

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

  /// Lazy loading when view history trips.
  ///
  /// Author: TamNTT
  Future<void> _fetchPage(int pageKey) async {
    try {
      await getHistoryTrips();
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
        final int nextPageKey = pageKey + historyTrips.length;
        pagingController.appendPage(historyTrips.cast(), nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  /// Load history trips from API.
  ///
  /// Author: TamNTT
  Future<List<HistoryTripCard>> getHistoryTrips() async {
    historyTrips.clear();
    Map<String, dynamic> response = await _tripHistoryProvider.getHistoryTrips(
        userId: Biike.userId, page: _currentPage, limit: _limit);
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
        dateTime: DateTime.parse(trip.bookTime),
        status: tripStatus,
        sourceStation: startingStation.departureName,
        destinationStation: destinationStation.destinationName,
        isOnViewUserPage: false,
      );

      historyTrips.add(historyTripCard);
    }
    return historyTrips.cast();
  }
}
