import 'package:bikes_user/app/controllers/notification_controller.dart';
import 'package:bikes_user/app/data/models/notification.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final _notificationController = Get.find<NotificationController>();

  final hashKey;
  final BiikeNoti notification;

  NotificationCard(
      {Key? key, required this.hashKey, required this.notification})
      : super(key: key);

  _readNoti() async {
    await _notificationController.updateNoti(
        hashKey: hashKey, isRead: notification.isRead);

    Get.toNamed(CommonRoutes.NOTIFICATION_DETAIL, arguments: notification);
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return GestureDetector(
      onTap: () => _readNoti(),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text('${notification.title}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.fade),
                  ),
                  Text('${notification.content}',
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${dateFormat.format(notification.createdDate!)}',
                      style: Theme.of(context).textTheme.bodyText1),
                  if (notification.isRead!) ...[
                    Text(''),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.only(right: 22.0),
                      child: Icon(Icons.circle),
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
