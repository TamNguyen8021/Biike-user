import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bikes_user/app/data/models/notification.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationDetailPage extends StatelessWidget {
  NotificationDetailPage({Key? key}) : super(key: key);

  _moveToRoute(String url) {
    var tripId = _getTripId(url);

    // move to corresponding page
    if (url.contains('details')) {
      Get.toNamed(CommonRoutes.TRIP_DETAILS, arguments: {
        'tripId': tripId,
        'userId': Biike.userId.value,
        'route': 'home'
      });
    } else if (url.contains('feedback')) {
      Get.toNamed(CommonRoutes.FEEDBACK, arguments: tripId);
    }
  }

  _getTripId(String url) {
    // get trip Id
    String remove = url.contains('details') ? 'details' : '';
    if (remove == '') remove = url.contains('feedback') ? 'feedback' : '';
    if (remove != '' && url.contains(remove)) {
      url = url.substring(0, url.length - remove.length - 1);
    }
    return CommonFunctions.getIdFromUrl(url: url);
  }

  @override
  Widget build(BuildContext context) {
    BiikeNoti notification = Get.arguments;
    var f = new DateFormat('dd/MM/yyyy hh:mm');

    return OnBackPressed(
        perform: () => Get.back(),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
              isVisible: true,
              hasShape: true,
              hasLeading: true,
              onPressedFunc: () {
                Get.back();
              },
              color: Colors.transparent,
              appBar: AppBar()),
          body: Container(
              child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                color: CustomColors.kBlue,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    'assets/images/biike-two-person.svg',
                    height: 250,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            '${notification.title}',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        Text('${f.format(notification.createdDate!)}',
                            style: Theme.of(context).textTheme.bodyText1),
                        Divider(),
                        Text(
                          '${notification.content}',
                          style: Theme.of(context).textTheme.bodyText2!,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              // Expanded(child: Container()),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      _moveToRoute(notification.url!),
                                  child: Text(
                                    'Show',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: CustomColors.kBlue,
                                      elevation: 0.0),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}
