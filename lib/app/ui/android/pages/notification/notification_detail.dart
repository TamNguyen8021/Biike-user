import 'package:flutter/material.dart';

class NotificationDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.red,
      appBar: AppBar(
       backgroundColor: Colors.transparent,
        // backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text("Title"),
      ),
      body: Center(child: Text("Content")),
    );
  }
  
}