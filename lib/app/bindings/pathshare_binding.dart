import 'package:bikes_user/app/data/providers/pathshare_provider.dart';
import 'package:get/get.dart';

class PathshareBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PathshareProvider());
  }
}
