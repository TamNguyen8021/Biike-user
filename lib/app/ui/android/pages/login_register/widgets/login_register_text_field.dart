import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/pages/login_register/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginRegisterTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final bool? isFormInputPhone;
  final bool hasForgotPassword;
  final Function(String newVal)? onChange;
  final TextInputType? keyboardType;

  const LoginRegisterTextField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.controller,
      required this.obscureText,
      this.onChange,
      this.keyboardType,
      this.isFormInputPhone,
      required this.hasForgotPassword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: <Widget>[
          // if (isFormInputPhone) ...[
          //   Container(
          //     margin: const EdgeInsets.only(right: 4),
          //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          //     decoration: BoxDecoration(
          //       color: Colors.white.withOpacity(.6),
          //       borderRadius: BorderRadius.circular(24),
          //     ),
          //     child: Center(
          //       child: Text('+84',
          //           style: Theme.of(context)
          //               .textTheme
          //               .bodyText1!
          //               .copyWith(color: Colors.redAccent)),
          //     ),
          //   ),
          // ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                labelText,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              if (hasForgotPassword) ...[
                GestureDetector(
                  child: Text(
                    CustomStrings.kForgotPassword.tr,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.dialog(ForgotPasswordDialog());
                  },
                ),
              ]
            ],
          ),
          // Expanded(
          /*child:*/ Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.black),
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: const EdgeInsets.only(left: 16.0),
                filled: true,
                fillColor: Colors.white.withOpacity(0.7),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.white)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.white)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
          ),
          // ),
        ],
      ),
    );
  }
}
