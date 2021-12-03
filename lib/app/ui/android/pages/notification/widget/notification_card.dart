import 'package:bikes_user/app/controllers/notification_controller.dart';
import 'package:bikes_user/app/data/models/notification.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    var f = new DateFormat('dd/MM/yyyy');
    return GestureDetector(
      onTap: () => _readNoti(),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${notification.title}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp),
                          overflow: TextOverflow.fade),
                      Text('${notification.content}',
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('${f.format(notification.createdDate!)}',
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: !notification.isRead! ? CustomColors.kLightBlue : Colors.white,
          border: Border(
            bottom: BorderSide(width: 2.0, color: CustomColors.kLightGray),
          ),
        ),
      ),
    );
  }
}
