import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//the verify phone screen
class Verify extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new VerifiPhonePage();
  }
}
class VerifiPhonePage extends State<Verify>{
  // const VerifiPhonePage({Key? key}) : super(key: key);
  // final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading: GestureDetector(
        onTap: (){
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
            decoration: new InputDecoration(labelText: CustomStrings.kInputVrifyCode,),
            maxLength: 4,
            cursorHeight: 18,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          )
        ],
      
      )
      )
    );
  }
}