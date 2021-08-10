import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/others/error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

/// The '007-input-phone' screen
class InputPhonePage extends StatefulWidget {
  const InputPhonePage({Key? key}) : super(key: key);

  @override
  _InputPhonePageState createState() => _InputPhonePageState();
}

class _InputPhonePageState extends State<InputPhonePage> {
  @override
  Widget build(BuildContext context) {
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
                  Text(
                    CustomStrings.kInputPhoneNumber,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: IntlPhoneField(
                      keyboardType: TextInputType.phone,
                      initialCountryCode: 'VN',
                      initialValue: '34 866 9124',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 20.0),
                        counterText: "",
                      ),
                      dropdownDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      showDropdownIcon: false,
                      inputFormatters: [MaskedInputFormatter('00 000 0000')],
                    ),
                  ),
                  ErrorText(errorText: CustomStrings.kErrorInputPhoneNumber)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/verifyPhone');
        },
        backgroundColor: Colors.white,
        foregroundColor: CustomColors.kBlue,
        child: Icon(
          Icons.arrow_forward_ios,
          size: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
