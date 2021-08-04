import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The '008-verify-phone' screen
class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage({Key? key}) : super(key: key);

  @override
  _VerifyPhonePageState createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: CustomColors.kBlue,
            ),
          ),
          title: Text(
            CustomStrings.kVerifyPhone,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: CustomColors.kBlue,
          elevation: 0,
          centerTitle: true,
          textTheme: Theme.of(context).textTheme,
        ),
        backgroundColor: CustomColors.kBlue,
        body: new Container(
          padding: const EdgeInsets.all(40.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TextField(
                decoration: new InputDecoration(
                  labelText: CustomStrings.kInputVerifyCode,
                ),
                maxLength: 4,
                cursorHeight: 18,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                elevation: 1.0,
                onPressed: () {},
                backgroundColor: Colors.white,
                foregroundColor: CustomColors.kBlue,
                child: const Icon(Icons.arrow_back_ios_rounded),
              ),
              FloatingActionButton(
                elevation: 1.0,
                onPressed: () {},
                backgroundColor: Colors.white,
                foregroundColor: CustomColors.kBlue,
                child: const Icon(Icons.arrow_forward_ios_rounded),
              )
            ],
          ),
        )
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // bottomNavigationBar: BottomAppBar(),
        );
  }
}