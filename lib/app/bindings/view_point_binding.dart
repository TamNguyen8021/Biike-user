import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/view_point_controller.dart';
import 'package:bikes_user/app/data/providers/point_history_provider.dart';
import 'package:get/get.dart';

class ViewPointBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(PointHistoryProvider());
    CommonFunctions.bind(ViewPointController());
  }
}
