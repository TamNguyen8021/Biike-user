import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/data/providers/redemption_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RedemptionController extends GetxController {
  final _redemptionProvider = Get.find<RedemptionProvider>();
  final PagingController<int, dynamic> yourVoucherPagingController =
      PagingController(firstPageKey: 0);
  final PagingController<int, dynamic> usedVoucherPagingController =
      PagingController(firstPageKey: 0);

  Map<String, dynamic> _yourVoucherPagination = {};
  Map<String, dynamic> _usedVoucherPagination = {};
  int _yourVoucherCurrentPage = 1;
  int _usedVoucherCurrentPage = 1;
  int _limit = 20;

  @override
  onInit() {
    yourVoucherPagingController.addPageRequestListener((pageKey) {
      _fetchYourVoucherPage(pageKey);
    });
    usedVoucherPagingController.addPageRequestListener((pageKey) {
      _fetchUsedVoucherPage(pageKey);
    });

    super.onInit();
  }

  @override
  dispose() {
    yourVoucherPagingController.dispose();
    usedVoucherPagingController.dispose();
    super.dispose();
  }

  Future<dynamic> _getYourVoucherList() async {
    Map<String, dynamic> response =
        await _redemptionProvider.getYourVoucherList(
            userId: Biike.userId.value,
            expiredStatus: false,
            page: _yourVoucherCurrentPage,
            limit: _limit);

    _yourVoucherPagination = response['_meta'];
    return response['data'];
  }

  Future<dynamic> _getUsedVoucherList() async {
    Map<String, dynamic> response =
        await _redemptionProvider.getYourVoucherList(
            userId: Biike.userId.value,
            expiredStatus: true,
            page: _usedVoucherCurrentPage,
            limit: _limit);

    _usedVoucherPagination = response['_meta'];
    return response['data'];
  }

  Future<void> _fetchYourVoucherPage(int pageKey) async {
    try {
      List voucherList = await _getYourVoucherList();

      final int previouslyFetchedItemsCount =
          yourVoucherPagingController.itemList?.length ?? 0;

      final bool isLastPage =
          _yourVoucherPagination['totalRecord'] - previouslyFetchedItemsCount <=
              _limit;

      if (isLastPage) {
        yourVoucherPagingController.appendLastPage(voucherList);
        _yourVoucherCurrentPage = 1;
      } else {
        _yourVoucherCurrentPage += 1;
        int nextPageKey = pageKey;
        nextPageKey += voucherList.length;
        yourVoucherPagingController.appendPage(voucherList, nextPageKey);
      }
    } catch (error) {
      yourVoucherPagingController.error = error;
      CommonFunctions.catchExceptionError(error);
    }
  }

  Future<void> _fetchUsedVoucherPage(int pageKey) async {
    try {
      List voucherList = await _getUsedVoucherList();

      final int previouslyFetchedItemsCount =
          usedVoucherPagingController.itemList?.length ?? 0;

      final bool isLastPage =
          _usedVoucherPagination['totalRecord'] - previouslyFetchedItemsCount <=
              _limit;

      if (isLastPage) {
        usedVoucherPagingController.appendLastPage(voucherList);
        _usedVoucherCurrentPage = 1;
      } else {
        _usedVoucherCurrentPage += 1;
        int nextPageKey = pageKey;
        nextPageKey += voucherList.length;
        usedVoucherPagingController.appendPage(voucherList, nextPageKey);
      }
    } catch (error) {
      usedVoucherPagingController.error = error;
      CommonFunctions.catchExceptionError(error);
    }
  }

  Future<dynamic> exchangeVoucher(voucherId) async {
    Map<String, dynamic> data = <String, dynamic>{
      'userId': Biike.userId.value,
      'voucherId': voucherId
    };

    return await _redemptionProvider.exchangeVoucher(data);
  }

  Future<Map<String, dynamic>> getRedemptionDetailByRedemptionId(
      redemptionId) async {
    return await _redemptionProvider
        .getRedemptionDetailByRedemptionId(redemptionId);
  }

  Future<dynamic> editVoucherUsage(redemptionId) async {
    dynamic result = await _redemptionProvider.editVoucherUsage(redemptionId);
    if (result is String) {
      return result;
    }

    return await _redemptionProvider
        .getRedemptionDetailByRedemptionId(redemptionId);
  }

  void refreshList() {
    yourVoucherPagingController.refresh();
    usedVoucherPagingController.refresh();
  }
}
