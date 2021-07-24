import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
// import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseMode extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _ChooseMode();
  }
}
/// The welcoe screen
class _ChooseMode extends State<ChooseMode>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      
      body: Stack(
       children: <Widget>[
        SvgPicture.asset("assets/images/biike-two-person.svg",fit: BoxFit.cover),
        Positioned(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          child: Container(
        child: Column(
          children: <Widget>[
            // Container(
            //   child: 
            //   SvgPicture.asset("assets/images/biike-two-person.svg",fit: BoxFit.fill ),
            // ),
            new Text(
              CustomStrings.kChooseMode,
              textAlign: TextAlign.right,
              style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
              ),
            ),
            Container(
              child: Image(
                image: AssetImage("assets/images/voucher-toco.jpg"),
                fit: BoxFit.contain,
              )
            ),
            Container(
              child: Image( 
              image: AssetImage("assets/images/voucher-toco.jpg"),
                fit: BoxFit.contain,
              ),
            ),
            new Text(
              CustomStrings.kRemindWords,
              textAlign: TextAlign.center,
              style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            )
            )
          ],
        )
        ),
        )
       ], 
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 1.0,
          onPressed: () {},
          backgroundColor: Colors.white,
          foregroundColor: CustomColors.kBlue,
          child: const Icon(Icons.arrow_forward_ios_rounded),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomAppBar(),
      );
  }
}
