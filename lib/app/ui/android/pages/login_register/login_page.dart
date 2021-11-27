import 'package:bikes_user/app/controllers/login_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/login_register/widgets/login_register_text_field.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The '003.1_login' screen
class LoginPage extends StatelessWidget {
  static const String routeName = '/login';

  LoginPage({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.kBlue,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Image(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
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
                            hasForgotPassword: true),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: GetBuilder<LoginController>(builder: (controller) {
                        if (controller.isLoading) {
                          return const SizedBox(
                            width: 135,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        }
                        return CustomTextButton(
                          width: 135,
                          backgroundColor: Colors.white,
                          foregroundColor: CustomColors.kDarkBlue,
                          text: CustomStrings.kLogin.tr,
                          onPressedFunc: () {
                            LoginController.to.login(emailController.text,
                                passwordController.text, context);
                          },
                          hasBorder: false,
                          elevation: 2.0,
                        );
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          CustomStrings.kNoAccount.tr,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        GestureDetector(
                          child: Text(
                            CustomStrings.kRegister.tr,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Get.offAndToNamed(CommonRoutes.REGISTER);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
