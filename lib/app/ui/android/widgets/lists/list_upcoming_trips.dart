import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
import 'package:flutter/material.dart';

/// A list of upcoming trips
class ListUpcomingTrips extends StatelessWidget {
  final List<dynamic> listUpcomingTrips;
  final double itemPadding;

  const ListUpcomingTrips({
    Key? key,
    required this.listUpcomingTrips,
    required this.itemPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listUpcomingTrips.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: itemPadding),
            child: UpcomingTripCard(
                avatarUrl: listUpcomingTrips.elementAt(index).avatarUrl,
                name: listUpcomingTrips.elementAt(index).name,
                phoneNo: listUpcomingTrips.elementAt(index).phoneNo,
                time: listUpcomingTrips.elementAt(index).time,
                date: listUpcomingTrips.elementAt(index).date,
                year: listUpcomingTrips.elementAt(index).year,
                sourceStation: listUpcomingTrips.elementAt(index).sourceStation,
                destinationStation:
                    listUpcomingTrips.elementAt(index).destinationStation),
          );
        });
  }
}
