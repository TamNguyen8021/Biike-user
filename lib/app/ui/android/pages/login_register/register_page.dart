import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/register_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/login_register/widgets/login_register_text_field.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/error_text.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class RegisterPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final phoneController = useTextEditingController();
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Image(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 0.6,
              image: AssetImage('assets/images/line-map.png'),
              fit: BoxFit.fitWidth,
              color: CustomColors.kLightGray.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/logo-white.png'),
                  width: 204,
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(CustomStrings.kIntroduction.tr,
                      style: TextStyle(
                        color: CustomColors.kLightGray.withOpacity(0.7),
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    LoginRegisterTextField(
                      labelText: CustomStrings.kEmail.tr,
                      hintText: CustomStrings.kInputEmail.tr,
                      controller: emailController,
                      obscureText: false,
                      hasForgotPassword: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    LoginRegisterTextField(
                        labelText: CustomStrings.kPassword.tr,
                        hintText: CustomStrings.kInputPassword.tr,
                        controller: passwordController,
                        obscureText: true,
                        hasForgotPassword: false),
                    LoginRegisterTextField(
                        labelText: CustomStrings.kFullName.tr,
                        hintText: CustomStrings.kInputName.tr,
                        controller: nameController,
                        obscureText: false,
                        hasForgotPassword: false),
                    LoginRegisterTextField(
                      labelText: CustomStrings.kPhoneNo.tr,
                      hintText: CustomStrings.kInputPhoneNumber.tr,
                      controller: phoneController,
                      obscureText: false,
                      hasForgotPassword: false,
                      keyboardType: TextInputType.phone,
                    ),
                    GetBuilder<RegisterController>(
                      builder: (controller) {
                        if (controller.errorMessage.isNotEmpty) {
                          return ErrorText(
                              errorText: controller.errorMessage.tr,
                              marginTop: 50.0);
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 8.0, bottom: 25.0),
                      child: Column(
                        children: <Widget>[
                          CustomTextButton(
                            width: 135,
                            backgroundColor: Colors.white,
                            foregroundColor: CustomColors.kDarkBlue,
                            text: CustomStrings.kRegister.tr,
                            onPressedFunc: () async {
                              await RegisterController.to.next(
                                  context: context,
                                  name: nameController.text,
                                  email: emailController.text,
                                  pass: passwordController.text,
                                  phone: phoneController.text);
                            },
                            hasBorder: false,
                            elevation: 2.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  CustomStrings.kConfirmTerm.tr,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Text(
                                        CustomStrings.kTermOfUse.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      onTap: () async {
                                        await CommonFunctions().openLink(
                                            url: 'https://www.biike.in',
                                            context: context);
                                      },
                                    ),
                                    Text(CustomStrings.kAnd.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                    GestureDetector(
                                      child: Text(
                                        CustomStrings.kPrivacyPolicy.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      onTap: () async {
                                        await CommonFunctions().openLink(
                                            url: 'https://www.biike.in/privacy',
                                            context: context);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          CustomStrings.kHasAccount.tr,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        GestureDetector(
                          child: Text(
                            CustomStrings.kLogin.tr,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Get.offAndToNamed(CommonRoutes.LOGIN);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton:
      //     GetBuilder<RegisterController>(builder: (controller) {
      //   return NextPageButton(
      //     onPressedFunc: () => RegisterController.to.next(
      //         nameController.text,
      //         emailController.text,
      //         passwordController.text,
      //         phoneController.text),
      //     backgroundColor: Colors.white,
      //     foregroundColor: CustomColors.kBlue,
      //     hoverColor: CustomColors.kLightGray,
      //     isLoading: controller.isLoading,
      //   );
      // }),
    );
  }
}
