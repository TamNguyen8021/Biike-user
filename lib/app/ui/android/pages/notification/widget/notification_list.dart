import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/models/notification.dart';
import 'package:bikes_user/app/ui/android/pages/notification/widget/notificaiton_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NotificationList extends StatelessWidget {
  final Map listNotification;

  const NotificationList({Key? key, required this.listNotification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return listNotification.length == 0 ?
    Text(CustomErrorsString.kNoNotification.tr)
    : ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        reverse: true,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listNotification.length,
        itemBuilder: (BuildContext context, int i) {
          final key = listNotification.keys.elementAt(i);
          final noti = listNotification[key];

          return Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: NotificationCard(
                  hashKey: key, notification: BiikeNoti.fromJson(noti)));
        });
  }
}
