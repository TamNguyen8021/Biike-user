import 'package:flutter/material.dart';

/// The state of the TripCard widget
class TripCard extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color iconColor;
  final String avatarUrl;
  final String name;
  final String time;
  final String date;
  final String sourceStation;
  final String destinationStation;

  const TripCard(
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
  _TripCardState createState() => _TripCardState();
}

/// This widget contains a trip's details
class _TripCardState extends State<TripCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2.0,
        color: widget.backgroundColor,
        child: Row(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Column(children: <Widget>[
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(widget.avatarUrl),
                ),
              ]),
            ),
            Expanded(
              child: Column(
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
                    style:
                        TextStyle(color: widget.foregroundColor, fontSize: 12),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            // Column(
            //   children: <Widget>[
            //     VerticalDivider(
            //       color: CustomColors.lightGray,
            //     ),
            //   ],
            //   crossAxisAlignment: CrossAxisAlignment.center,
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
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
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.more_vert_outlined,
                          color: widget.iconColor,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
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
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            )
          ],
        ),
      ),
    );
  }
}
