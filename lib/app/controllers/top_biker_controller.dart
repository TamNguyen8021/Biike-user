import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/top_biker_provider.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/top_biker_card.dart';
import 'package:get/get.dart';

/// Manage states for [TopBikerPage]
class TopBikerController extends GetxController {
  RxList topBiker = [].obs;

  Future<void> getTopBiker() async {
    topBiker.clear();

    dynamic response = await TopBikerProvider().getTopBiker();
    if (response != null) {
      try {
        var index = 0;
        for (var biker in response) {
          User user = User.fromJson(biker);

          topBiker.add(
              TopBikerCard(
                  index: index,
                  avatarUrl: user.avatar,
                  name: user.userFullname,
                  point: user.totalPoint
              )
          );

          index ++;
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
