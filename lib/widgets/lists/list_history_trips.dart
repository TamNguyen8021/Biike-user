import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:bikes_user/widgets/cards/history_trip_card.dart';
import 'package:flutter/material.dart';

/// A list of history trips
class ListHistoryTrips extends StatelessWidget {
  final Role role;
  final List<dynamic> listHistoryTrips;
  final double itemPadding;

  const ListHistoryTrips(
      {Key? key,
      required this.role,
      required this.listHistoryTrips,
      required this.itemPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _noHistoryMessage = '';

    switch (role) {
      case Role.keer:
        _noHistoryMessage = CustomStrings.kNoKeerHistoryTrips;
        break;
      case Role.biker:
        _noHistoryMessage = CustomStrings.kNoBikerHistoryTrips;
        break;
      default:
        _noHistoryMessage = CustomStrings.kNoHistoryTrip;
        break;
    }

    if (listHistoryTrips.isEmpty) {
      return Text(_noHistoryMessage);
    } else {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: listHistoryTrips.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(bottom: itemPadding),
              child: HistoryTripCard(
                  avatarUrl: listHistoryTrips.elementAt(index).avatarUrl,
                  name: listHistoryTrips.elementAt(index).name,
                  time: listHistoryTrips.elementAt(index).time,
                  date: listHistoryTrips.elementAt(index).date,
                  status: listHistoryTrips.elementAt(index).status,
                  sourceStation:
                      listHistoryTrips.elementAt(index).sourceStation,
                  destinationStation:
                      listHistoryTrips.elementAt(index).destinationStation),
            );
          });
    }
  }
}
