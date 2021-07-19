import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/cards/upcoming_trip_card.dart';
import 'package:flutter/material.dart';

/// The state of the [_ListUpcomingTripsState] widget
class ListUpcomingTrips extends StatefulWidget {
  final List listUpcomingTrips;
  final double itemPadding;
  final bool isTodayActivity;

  const ListUpcomingTrips(
      {Key? key,
      required this.listUpcomingTrips,
      required this.itemPadding,
      required this.isTodayActivity})
      : super(key: key);

  @override
  _ListUpcomingTripsState createState() => _ListUpcomingTripsState();
}

/// A list of upcoming trips
class _ListUpcomingTripsState extends State<ListUpcomingTrips> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: widget.listUpcomingTrips.length,
        itemBuilder: (BuildContext context, int i) {
          Color backgroundColor = CustomColors.kLightGray;
          Color foregroundColor = CustomColors.kDarkGray;
          Color iconColor = CustomColors.kBlue;
          if (i == 0 && widget.isTodayActivity) {
            backgroundColor = CustomColors.kBlue;
            foregroundColor = Colors.white;
            iconColor = Colors.white;
          }
          return Padding(
            padding: EdgeInsets.only(bottom: widget.itemPadding),
            child: UpcomingTripCard(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                iconColor: iconColor,
                avatarUrl: 'assets/images/test_avatar.jpg',
                name: 'Thảo Vân',
                time: '11:35',
                date: CustomStrings.kToday,
                sourceStation: 'Chung cư SKY9',
                destinationStation: 'Đại học FPT TP.HCM'),
          );
        });
  }
}
