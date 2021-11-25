import 'package:bikes_user/app/data/models/point_history.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PointCard extends StatelessWidget {
  final PointHistory pointHistory;

  PointCard({Key? key, required this.pointHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = new DateFormat('hh:mm dd/MM/yyyy');
    var dateString = f.format(pointHistory.timeStamp!);

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    dateString,
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(pointHistory.description.toString(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp)),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  (pointHistory.point! > 0)
                      ? '+${pointHistory.point}'
                      : '${pointHistory.point}',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: CustomColors.kOrange),
                ),
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: CustomColors.kLightGray,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CustomColors.kDarkGray.withOpacity(0.5),
              // changes position of shadow
              offset: Offset(0, 1),
            )
          ]),
    );
  }
}
