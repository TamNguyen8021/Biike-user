import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class InputName extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _InputName();
  }
}
//the verify phone screen
class _InputName extends State<InputName>{
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
          Icons.arrow_forward_rounded,
          size: 30,
          color: CustomColors.kBlue,
        ),
      ),
      
      backgroundColor: CustomColors.kBlue,
      elevation: 0,
      centerTitle: true,
      textTheme: Theme.of(context).textTheme,
      
      ),
      backgroundColor: CustomColors.kBlue,
      body: new Container(
         decoration:  BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/line-map.png"),
                        
                        fit: BoxFit.cover
                        )),
          padding: const EdgeInsets.all(40.0),
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
        CustomStrings.kInputName,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          
        ),
      ),
          new TextField(
            decoration: new InputDecoration(labelText: CustomStrings.kEnterName),
            maxLength: 50,
            keyboardType: TextInputType.number,
            readOnly: false,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.singleLineFormatter],
          )
        ],
      
      )
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