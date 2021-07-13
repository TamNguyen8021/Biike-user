import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/trip_card.dart';
import 'package:flutter/material.dart';

class ListTrips extends StatefulWidget {
  final List list;

  const ListTrips({Key? key, required this.list}) : super(key: key);

  @override
  _ListTripsState createState() => _ListTripsState();
}

class _ListTripsState extends State<ListTrips> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TripCard(
                backgroundColor: CustomColors.lightGray,
                foregroundColor: CustomColors.darkGray,
                iconColor: CustomColors.blue,
                avatarUrl: 'assets/images/test_avatar.jpg',
                name: CustomStrings.findingDriver,
                time: '11:35',
                date: CustomStrings.today,
                sourceStation: 'Chung cư SKY9',
                destinationStation: 'Đại học FPT TP.HCM'),
          );
        });
  }
}
