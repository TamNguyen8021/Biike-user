import 'package:back_pressed/back_pressed.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_dialog.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/notification_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:bikes_user/app/data/models/notification.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationDetailPage extends StatelessWidget {
  final _notificationController = Get.find<NotificationController>();

  NotificationDetailPage({Key? key}) : super(key: key);

  _moveToRoute(context, String url) {
    // move to corresponding page
    if (url.contains('details')) {
      var tripId = _getTripId(url);

      Get.toNamed(CommonRoutes.TRIP_DETAILS,
          arguments: {'tripId': tripId, 'route': 'home'});
    } else if (url.contains('feedbacks')) {
      var tripId = _getTripId(url);

      _moveToFeedback(context, tripId);
    } else if (url.contains('bikes')) {
      Get.toNamed(CommonRoutes.MANAGE_BIKE);
    } else if (url.contains('now')) {
      int tripId = _getTripId(url);

      if (Biike.role.value == Role.biker) {
        Get.toNamed(CommonRoutes.CHO_NOW, arguments: {'tripId': tripId});
      } else {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                headerAnimationLoop: false,
                desc: CustomErrorsString.kChangeToBikerToSeeTripNow.tr)
            .show();
      }
    } else if (url.contains('point')) {
      Get.toNamed(CommonRoutes.POINT);
    }
  }

  _moveToFeedback(context, tripId) async {
    CustomDialog customDialog = CustomDialog(context: context);
    customDialog.loadingDialog.show();

    String isMoveToFeedBack =
        await _notificationController.isMoveToFeedBack(tripId);

    customDialog.loadingDialog.dismiss();

    if (isMoveToFeedBack == '') {
      Get.toNamed(CommonRoutes.FEEDBACK, arguments: {
        'tripId': tripId,
        'isKeer': _notificationController.isKeer
      });
    } else {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              headerAnimationLoop: false,
              desc: isMoveToFeedBack)
          .show();
    }
  }

  _getTripId(String url) {
    // get trip Id
    String remove = url.contains('details')
        ? 'details'
        : url.contains('feedbacks')
            ? 'feedbacks'
            : url.contains('now')
                ? 'now'
                : '';
    if (remove != '' && url.contains(remove)) {
      url = url.substring(0, url.length - remove.length - 1);
    }
    return CommonFunctions.getIdFromUrl(url: url);
  }

  @override
  Widget build(BuildContext context) {
    BiikeNoti notification = Get.arguments;
    DateFormat timeFormat = DateFormat('HH:mm');
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return OnBackPressed(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
              hasShape: false,
              hasLeading: true,
              onPressedFunc: () {
                Get.back();
              },
              color: CustomColors.kBlue,
              appBar: AppBar()),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  color: CustomColors.kBlue,
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/banner-thong-bao.jpg',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          '${notification.title}',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      Text('${timeFormat.format(notification.createdDate!)}',
                          style: Theme.of(context).textTheme.bodyText1),
                      Text('${dateFormat.format(notification.createdDate!)}',
                          style: Theme.of(context).textTheme.bodyText1),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Divider(
                            color: CustomColors.kDarkGray.withOpacity(0.5)),
                      ),
                      Text(
                        '${notification.content}',
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Divider(
                        color: CustomColors.kDarkGray.withOpacity(0.5),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 22.0, right: 22.0, bottom: 10.0),
                        child: CustomTextButton(
                            backgroundColor: CustomColors.kBlue,
                            foregroundColor: Colors.white,
                            text: CustomStrings.kView.tr,
                            onPressedFunc: () {
                              _moveToRoute(context, notification.url!);
                            },
                            hasBorder: false),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        perform: () => Get.back());
  }
}
