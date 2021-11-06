import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/data/providers/voucher_provider.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class VoucherController extends GetxController {
  final _voucherProvider = Get.find<VoucherProvider>();
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);

  RxList<dynamic> _voucherList = [].obs;

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

  Future<void> _getVoucherList() async {
    _voucherList.clear();
    Map<String, dynamic> response = await _voucherProvider
        .getVoucherList(page: _currentPage, limit: _limit);
    _voucherList.value = response['data'];
    pagination = response['_meta'];
  }

  /// Lazy loading when list of available vouchers
  ///
  /// Author: UyenNLP
  Future<void> _fetchPage(int pageKey) async {
    try {
      await _getVoucherList();

      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;

      final bool isLastPage =
          pagination['totalRecord'] - previouslyFetchedItemsCount <= _limit;

      if (isLastPage) {
        pagingController.appendLastPage(_voucherList);
        _currentPage = 1;
      } else {
        _currentPage += 1;
        int nextPageKey = pageKey;
        nextPageKey += _voucherList.length;
        pagingController.appendPage(_voucherList, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
      CommonFunctions.catchExceptionError(error);
    }
  }
}
