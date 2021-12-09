import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

//ignore:must_be_immutable
class PickUpStationCard extends StatelessWidget {
  final int id;
  final int stationId;
  final String stationName;
  final String timeRange;

  const PickUpStationCard(
      {Key? key,
      required this.id,
      required this.stationId,
      required this.stationName,
      required this.timeRange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 25.0, bottom: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: CustomColors.kLightGray,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CustomColors.kDarkGray.withOpacity(0.3),
              // changes position of shadow
              offset: Offset(0, 1.25),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              stationName,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            timeRange,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
