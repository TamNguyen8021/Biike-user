import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class InputPhonePage extends StatefulWidget {
  const InputPhonePage({Key? key}) : super(key: key);

  @override
  _InputPhonePageState createState() => _InputPhonePageState();
}

class _InputPhonePageState extends State<InputPhonePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CustomColors.kBlue,
        body: Padding(
          padding: const EdgeInsets.only(top: 100.0, left: 22.0, right: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(CustomStrings.kInputPhoneNumber,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  )),
              IntlPhoneField(
                keyboardType: TextInputType.phone,
                initialCountryCode: 'VN',
                initialValue: '34 866 9124',
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 20.0),
                    errorText: CustomStrings.kErrorInputPhoneNumber,
                    errorStyle: TextStyle(color: Colors.white, fontSize: 14),
                    counterText: ""),
                dropdownDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                showDropdownIcon: false,
                inputFormatters: [MaskedInputFormatter('00 000 0000')],
              ),
            ],
          ),
        ),
        floatingActionButton: Stack(children: [
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_forward_ios,
              color: CustomColors.kBlue,
            ),
          ),
          // Image(image: AssetImage(''),)
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
