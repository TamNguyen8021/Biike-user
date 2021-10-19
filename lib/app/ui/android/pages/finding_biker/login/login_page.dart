import 'package:bikes_user/app/controllers/login_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/finding_biker/login/forgot_password.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        body: Stack(
          alignment: Alignment.center,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: SvgPicture.asset(
                  "assets/images/biike-two-person.svg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: SingleChildScrollView(
                child: Column(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          textFromFiledCustom(
                            context,
                            controller: emailController,
                            hintText: 'email',
                            paddingBottom: 14,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          textFromFiledCustom(
                            context,
                            controller: passwordController,
                            hintText: 'password',
                            obscureText: true,
                            paddingBottom: 20,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TextButton(
                        onPressed: () {
                          LoginController.to.login(emailController.text,
                              passwordController.text, context);
                        },
                        child:
                            GetBuilder<LoginController>(builder: (controller) {
                          if (controller.isLoading) {
                            return SizedBox.fromSize(
                              size: Size(14.sp, 14.sp),
                              child: CircularProgressIndicator(
                                color: Colors.blueAccent,
                              ),
                            );
                          }
                          return Text(
                            'Đăng nhập',
                            style: TextStyle(
                              color: CustomColors.kDarkBlue,
                              fontSize: 14.sp,
                            ),
                          );
                        }),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 5.0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 16.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TextButton(
                        onPressed: () => Get.toNamed(CommonRoutes.REGISTER),
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(
                            color: CustomColors.kDarkBlue,
                            fontSize: 14.sp,
                          ),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 5.0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 16.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TextButton(
                        onPressed: () {
                          Get.dialog(ForgotPasswordDialog());
                        },
                        child: Text(
                          'Quên mật khẩu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget textFromFiledCustom(BuildContext context,
      {required String hintText,
      required TextEditingController controller,
      bool obscureText = false,
      required double paddingBottom,
      bool isFormInputPhone = false,
      Function(String newVal)? onChange,
      TextInputType? keyboardType}) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
          ),
          Row(
            children: [
              if (isFormInputPhone) ...[
                Container(
                  margin: const EdgeInsets.only(right: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.6),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Text('+84',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.redAccent)),
                  ),
                ),
              ],
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  obscureText: obscureText,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
