import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/notification_controller.dart';
import 'package:bikes_user/app/ui/android/pages/notification/widget/notificaiton_card.dart';
import 'package:bikes_user/app/ui/android/pages/notification/widget/notification_list.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
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
        body: FutureBuilder(
          future: _notificationController.getNoti(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container();
            } else if (snapshot.connectionState == ConnectionState.done) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: ElevatedButton(
                        //     onPressed: () =>
                        //           // Get.toNamed(CommonRoutes.FEEDBACK, arguments: 37),
                        //         _notificationController.sendNoti(),
                        //     child: Text(
                        //       'Send noti',
                        //       style: TextStyle(color: CustomColors.kDarkGray),
                        //     ),
                        //     style: ButtonStyle(
                        //         backgroundColor:
                        //             MaterialStateProperty.all<Color>(
                        //                 CustomColors.kLightGray),
                        //         elevation:
                        //             MaterialStateProperty.all<double>(0.0)),
                        //   ),
                        // ),
                        Container(
                          // height: MediaQuery.of(context).size.height - 230,
                          child: Obx(() => NotificationList(
                              listNotification:
                                  // ignore: invalid_use_of_protected_member
                                  _notificationController.listNoti.value)),
                        ),
                      ],
                    ),
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
