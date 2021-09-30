import 'package:bikes_user/app/ui/android/pages/home/banner/banner.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

class AdContainer extends HookWidget {
  AdContainer({Key? key}) : super(key: key);
  final banners = [
    BannerItem(
      url: 'https://flutter.dev',
      path: 'assets/images/facebook-featured-img.jpg',
    ),
    BannerItem(
      url: 'https://pub.dev',
      path: 'assets/images/ads-heiniken.jpg',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final indexState = useState(0);
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: banners.length,
            itemBuilder: (context, index, realIndex) {
              final item = banners[index];
              return GestureDetector(
                onTap: () {
                  _launchUniversalLinkIos(item.url);
                },
                child: Image.asset(item.path, fit: BoxFit.cover),
              );
            },
            options: CarouselOptions(
              viewportFraction: 1,
              enlargeCenterPage: false,
              autoPlay: true,
              aspectRatio: 2,
              onPageChanged: (index, reason) {
                indexState.value = index;
              },
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: banners.asMap().entries.map((entry) {
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: indexState.value == entry.key
                      ? Colors.grey
                      : Colors.black,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUniversalLinkIos(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: true,
          forceWebView: true,
        );
      } else {
        // show thong bao khong mo duoc
      }
    } catch (e) {
      // loi ngoai le
    }
  }
}
