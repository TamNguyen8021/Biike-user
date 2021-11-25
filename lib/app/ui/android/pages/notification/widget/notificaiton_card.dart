import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String content;
  final DateTime date;

  NotificationCard(
      {Key? key,
      required this.title,
      required this.content,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = new DateFormat('dd/MM/yyyy');
    var dateString = f.format(date);

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
                  Text(title,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp),
                      overflow: TextOverflow.ellipsis
                  ),
                  Text(content,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(dateString, style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2.0, color: CustomColors.kLightGray),
        ),
      ),
    );
  }
}
