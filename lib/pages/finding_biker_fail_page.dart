import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/buttons/exit_button.dart';
import 'package:bikes_user/widgets/buttons/return_button.dart';
import 'package:flutter/material.dart';

/// The '015-cus-book-now-failed' screen
class FindingBikerFailPage extends StatelessWidget {
  const FindingBikerFailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            CustomStrings.kFindBikerFail,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: CustomColors.kBlue,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            CustomStrings.kTips,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: CustomColors.kBlue, fontSize: 12),
                          ),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0, top: 15.0),
                  child: IntrinsicWidth(
                    stepWidth: 150,
                    child: Column(
                      children: <Widget>[
                        ReturnButton(),
                        Padding(padding: EdgeInsets.all(10.0)),
                        ExitButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
