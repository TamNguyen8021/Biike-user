import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

/// The state of the [_HistoryTripCardState] widget
class HistoryTripCard extends StatefulWidget {
  final String avatarUrl;
  final String name;
  final String time;
  final String date;
  final String status;
  final String sourceStation;
  final String destinationStation;

  HistoryTripCard(
      {required this.avatarUrl,
      required this.name,
      required this.time,
      required this.date,
      required this.status,
      required this.sourceStation,
      required this.destinationStation,
      Key? key})
      : super(key: key);

  @override
  _HistoryTripCardState createState() => _HistoryTripCardState();
}

/// This widget contains a history trip's details
class _HistoryTripCardState extends State<HistoryTripCard> {
  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (widget.status == 'Thành công') {
      statusColor = CustomColors.kBlue;
    } else {
      statusColor = CustomColors.kRed;
    }

    return Container(
      height: 82,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(widget.avatarUrl),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.name,
                          style: TextStyle(
                              color: CustomColors.kDarkGray,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                widget.time,
                                style: TextStyle(
                                    color: CustomColors.kDarkGray,
                                    fontSize: 12),
                              ),
                            ),
                            Text(
                              widget.date,
                              style: TextStyle(
                                  color: CustomColors.kDarkGray, fontSize: 12),
                            ),
                          ],
                        ),
                        Text(
                          widget.status,
                          style: TextStyle(color: statusColor, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(
                        Icons.radio_button_on_outlined,
                        color: CustomColors.kBlue,
                        size: 15,
                      ),
                    ),
                    Text(
                      widget.sourceStation,
                      style: TextStyle(
                          color: CustomColors.kDarkGray, fontSize: 12),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Icon(
                    Icons.more_vert_outlined,
                    color: CustomColors.kBlue,
                    size: 15,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(
                        Icons.location_on,
                        color: CustomColors.kBlue,
                        size: 15,
                      ),
                    ),
                    Text(
                      widget.destinationStation,
                      style: TextStyle(
                          color: CustomColors.kDarkGray, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: CustomColors.kLightGray,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CustomColors.kDarkGray.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 0.5,
              // changes position of shadow
              offset: Offset(0, 0.5),
            )
          ]),
    );
  }
}
