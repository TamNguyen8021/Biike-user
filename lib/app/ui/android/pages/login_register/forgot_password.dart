import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/services/firebase_services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordDialog> {
  late FirebaseServices firbaseService;
  late TextEditingController emailController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    firbaseService = getIt<FirebaseServices>();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: CustomStrings.kEmail.tr,
              ),
              style: Theme.of(context).textTheme.bodyText1,
              validator: (val) {
                return _validate(val ?? '');
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Get.back(closeOverlays: true);

              final result = await firbaseService.resetPasswordWithEmail(
                  context: context, email: emailController.text);
              if (result) {
                CommonFunctions().showInfoDialog(
                    context: context,
                    message: CustomStrings.kSendResetPasswordEmail.tr);
              }
            }
          },
          child: Text(CustomStrings.kBtnSend.tr),
        ),
      ],
    );
  }

  String? _validate(String email) {
    if (email.trim().isEmpty) {
      return CustomErrorsString.kEmailMustNotBeEmpty.tr;
    }

    if (!(EmailValidator.validate(email) &&
        email.toUpperCase().contains('@FPT.EDU.VN'))) {
      return CustomErrorsString.kMustLoginWithFPTEmail.tr;
    }

    return null;
  }
}
