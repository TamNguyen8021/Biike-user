import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/sos_number_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/add_sos_number_button.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/sos_number_card.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_sos_number.dart';
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

    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        appBar: AppBar(),
        hasLeading: true,
        title: Text(
          CustomStrings.kSOSNumber.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(22.0),
                  child: ListSOSNumbers(
                    listSOSNumbers: [
                      SOSNumberCard(name: 'Nguyễn Đức Thành', number: '+84 37 947 6322'),
                      SOSNumberCard(name: 'Nguyễn Đức Thành', number: '+84 37 947 6322'),
                    ],
                    itemPadding: 10.0,
                  )
              ),
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
      floatingActionButton: AddSOSNumberButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
