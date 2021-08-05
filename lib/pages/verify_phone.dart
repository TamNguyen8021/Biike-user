import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Verify extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new VerifiPhonePage();
  }
}
//the verify phone screen
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
      
      backgroundColor: CustomColors.kBlue,
      elevation: 0,
      centerTitle: true,
      textTheme: Theme.of(context).textTheme,
      
      ),
      backgroundColor: CustomColors.kBlue,
      body: new Container(
         decoration:  BoxDecoration(
          //  border: Border.all(width: 1.0),
                    image: DecorationImage(
                        image: AssetImage("images/line-map-2.png", ),
                        // alignment: AlignmentDirectional.bottomCenter
                        fit: BoxFit.fitWidth, 
                        
                        )),
                      
          padding: const EdgeInsets.all(0.0),
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
          new Text(
        CustomStrings.kVerifyPhone,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
          new TextField(
            decoration: new InputDecoration(labelText: CustomStrings.kInputVerifyCode,),
            maxLength: 4,
            cursorHeight: 18,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          ),
          
        ],
        
      
      ),
      
      ),
      bottomNavigationBar: BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Container(height: 50.0),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
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