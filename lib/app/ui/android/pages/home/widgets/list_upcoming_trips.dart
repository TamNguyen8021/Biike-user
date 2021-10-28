import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A list of upcoming trips
class ListUpcomingTrips extends StatelessWidget {
  final List<dynamic> listUpcomingTrips;
  final double itemPadding;
  final bool hasSearchTrips;

  const ListUpcomingTrips({
    Key? key,
    required this.listUpcomingTrips,
    required this.itemPadding,
    required this.hasSearchTrips,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listUpcomingTrips.isEmpty && hasSearchTrips) {
      return Text(
        CustomStrings.kNoUpcomingTrips.tr,
      );
    }
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listUpcomingTrips.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: itemPadding),
            child: UpcomingTripCard(
                tripId: listUpcomingTrips.elementAt(index).tripId,
                userId: listUpcomingTrips.elementAt(index).userId,
                avatarUrl: listUpcomingTrips.elementAt(index).avatarUrl,
                name: listUpcomingTrips.elementAt(index).name,
                phoneNo: listUpcomingTrips.elementAt(index).phoneNo,
                bookTime: listUpcomingTrips.elementAt(index).bookTime,
                departureStation:
                    listUpcomingTrips.elementAt(index).departureStation,
                destinationStation:
                    listUpcomingTrips.elementAt(index).destinationStation),
          );
        });
  }
}
