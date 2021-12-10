import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/sos_number_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_sos_number.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/android/widgets/others/sos_number_description.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The sos number screen
class SOSNumberPage extends StatelessWidget {
  const SOSNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sosNumberController = Get.find<SOSNumberController>();

    return FutureBuilder(
        future: sosNumberController.getSOSNumbers(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            sosNumberController.userPhoneNo = Get.arguments['userPhoneNo'];
            return Obx(() => Scaffold(
                  appBar: CustomAppBar(
                    hasShape: true,
                    appBar: AppBar(),
                    hasLeading: true,
                    onPressedFunc: () {
                      Get.back();
                    },
                    title: Text(
                      CustomStrings.kSOSNumber.tr,
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Container(
                          padding: const EdgeInsets.all(22.0),
                          child: ListSOSNumbers(
                            listSOSNumbers:
                                sosNumberController.sosNumbers.toList(),
                            itemPadding: 10.0,
                          )),
                      SOSNumberDescription(),
                      // Padding(
                      //       padding: const EdgeInsets.only(top: 22.0),
                      //       child: Text(
                      //           CustomStrings.kSOSReachLimit.tr,
                      //           style: TextStyle(
                      //               fontSize: 10.0,
                      //               color: CustomColors.kDarkGray
                      //           )
                      //     ),
                      // ),
                    ]),
                  ),
                  floatingActionButton: FloatingActionButton(
                    elevation: 1.0,
                    onPressed: sosNumberController.isMaximun.value
                        ? () {}
                        : () => Get.toNamed(CommonRoutes.ADD_SOS_NUMBER,
                                arguments: {
                                  'userPhoneNo': sosNumberController.userPhoneNo
                                }),
                    backgroundColor: sosNumberController.isMaximun.value
                        ? CustomColors.kDarkGray
                        : CustomColors.kDarkBlue,
                    child: Icon(
                      Icons.add,
                      size: 50,
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                ));
          } else {
            return Loading();
          }
        });
  }
}
