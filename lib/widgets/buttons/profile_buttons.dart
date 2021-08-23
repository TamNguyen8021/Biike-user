import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              onPressed: () => {},
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.import_contacts,
                      color: CustomColors.kDarkGray,
                      size: 20,
                    ),
                  ),
                  Text(
                    CustomStrings.kSavedAddress,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                  elevation: MaterialStateProperty.all<double>(2.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              onPressed: () => {},
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.settings,
                      color: CustomColors.kDarkGray,
                      size: 20,
                    ),
                  ),
                  Text(
                    CustomStrings.kSettings,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                  elevation: MaterialStateProperty.all<double>(2.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              onPressed: () => {},
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.remove_circle,
                      color: CustomColors.kDarkGray,
                      size: 20,
                    ),
                  ),
                  Text(
                    CustomStrings.kBlockList,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                  elevation: MaterialStateProperty.all<double>(2.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              onPressed: () => {},
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.dialpad,
                      color: CustomColors.kDarkGray,
                      size: 20,
                    ),
                  ),
                  Text(
                    CustomStrings.kSOS,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                  elevation: MaterialStateProperty.all<double>(2.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              onPressed: () => {},
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.help,
                      color: CustomColors.kDarkGray,
                      size: 20,
                    ),
                  ),
                  Text(
                    CustomStrings.kHelp,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                  elevation: MaterialStateProperty.all<double>(2.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              onPressed: () => {},
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.star,
                      color: CustomColors.kDarkGray,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      CustomStrings.kRateApp,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Text(
                      'v1.0.1',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 9),
                    ),
                  ),
                ],
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                  elevation: MaterialStateProperty.all<double>(2.0)),
            ),
          ),
        ),
      ],
    );
  }
}
