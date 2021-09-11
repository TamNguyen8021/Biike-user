import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircularProgressIndicator(),
          ),
          Text(CustomStrings.kLoading),
        ],
      ),
    );
  }
}
