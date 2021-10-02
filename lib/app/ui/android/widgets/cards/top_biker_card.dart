import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// This widget contains a top biker's details
class TopBikerCard extends StatelessWidget {
  final int index;
  final String avatarUrl;
  final String name;
  final int point;

  TopBikerCard(
      {required this.index,
      required this.avatarUrl,
      required this.name,
      required this.point,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _cardContentColor;
    Color _pointContentColor;
    double _cardHeight;
    double _avatarHeight;
    String _topRateIconUrl;
    int noShow = index + 1;

    if (index < 3) {
      _cardContentColor = CustomColors.kLightBlue;
      _pointContentColor = CustomColors.kOrange;
      _cardHeight = 82;
      _avatarHeight = 30;
      _topRateIconUrl = 'assets/images/top-rated-$noShow.png';
    } else {
      _cardContentColor = CustomColors.kLightGray;
      _pointContentColor = CustomColors.kDarkBlue;
      _cardHeight = 57.4;
      _avatarHeight = 20;
      _topRateIconUrl = '';
    }

    return GestureDetector(
      child: Container(
        height: _cardHeight,
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Padding(
                    padding: const EdgeInsets.only(left: 9.0, right: 0.0),
                    child: index < 3
                        ? Image.asset(_topRateIconUrl, height: 35)
                        : Center(child: Text('$noShow')))),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 5.0),
                child: CircleAvatar(
                  radius: _avatarHeight,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
              ),
            ),
            Expanded(
                flex: 7,
                child: Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                )),
            Expanded(
                flex: 4,
                child: Container(
                    margin: const EdgeInsets.only(right: 15.0),
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                        color: _pointContentColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(right: 0.0),
                            child: Text(
                              '$point',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: SvgPicture.asset(
                            'assets/images/king.svg',
                            height: 13,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ))),
          ],
        ),
        decoration: BoxDecoration(
            color: _cardContentColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: CustomColors.kDarkGray.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 0.5,
                // changes position of shadow
                offset: Offset(0, 0.5),
              )
            ]),
      ),
    );
  }
}
