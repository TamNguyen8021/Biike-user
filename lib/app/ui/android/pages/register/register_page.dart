import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/register_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/next_page_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/error_text.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

/// '004.3_input_name' screen
class RegisterPage extends HookWidget {
  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    final phoneController = useTextEditingController();
    final userNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

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
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 100.0, left: 22.0, right: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  textFromFiledCustom(
                    context,
                    controller: phoneController,
                    hintText: CustomStrings.kInputPhoneNumber.tr,
                    paddingBottom: 14,
                    keyboardType: TextInputType.phone,
                    isFormInputPhone: true,
                  ),
                  textFromFiledCustom(
                    context,
                    controller: userNameController,
                    hintText: CustomStrings.kInputName.tr,
                    paddingBottom: 14,
                  ),
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
                    paddingBottom: 0,
                  ),
                  GetBuilder<RegisterController>(
                    builder: (controller) {
                      if (controller.errorMessage.isNotEmpty) {
                        return ErrorText(
                            errorText: controller.errorMessage.tr,
                            marginTop: 50.0);
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          GetBuilder<RegisterController>(builder: (controller) {
        return NextPageButton(
          onPressedFunc: () => RegisterController.to.next(
              userNameController.text,
              emailController.text,
              passwordController.text,
              phoneController.text),
          backgroundColor: Colors.white,
          foregroundColor: CustomColors.kBlue,
          hoverColor: CustomColors.kLightGray,
          isLoading: controller.isLoading,
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
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
