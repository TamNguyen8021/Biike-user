import 'package:bikes_user/widgets/cards/history_trip_card.dart';
import 'package:flutter/material.dart';

/// A list of history trips
class ListHistoryTrips extends StatelessWidget {
  final List listHistoryTrips;
  final double itemPadding;

  const ListHistoryTrips(
      {Key? key, required this.listHistoryTrips, required this.itemPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: ScrollController(),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listHistoryTrips.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: EdgeInsets.only(bottom: itemPadding),
            child: HistoryTripCard(
                avatarUrl: 'assets/images/test_avatar.jpg',
                name: 'Thảo Vân',
                time: '11:35',
                date: '15 Th 1',
                status: 'Thành công',
                sourceStation: 'Chung cư SKY9',
                destinationStation: 'Đại học FPT TP.HCM'),
          );
        });
  }
}
