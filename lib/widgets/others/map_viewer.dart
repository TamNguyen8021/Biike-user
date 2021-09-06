import 'package:flutter/material.dart';

class MapViewer extends StatelessWidget {
  const MapViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
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
