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
      // title: Text(
        // CustomStrings.kInputName,
        // textAlign: TextAlign.center,
        // style: TextStyle(
        //   fontSize: 18,
        //   fontWeight: FontWeight.bold,
        //   color: Colors.white,
          
      //   ),
      // ),
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
          new Text(
            CustomStrings.kInputName,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          )
          ),
          new TextField(
            decoration: new InputDecoration(
               enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.5)),
              labelText: 
              CustomStrings.kEnterName, 
              hintText: CustomStrings.kHintName, 
              labelStyle: TextStyle(color: Colors.white ),
              errorText: CustomStrings.kErrorName,
              errorStyle: TextStyle(color: Colors.white)
              ),
            onChanged: (value) {
              
            },
            // maxLength: 50,
            keyboardType: TextInputType.name,
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