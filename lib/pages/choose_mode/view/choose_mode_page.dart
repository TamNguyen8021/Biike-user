import 'package:bikes_user/main.dart';
import 'package:bikes_user/pages/choose_mode/controller/choose_mode_controller.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:bikes_user/widgets/buttons/next_page_button.dart';
import 'package:bikes_user/widgets/buttons/previous_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// '004.4_choose_mode' screen
class ChooseModePage extends StatelessWidget {
  const ChooseModePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chooseModeController = Get.find<ChooseModeController>();

    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/line-map.png"),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      CustomColors.kLightGray.withOpacity(0.5),
                      BlendMode.dstIn))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, bottom: 20.0),
                  child: Text(
                    CustomStrings.kChooseMode,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.white),
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(
                            color: chooseModeController
                                .driverBackgroundColor.value,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 20.0, 10.0, 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      CustomStrings.kDriverRole,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            color: chooseModeController
                                                .driverTitleAndIconColor.value,
                                          ),
                                    ),
                                    Text(
                                      CustomStrings.kDriverDescription,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: chooseModeController
                                                .driverTextColor.value,
                                          ),
                                      overflow: TextOverflow.clip,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: SvgPicture.asset(
                                'assets/images/scooter-front-view.svg',
                                color: chooseModeController
                                    .driverTitleAndIconColor.value,
                              ),
                            ),
                          ],
                        )),
                    onTap: () {
                      chooseModeController.selectDriverMode();
                    },
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 30.0),
                      decoration: BoxDecoration(
                          color: chooseModeController
                              .customerBackgroundColor.value,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 20.0, 10.0, 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    CustomStrings.kCustomerRole,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                          color: chooseModeController
                                              .customerTitleAndIconColor.value,
                                        ),
                                  ),
                                  Text(
                                    CustomStrings.kCustomerDescription,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: chooseModeController
                                              .customerTextColor.value,
                                        ),
                                    overflow: TextOverflow.clip,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: SvgPicture.asset(
                              'assets/images/helmet.svg',
                              color: chooseModeController
                                  .customerTitleAndIconColor.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      chooseModeController.selectCustomerMode();
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(CustomStrings.kRemindWords,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white)),
                )
              ],
            ),
          )),
      floatingActionButton: Container(
        width: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            PreviousPageButton(
              onPressedFunc: () => Get.back(),
              backgroundColor: Colors.white,
              foregroundColor: CustomColors.kBlue,
              hoverColor: CustomColors.kLightGray,
            ),
            NextPageButton(
              onPressedFunc: () {
                if (Biike.role.value == Role.Customer) {
                  Get.offAllNamed('/customerHome');
                } else if (Biike.role.value == Role.Driver) {
                  Get.offAllNamed('/driverHome');
                } else {
                  Get.defaultDialog(
                      title: 'Nhắc nhở',
                      middleText:
                          'Bạn hãy chọn làm người đi ké hoặc người chở để tiếp tục sử dụng ứng dụng',
                      middleTextStyle:
                          TextStyle(color: CustomColors.kDarkGray));
                }
              },
              backgroundColor: Colors.white,
              foregroundColor: CustomColors.kBlue,
              hoverColor: CustomColors.kLightGray,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
