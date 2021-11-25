import 'package:bikes_user/app/data/models/notification.dart';
import 'package:bikes_user/app/ui/android/pages/notification/widget/notificaiton_card.dart';
import 'package:flutter/cupertino.dart';

class NotificationList extends StatelessWidget {
  final List<dynamic> listNotification;

  const NotificationList({Key? key, required this.listNotification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        reverse: true,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listNotification.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: NotificationCard(
                  notification:
                      BiikeNoti.fromJson(listNotification[i])));
        });
  }
}
