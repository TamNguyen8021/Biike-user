import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/data/providers/pathshare_provider.dart';
import 'package:get/get.dart';

class PathshareBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(PathshareProvider());
  }
}
