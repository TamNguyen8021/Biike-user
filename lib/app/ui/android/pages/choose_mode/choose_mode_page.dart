import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/next_page_button.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/controllers/choose_mode_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/previous_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// The '004.4_choose_mode' screen
class ChooseModePage extends StatelessWidget {
  final _userProvider = Get.find<UserProvider>();

  ChooseModePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chooseModeController = Get.find<ChooseModeController>();

    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/line-map.png'),
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
                    CustomStrings.kChooseMode.tr,
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
                            color:
                                chooseModeController.bikerBackgroundColor.value,
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
                                      CustomStrings.kBikerRole.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            color: chooseModeController
                                                .bikerTitleAndIconColor.value,
                                          ),
                                    ),
                                    Text(
                                      CustomStrings.kBikerDescription.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: chooseModeController
                                                .bikerTextColor.value,
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
                                    .bikerTitleAndIconColor.value,
                              ),
                            ),
                          ],
                        )),
                    onTap: () {
                      chooseModeController.selectBikerMode(context: context);
                    },
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 30.0),
                      decoration: BoxDecoration(
                          color: chooseModeController.keerBackgroundColor.value,
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
                                    CustomStrings.kKeerRole.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                          color: chooseModeController
                                              .keerTitleAndIconColor.value,
                                        ),
                                  ),
                                  Text(
                                    CustomStrings.kKeerDescription.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: chooseModeController
                                              .keerTextColor.value,
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
                                  .keerTitleAndIconColor.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      chooseModeController.selectKeerMode(context: context);
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(CustomStrings.kRemindWords.tr,
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
              onPressedFunc: () async {
                try {
                  if (Biike.role.value != Role.none) {
                    int role = 1;

                    if (Biike.role.value == Role.biker) {
                      role = 2;
                    }

                    if (await _userProvider.changeRole(role: role)) {
                      Biike.localAppData.saveRole(Biike.role.value);
                      Get.offAllNamed(CommonRoutes.HOME);
                    } else {
                      CommonFunctions().showErrorDialog(
                          context: context,
                          message: CustomErrorsString.kDevelopError.tr);
                    }
                  } else {
                    CommonFunctions().showErrorDialog(
                        context: context,
                        message: CustomErrorsString.kNoRoleWereChosen.tr);
                  }
                } catch (e) {
                  CommonFunctions()
                      .showErrorDialog(context: context, message: e.toString());
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
