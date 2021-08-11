import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/buttons/next_page_button.dart';
import 'package:bikes_user/widgets/buttons/previous_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// '004.4_choose_mode' screen
class ChooseModePage extends StatelessWidget {
  const ChooseModePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/line-map.png"),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      CustomColors.kLightGray.withOpacity(0.5),
                      BlendMode.dstIn))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, bottom: 20.0),
                  child: Text(
                    CustomStrings.kChooseMode,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                        color: CustomColors.kLightGray,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 20.0, 10.0, 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  CustomStrings.kDriverRole,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                Text(
                                  CustomStrings.kDriverDescription,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  overflow: TextOverflow.clip,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: SvgPicture.asset(
                              'assets/images/scooter-front-view.svg'),
                        ),
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.only(bottom: 30.0),
                  decoration: BoxDecoration(
                      color: CustomColors.kLightGray,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 20.0, 10.0, 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                CustomStrings.kCustomerRole,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Text(
                                CustomStrings.kCustomerDescription,
                                style: Theme.of(context).textTheme.bodyText1,
                                overflow: TextOverflow.clip,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: SvgPicture.asset('assets/images/helmet.svg'),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(CustomStrings.kRemindWords,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: CustomColors.kLightGray.withOpacity(0.8))),
                )
              ],
            ),
          )),
      floatingActionButton: Container(
        width: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            PreviousPageButton(route: '/inputName'),
            NextPageButton(route: '/inputName'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
