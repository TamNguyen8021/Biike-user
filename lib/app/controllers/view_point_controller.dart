import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/data/providers/point_history_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ViewPointController extends GetxController {
  final _pointProvider = Get.find<PointHistoryProvider>();
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);

  Map<String, dynamic> pagination = {};
  int _currentPage = 1;
  int _limit = 10;

  @override
  onInit() async {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.onInit();
  }

  @override
  dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future<List> _getPointHistory() async {
    Map<String, dynamic> response = await _pointProvider.getUserPointHistory(
        userId: Biike.userId.value, page: _currentPage, limit: _limit);
    pagination = response['_meta'];
    return response['data'];
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List pointList = await _getPointHistory();

      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;

      final bool isLastPage =
          pagination['totalRecord'] - previouslyFetchedItemsCount <= _limit;

      if (isLastPage) {
        pagingController.appendLastPage(pointList);
        _currentPage = 1;
      } else {
        _currentPage += 1;
        int nextPageKey = pageKey;
        nextPageKey += pointList.length;
        pagingController.appendPage(pointList, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
      CommonFunctions.catchExceptionError(error);
    }
  }
}
