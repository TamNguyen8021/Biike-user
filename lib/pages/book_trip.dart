import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';

class BookTrip extends StatelessWidget {
  const BookTrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationBar = CustomAppBar(
      appBar: AppBar(),
      leadingWidget: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: Text(CustomStrings.kBookNewTrip),
    );

    return Scaffold(
      appBar: navigationBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
