import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/exit_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/view_trip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// The '016-cus-book-now-success' screen
class FindingBikerSuccessPage extends StatelessWidget {
  const FindingBikerSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: SvgPicture.asset(
                  'assets/images/biike-two-person.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 75.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  CustomStrings.kFoundBiker.tr,
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: CustomColors.kBlue,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IntrinsicWidth(
                          stepWidth: 200,
                          child: Column(
                            children: <Widget>[
                              ViewTripButton(),
                              Padding(padding: EdgeInsets.all(10.0)),
                              ExitButton(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
