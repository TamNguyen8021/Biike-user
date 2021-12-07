import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/top_biker_provider.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/top_biker_card.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

/// Manage states for [TopBikerPage]
class TopBikerController extends GetxController {
  RxList topBiker = [].obs;
  Rx<String> userAvatar = "".obs;
  Rx<String> userFullName = "".obs;
  Rx<int> userPoint = 0.obs;

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
                  point: biker['maxTotalPoint']
              )
          );

          index ++;
        }
      } catch (e) {
        print(e);
      }
    }
    response = await UserProvider().getProfile(userId: Biike.userId.value);
    if (response != null) {
      try {
        User user = User.fromJson(response);
        userAvatar.value = user.avatar;
        userFullName.value = user.userFullname;
        userPoint.value = response['maxTotalPoint'];
      } catch (e) {
        print(e);
      }
    }
  }
}
