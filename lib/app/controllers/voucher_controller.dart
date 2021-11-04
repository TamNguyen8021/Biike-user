import 'package:bikes_user/app/data/providers/voucher_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class VoucherController extends GetxController {
  final _voucherProvider = Get.find<VoucherProvider>();
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);

  RxList<dynamic> voucherList = [].obs;

  Map<String, dynamic> pagination = {};
  int _currentPage = 1;
  int _limit = 20;

  @override
  onInit() {
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

  Future<void> getVoucherList() async {
    voucherList.clear();
    Map<String, dynamic> response = await _voucherProvider
        .getVoucherList(page: _currentPage, limit: _limit);
    voucherList.value = response['data'];
    pagination = response['_meta'];
  }

  /// Lazy loading when view upcoming trips or load stations.
  ///
  /// Author: TamNTT
  Future<void> _fetchPage(int pageKey) async {
    try {
      await getVoucherList();

      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;

      final bool isLastPage =
          pagination['totalRecord'] - previouslyFetchedItemsCount <= _limit;

      if (isLastPage) {
        pagingController.appendLastPage(voucherList);
        _currentPage = 1;
      } else {
        _currentPage += 1;
        int nextPageKey = pageKey;
        nextPageKey += voucherList.length;
        pagingController.appendPage(voucherList, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
      Biike.logger.e('VoucherController - _fetchPage()', error);
      FlutterLogs.logErrorTrace(
          'Biike', 'VoucherController - _fetchPage()', error.toString(), Error());
    }
  }
}
