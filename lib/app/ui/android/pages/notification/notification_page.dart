import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/notification_controller.dart';
import 'package:bikes_user/app/ui/android/pages/notification/widget/notification_list.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  final _notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return OnBackPressed(
      perform: () => Get.back(),
      child: Scaffold(
        appBar: CustomAppBar(
          isVisible: true,
          hasShape: true,
          hasLeading: true,
          onPressedFunc: () => Get.back(),
          appBar: AppBar(),
          title: Text(CustomStrings.kNotification.tr),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    // height: MediaQuery.of(context).size.height - 230,
                    child: NotificationList(
                        notiList: List.generate(20, (index) => index)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
