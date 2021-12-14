import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/controllers/notification_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/notification/widget/notification_list.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  final _notificationController = Get.find<NotificationController>();
  final _homeController = Get.find<HomeController>();

  _onBackPressed() {
    _homeController.upcomingTrips.clear();
    _homeController.pagingController.itemList!.clear();
    _homeController.pagingController.notifyPageRequestListeners(0);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return OnBackPressed(
      perform: () => _onBackPressed(),
      child: Scaffold(
        appBar: CustomAppBar(
            hasShape: true,
            hasLeading: true,
            onPressedFunc: () => _onBackPressed(),
            appBar: AppBar(),
            title: Text(CustomStrings.kNotification.tr),
            actionWidgets: <Widget>[
              Obx(
                () => _notificationController.listNoti.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                            onPressed: () async {
                              await _notificationController.deleteNoti();
                              Get.offAllNamed(CommonRoutes.HOME);
                            },
                            icon: Icon(Icons.delete)),
                      )
                    : Container(),
              ),
            ]),
        body: FutureBuilder(
          future: _notificationController.getNoti(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
                    child: Obx(() => NotificationList(
                        listNotification:
                            // ignore: invalid_use_of_protected_member
                            _notificationController.listNoti.value)),
                  ),
                ),
              );
            } else {
              return Loading();
            }
          },
        ),
      ),
    );
  }
}
