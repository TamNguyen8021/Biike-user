import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

/// The state of the [_UpcomingTripCardState] widget
class UpcomingTripCard extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color iconColor;
  final String avatarUrl;
  final String name;
  final String time;
  final String date;
  final String sourceStation;
  final String destinationStation;

  const UpcomingTripCard(
      {Key? key,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.iconColor,
      required this.avatarUrl,
      required this.name,
      required this.time,
      required this.date,
      required this.sourceStation,
      required this.destinationStation})
      : super(key: key);

  @override
  _UpcomingTripCardState createState() => _UpcomingTripCardState();
}

/// This widget contains a upcoming trip's details
class _UpcomingTripCardState extends State<UpcomingTripCard> {
  @override
  Widget build(BuildContext context) {
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
                              color: widget.foregroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            widget.time,
                            style: TextStyle(
                                color: widget.foregroundColor, fontSize: 12),
                          ),
                        ),
                        Text(
                          widget.date,
                          style: TextStyle(
                              color: widget.foregroundColor, fontSize: 12),
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
                        color: widget.iconColor,
                        size: 15,
                      ),
                    ),
                    Text(
                      widget.sourceStation,
                      style: TextStyle(
                          color: widget.foregroundColor, fontSize: 12),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Icon(
                    Icons.more_vert_outlined,
                    color: widget.iconColor,
                    size: 15,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(
                        Icons.location_on,
                        color: widget.iconColor,
                        size: 15,
                      ),
                    ),
                    Text(
                      widget.destinationStation,
                      style: TextStyle(
                          color: widget.foregroundColor, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: widget.backgroundColor,
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
