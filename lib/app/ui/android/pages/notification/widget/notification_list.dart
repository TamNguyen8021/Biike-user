import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/models/notification.dart';
import 'package:bikes_user/app/ui/android/pages/notification/widget/notificaiton_card.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationList extends StatelessWidget {
  final Map listNotification;

  const NotificationList({Key? key, required this.listNotification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return listNotification.isEmpty
        ? Text(CustomErrorsString.kNoNotification.tr)
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: listNotification.length,
            itemBuilder: (BuildContext context, int index) {
              final key = listNotification.keys.elementAt(index);
              final noti = listNotification[key];

              return Column(
                children: <Widget>[
                  NotificationCard(
                      hashKey: key, notification: BiikeNoti.fromJson(noti)),
                  if (index < listNotification.length - 1) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(
                        color: CustomColors.kDarkGray.withOpacity(0.5),
                      ),
                    ),
                  ]
                ],
              );
            });
  }
}
