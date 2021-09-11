import 'package:flutter/material.dart';

class AdContainer extends StatelessWidget {
  const AdContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 135.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Image.asset(
          'assets/images/ads-heiniken.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
