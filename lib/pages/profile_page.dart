import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/appbars/bottom_tabbar.dart';
import 'package:bikes_user/widgets/pages/activity.dart';
import 'package:bikes_user/widgets/pages/customer_home_full.dart';
import 'package:bikes_user/widgets/pages/driver_home.dart';
import 'package:flutter/material.dart';

/// The home screen template for both ke-er and biker
class ProfilePage extends StatelessWidget {
  final String role;
  const ProfilePage({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 24,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment(1, 0),
                    child: ElevatedButton(
                      child: Text('Đi ké mode'),
                      onPressed: () {
                        print('Button pressed ...');
                      },
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: 120,
              height: 120,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/profile-1.jpg',
              ),
            ),
            Text(
              'Đỗ Hữu Phát',

            ),
            ElevatedButton(
              child: Text('4.5'),

              onPressed: () {
                print('Button pressed ...');
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Số điện thoại',
                ),
                TextField(

                ),

                Text(
                  'Email',

                  ),
                TextField(

                ),

                Text(
                  'Hello World',

                  ),
                TextField(

                ),

                Text(
                  'Hello World',

                  ),

                TextField(

                ),


              ],
            ),

            Divider(),

          ],
        ),
      ),
    );
  }
}
