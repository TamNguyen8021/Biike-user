import 'package:bikes_user/app/controllers/feedback_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/send_feedback_button.dart';
import 'package:bikes_user/app/ui/android/widgets/painters/half_oval_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// The 'feedback' screen
class FeedbackPage extends StatelessWidget {
  final feedbackController = Get.find<FeedbackController>();

  FeedbackPage({Key? key}) : super(key: key);

  Future<bool> _onBackPressed() {
    Get.snackbar('Error', CustomErrorsString.kNotRated.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
    return Future.value(false);
  }

  Widget _image(String asset) {
    return SvgPicture.asset(
      asset,
      height: 30.0,
      width: 30.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Container(
          // alignment: Alignment.center,
          child: SafeArea(
            child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                Container(
                  height: 180,
                  child: Stack(
                    // alignment: Alignment.center,
                    children: <Widget>[
                      CustomPaint(
                        painter: HalfOvalPainter(),
                        child: Container(height: 150),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SvgPicture.asset(
                          'assets/images/happy-face.svg',
                          height: 120,
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    Biike.role.value == Role.biker
                                        ? CustomStrings.kTripSuccessBiker.tr
                                        : CustomStrings.kTripSuccessKeer.tr,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: CustomColors.kBlue,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]),
                        ),
                        Biike.role.value == Role.biker
                            ? Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      "EXP",
                                      style: new TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 2.0)),
                                    Icon(Icons.star,
                                        size: 20, color: Colors.white),
                                  ],
                                ),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(20.0)),
                                  color: CustomColors.kOrange,
                                ),
                                padding: new EdgeInsets.fromLTRB(
                                    15.0, 5.0, 15.0, 5.0),
                              )
                            : Padding(padding: const EdgeInsets.only(top: 2.0)),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    CustomStrings.kRateReminder.tr,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: CustomColors.kDarkGray),
                                  ),
                                ),
                              ]),
                        ),
                        Form(
                            child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15.0, top: 10.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RatingBar(
                                      //initialRating: 3,
                                      minRating: 1,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      ratingWidget: RatingWidget(
                                        full: _image(
                                            'assets/images/full_star.svg'),
                                        half: _image(''),
                                        empty: _image(
                                            'assets/images/empty_star.svg'),
                                      ),
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      onRatingUpdate: (star) {
                                        feedbackController
                                            .updateStarRating(star);
                                      },
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 10.0),
                              child: Card(
                                color: CustomColors.kLightGray,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    maxLines: 3,
                                    maxLength: 250,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(250)
                                    ],
                                    style: TextStyle(
                                        color: CustomColors.kDarkGray),
                                    decoration: InputDecoration(
                                      counter: Offstage(),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 15.0),
                                    ),
                                    onChanged: (feedback) {
                                      feedbackController
                                          .updateFeedback(feedback);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[SendFeedbackButton()]),
                            ),
                          ],
                        )),
                        Biike.role.value == Role.keer
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: SvgPicture.asset(
                                        'assets/images/coffee-cup.svg',
                                        height: 90,
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        CustomStrings.kBuyReminder.tr,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: CustomColors.kDarkGray,
                                            fontSize: 12.0),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(padding: const EdgeInsets.only(top: 2.0)),
                      ]),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
