import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/cards/upcoming_trip_card.dart';
import 'package:flutter/material.dart';

/// A list of upcoming trips
class ListUpcomingTrips extends StatelessWidget {
  final List listUpcomingTrips;
  final double itemPadding;
  final bool isTodayFirstActivity;

  const ListUpcomingTrips(
      {Key? key,
      required this.listUpcomingTrips,
      required this.itemPadding,
      required this.isTodayFirstActivity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listUpcomingTrips.length,
        itemBuilder: (BuildContext context, int i) {
          Color backgroundColor = CustomColors.kLightGray;
          Color foregroundColor = CustomColors.kDarkGray;
          Color iconColor = CustomColors.kBlue;
          if (i == 0 && isTodayFirstActivity) {
            backgroundColor = CustomColors.kBlue;
            foregroundColor = Colors.white;
            iconColor = Colors.white;
          }
          return Padding(
            padding: EdgeInsets.only(bottom: itemPadding),
            child: UpcomingTripCard(
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
