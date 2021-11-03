import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ViewPointController extends GetxController {
  final PagingController<int, dynamic> pagingController =
  PagingController(firstPageKey: 0);

  Future<void> init() async {

  }
}