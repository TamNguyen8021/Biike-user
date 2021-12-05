import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/notification_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:bikes_user/app/data/models/notification.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationDetailPage extends StatelessWidget {
  final _notificationController = Get.find<NotificationController>();

  NotificationDetailPage({Key? key}) : super(key: key);

  _moveToRoute(context, String url) {
    var tripId = _getTripId(url);

    // move to corresponding page
    if (url.contains('details')) {
      Get.toNamed(CommonRoutes.TRIP_DETAILS,
          arguments: {'tripId': tripId, 'route': 'home'});
    } else if (url.contains('feedbacks')) {
      _moveToFeedback(context, tripId);
    }
  }

  _moveToFeedback(context, tripId) async {
    String isMoveToFeedBack =
        await _notificationController.isMoveToFeedBack(tripId);
    if (isMoveToFeedBack == '') {
      Get.toNamed(CommonRoutes.FEEDBACK, arguments: {
        'tripId': tripId,
        'isKeer': _notificationController.isKeer
      });
    } else {
      CommonFunctions()
          .showErrorDialog(context: context, message: isMoveToFeedBack);
    }
  }

  _getTripId(String url) {
    // get trip Id
    String remove = url.contains('details')
        ? 'details'
        : url.contains('feedbacks')
            ? 'feedbacks'
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

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
          isVisible: true,
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
                    child:
                        Divider(color: CustomColors.kDarkGray.withOpacity(0.5)),
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
                        text: CustomStrings.kViewTrip.tr,
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
    );
  }
}
