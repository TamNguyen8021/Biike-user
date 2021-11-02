import 'package:bikes_user/app/common/functions/snackbar.dart';
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
                labelText: 'email',
              ),
              style: Theme.of(context).textTheme.bodyText1,
              validator: (val) {
                return _validate(val ?? '');
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Get.back(closeOverlays: true);

              final result = await firbaseService
                  .resetPasswordWithEmail(emailController.text);
              if (result) {
                SnackBarServices.showSnackbar(
                    title: 'Bike',
                    message:
                        'chúng tôi đã gửi email thay đổi mật khẩu, vui lòng kiểm tra email');
              }
            }
          },
          child: Text('Gửi'),
        ),
      ],
    );
  }

  String? _validate(String email) {
    if (email.trim().isEmpty) {
      return 'email must not be null';
    }

    if (!(EmailValidator.validate(email) &&
        email.toUpperCase().contains('@FPT.EDU.VN'))) {
      return 'must login with FPT email';
    }

    return null;
  }
}
