import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/data/providers/redemption_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RedemptionController extends GetxController {
  final _redemptionProvider = Get.find<RedemptionProvider>();
  final PagingController<int, dynamic> pagingController =
  PagingController(firstPageKey: 0);
  List<dynamic> _yourVoucherList = [];

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

  Future<dynamic> exchangeVoucher(voucherId) async {
    Map<String, dynamic> data = <String, dynamic>{
      'userId': Biike.userId.value,
      'voucherId': voucherId
    };

    return await _redemptionProvider.exchangeVoucher(data);
  }

  Future<void> getYourVoucherList() async {
    _yourVoucherList.clear();
    Map<String, dynamic> response = await _redemptionProvider.getYourVoucherList(
        userId: Biike.userId.value, page: _currentPage, limit: _limit);
  }

  Future<void> _getYourVoucherList() async {
    _yourVoucherList.clear();
    Map<String, dynamic> response = await _redemptionProvider.getYourVoucherList(
        userId: Biike.userId.value, page: _currentPage, limit: _limit);

    _yourVoucherList = response['data'];
    pagination = response['_meta'];
  }

  Future<Map<String, dynamic>> getRedemptionDetailByRedemptionId(
      redemptionId) async {
    return await _redemptionProvider
        .getRedemptionDetailByRedemptionId(redemptionId);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await _getYourVoucherList();

      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;

      final bool isLastPage =
          pagination['totalRecord'] - previouslyFetchedItemsCount <= _limit;

      if (isLastPage) {
        pagingController.appendLastPage(_yourVoucherList);
        _currentPage = 1;
      } else {
        _currentPage += 1;
        int nextPageKey = pageKey;
        nextPageKey += _yourVoucherList.length;
        pagingController.appendPage(_yourVoucherList, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
      CommonFunctions.logBiike(error: error);
      CommonFunctions.logErrorTraceFlutter(error: error);
    }
  }
}
