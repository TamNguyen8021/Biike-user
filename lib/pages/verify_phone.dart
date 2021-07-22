import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
//the verify phone screen
class VerifiPhonePage extends StatelessWidget {
  const VerifiPhonePage({Key? key}) : super(key: key);
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
      body: SafeArea(
        child: Column() 
      ),
      
      );
  }
}