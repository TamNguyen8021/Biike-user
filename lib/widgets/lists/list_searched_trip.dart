import 'dart:math';

import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/cards/searched_trips_card.dart';
import 'package:bikes_user/widgets/cards/upcoming_trip_card.dart';
import 'package:flutter/material.dart';

/// A list of searched trips
class ListSearchedTrips extends StatelessWidget {
  final List listSearchedTrips;
  final double itemPadding;

  const ListSearchedTrips(
      {Key? key,
        required this.listSearchedTrips,
        required this.itemPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listSearchedTrips.length,
        itemBuilder: (BuildContext context, int i) {
          Color backgroundColor = CustomColors.kLightGray;
          Color foregroundColor = CustomColors.kDarkGray;
          Color iconColor = CustomColors.kBlue;

          return Padding(
            padding: EdgeInsets.only(bottom: itemPadding),
            child: SearchedTripCard(
                tripId: 1, //listSearchedTrips[i].getTripId(),
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                iconColor: iconColor,
                avatarUrl: 'assets/images/profile-4.jpg',
                name: 'Thảo Vân',
                time: '11:35',
                date: CustomStrings.kToday,
                sourceStation: 'Chung cư SKY9',
                destinationStation: 'Đại học FPT TP.HCM'),
          );
        });
  }
}
