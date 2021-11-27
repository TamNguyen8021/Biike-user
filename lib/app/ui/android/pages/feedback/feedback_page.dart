import 'dart:math';

import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/feedbacks_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/ui/android/pages/feedback/widget/criteria_button.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/pages/feedback/widget/send_feedback_button.dart';
import 'package:bikes_user/app/ui/android/widgets/painters/half_oval_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// The 'feedback' screen
class FeedbackPage extends StatelessWidget {
  final feedbackController = Get.find<FeedbackController>();

  FeedbackPage({Key? key}) : super(key: key);

  Widget _image(String asset) {
    return SvgPicture.asset(
      asset,
      height: 30.0,
      width: 30.0,
    );
  }

  _randomCriteria(Random random, List listSeed) {
    int data = listSeed[random.nextInt(listSeed.length)];
    listSeed.remove(data);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    var tripId = Get.arguments;

    final random = new Random();
    // get 4 random element
    List listSeed = List.generate(CustomStrings.kCriteria.length, (_) => _);
    List listCriteria =
        new List.generate(4, (_) => _randomCriteria(random, listSeed));

    return WillPopScope(
      onWillPop: () => CommonFunctions().onBackPressed(
          context: context, errorMessage: CustomErrorsString.kNotRated),
      child: Scaffold(
        body: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                Container(
                  height: 180,
                  child: Stack(
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
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]),
                        ),
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
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: CriteriaButton(
                                              text: CustomStrings
                                                  .kCriteria[listCriteria[0]]
                                                  .tr)),
                                      Container(
                                        width: 5,
                                      ),
                                      Expanded(
                                          child: CriteriaButton(
                                              text: CustomStrings
                                                  .kCriteria[listCriteria[1]]
                                                  .tr)),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: CriteriaButton(
                                              text: CustomStrings
                                                  .kCriteria[listCriteria[2]]
                                                  .tr)),
                                      Container(
                                        width: 5,
                                      ),
                                      Expanded(
                                          child: CriteriaButton(
                                              text: CustomStrings
                                                  .kCriteria[listCriteria[3]]
                                                  .tr)),
                                    ],
                                  ),
                                  Card(
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
                                ],
                              ),
                            ),
                          ],
                        )),
                        Biike.role.value == Role.keer
                            ? Container(
                          child: Column(
                            children: <Widget>[
                              Divider(thickness: 2.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(right: 5.0),
                                      child: Text(
                                        CustomStrings.kTipForBiker.tr + ': ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                            color: CustomColors.kDarkGray,
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                    Expanded(
                                        child: TextField(
                                          maxLines: 1,
                                          maxLength: 250,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                              color: CustomColors.kDarkGray),
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                                color: CustomColors.kLightGray,
                                                fontSize: 12),
                                            hintText: 'Tips',
                                            enabledBorder: const OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: CustomColors.kDarkGray,
                                                  width: 1.0),
                                            ),
                                            counter: Offstage(),
                                            contentPadding: EdgeInsets.all(10),
                                          ),
                                          onChanged: (tip) {
                                            feedbackController
                                                .updateTip(tip);
                                          },
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SendFeedbackButton(tripId: tripId),
                              ]),
                        ),
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
