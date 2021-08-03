import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

class ChooseMode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ChooseMode();
  }
}

/// The welcoe screen
class _ChooseMode extends State<ChooseMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Container(
          //   child:
          //   SvgPicture.asset("assets/images/biike-two-person.svg",fit: BoxFit.fill ),
          // ),
          new Text(
            CustomStrings.kChooseMode,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Container(
              child: Image(
            image: AssetImage("assets/images/voucher-toco.jpg"),
            width: 250.0,
            height: 240.0,
          )),
          Container(
            child: Image(
              image: AssetImage("assets/images/voucher-toco.jpg"),
              height: 240.0,
              width: 250.0,
            ),
          ),
          new Text(CustomStrings.kRemindWords,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ))
        ],
      )),
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
