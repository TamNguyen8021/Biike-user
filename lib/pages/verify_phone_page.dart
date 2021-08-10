import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/others/error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// The '004.2_verify_phone' screen
class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage({Key? key}) : super(key: key);

  @override
  _VerifyPhonePageState createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/line-map.png'),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    CustomColors.kLightGray.withOpacity(0.5),
                    BlendMode.dstIn))),
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0, left: 22.0, right: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                CustomStrings.kInputVerifyCode,
                style: Theme.of(context).textTheme.headline1,
              ),
              Container(
                width: 200.0,
                margin: const EdgeInsets.only(bottom: 5.0, top: 10.0),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white,
                  textStyle: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 40),
                  pastedTextStyle: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 40),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,
                  ),
                  onChanged: (code) {},
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    CustomStrings.kResendVerifyCode,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
              ErrorText(
                errorText: CustomStrings.kInvalidPin,
                marginTop: 25.0,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/inputPhone');
              },
              backgroundColor: Colors.white,
              foregroundColor: CustomColors.kBlue,
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/inputName');
              },
              backgroundColor: Colors.white,
              foregroundColor: CustomColors.kBlue,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 25,
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
