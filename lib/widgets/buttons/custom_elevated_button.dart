import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String route;
  final IconData? icon;
  final String text;
  final double elevation;

  const CustomElevatedButton(
      {Key? key,
      required this.route,
      this.icon,
      required this.text,
      required this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ElevatedButton.icon(
          onPressed: () => {Navigator.pushNamed(context, route)},
          icon: Icon(
            icon,
            size: 22,
          ),
          label: Text(
            text,
            style: Theme.of(context).textTheme.button!.copyWith(fontSize: 12),
          ),
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              elevation: MaterialStateProperty.all<double>(elevation))),
    );
  }
}
