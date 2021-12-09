import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountVerificationPage extends StatelessWidget {
  final _profileController = Get.find<ProfileController>();

  AccountVerificationPage({Key? key}) : super(key: key);

  Future<void> _onBackPressed() async {
    await _profileController.getProfile();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    bool isPhoneVerified = Get.arguments['isPhoneVerified'];
    bool isBikeVerified = Get.arguments['isBikeVerified'];

    return OnBackPressed(
      perform: () {
        _onBackPressed();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          hasShape: true,
          hasLeading: true,
          onPressedFunc: () {
            _onBackPressed();
          },
          appBar: AppBar(),
          title: Text(CustomStrings.kAccountVerification.tr),
        ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                children: <Widget>[
                  Text(
                    CustomStrings.kLetsVerifiedAccount.tr,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Icon(
                            Icons.verified,
                            color: CustomColors.kDarkGray,
                            size: 40,
                          ),
                        ),
                        Expanded(
                          child: Icon(
                            Icons.verified,
                            color: CustomColors.kBlue,
                            size: 40,
                          ),
                        ),
                        Expanded(
                          child: Icon(
                            Icons.verified,
                            color: CustomColors.kOrange,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 43.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.circle,
                          color: CustomColors.kBlue,
                          size: 20,
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 3,
                            color: isPhoneVerified ? CustomColors.kBlue : null,
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          color: isPhoneVerified
                              ? CustomColors.kBlue
                              : CustomColors.kDarkGray.withOpacity(0.3),
                          size: 20,
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 3,
                            color: isBikeVerified ? CustomColors.kBlue : null,
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          color: isBikeVerified
                              ? CustomColors.kBlue
                              : CustomColors.kDarkGray.withOpacity(0.3),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            CustomStrings.kEmailVerification.tr,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            CustomStrings.kPhoneVerification.tr,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            CustomStrings.kBikeVerification.tr,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          CustomStrings.kEmailVerificationDescription.tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: CustomColors.kDarkGray),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          CustomStrings.kPhoneVerificationDescription.tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: CustomColors.kDarkGray),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          CustomStrings.kBikeVerificationDescription.tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: CustomColors.kDarkGray),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(CustomStrings.kEmailVerification.tr),
                        Icon(
                          Icons.done,
                          color: CustomColors.kBlue,
                          size: 25,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: CustomColors.kLightGray,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: CustomColors.kDarkGray.withOpacity(0.3),
                          // changes position of shadow
                          offset: Offset(0, 1.25),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 25.0),
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(CustomStrings.kPhoneVerification.tr),
                        Icon(
                          isPhoneVerified ? Icons.done : Icons.gpp_maybe,
                          color: isPhoneVerified
                              ? CustomColors.kBlue
                              : CustomColors.kOrange,
                          size: 25,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: CustomColors.kLightGray,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: CustomColors.kDarkGray.withOpacity(0.3),
                          // changes position of shadow
                          offset: Offset(0, 1.25),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(CustomStrings.kBikeVerification.tr),
                        Icon(
                          isBikeVerified ? Icons.done : Icons.gpp_maybe,
                          color: isBikeVerified
                              ? CustomColors.kBlue
                              : CustomColors.kOrange,
                          size: 25,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: CustomColors.kLightGray,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: CustomColors.kDarkGray.withOpacity(0.3),
                          // changes position of shadow
                          offset: Offset(0, 1.25),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
