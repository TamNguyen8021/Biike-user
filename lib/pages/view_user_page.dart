import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/others/user_rating.dart';
import 'package:flutter/material.dart';

class ViewUserPage extends StatelessWidget {
  const ViewUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        appBar: AppBar(),
        hasLeading: true,
        title: Text(CustomStrings.kViewUser),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 22.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile-1.jpg'),
                  radius: 55,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: UserRating(score: '4.5'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text('Phát Đỗ',
                    style: TextStyle(
                        fontSize: 18,
                        color: CustomColors.kDarkGray,
                        fontWeight: FontWeight.bold)),
              ),
              Text(
                'Nam',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: TextFormField(
                  readOnly: true,
                  initialValue: '034 866 9124',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.kDarkGray),
                  decoration:
                      InputDecoration(labelText: CustomStrings.kPhoneNo),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: SizedBox(
                      height: 35,
                      child: ElevatedButton.icon(
                          onPressed: () =>
                              {Navigator.pushNamed(context, '/editProfile')},
                          icon: Icon(
                            Icons.phone,
                            size: 22,
                          ),
                          label: Text(
                            CustomStrings.kCall,
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(fontSize: 12),
                          ),
                          style: Theme.of(context).elevatedButtonTheme.style),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: SizedBox(
                      height: 35,
                      child: ElevatedButton.icon(
                          onPressed: () =>
                              {Navigator.pushNamed(context, '/editProfile')},
                          icon: Icon(
                            Icons.message,
                            size: 22,
                          ),
                          label: Text(
                            CustomStrings.kMessage,
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(fontSize: 12),
                          ),
                          style: Theme.of(context).elevatedButtonTheme.style),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
