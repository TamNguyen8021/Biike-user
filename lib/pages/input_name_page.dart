import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/others/error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

/// '004.3_input_name' screen
class InputNamePage extends StatefulWidget {
  const InputNamePage({Key? key}) : super(key: key);

  @override
  _InputNamePageState createState() => _InputNamePageState();
}

class _InputNamePageState extends State<InputNamePage> {
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
                  Text(CustomStrings.kInputName,
                      style: Theme.of(context).textTheme.headline1),
                  TextFormField(
                    initialValue: "Phương Uyên",
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    inputFormatters: [
                      // FilteringTextInputFormatter.allow(RegExp(r'\p{L}+'))
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 20.0),
                    ),
                  ),
                  ErrorText(
                      errorText: CustomStrings.kErrorName, marginTop: 50.0)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/chooseRole');
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
