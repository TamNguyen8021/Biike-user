import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/data/models/voucher_category.dart';
import 'package:bikes_user/app/data/providers/voucher_category_provider.dart';
import 'package:bikes_user/app/data/providers/voucher_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class VoucherController extends GetxController {
  final _voucherProvider = Get.find<VoucherProvider>();
  final _categoryProvider = Get.find<VoucherCategoryProvider>();
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);

  RxList<VoucherCategory> voucherCategoryList = <VoucherCategory>[].obs;

  Rx<VoucherCategory> category = VoucherCategory.empty().obs;
  bool _isNearMe = false;

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

  Future<void> getVoucherCategoryList() async {
    voucherCategoryList.value = (await _categoryProvider.getVoucherCategoryList(
            page: 1, limit: 30) as List)
        .map((e) => VoucherCategory.fromJson(e))
        .toList();

    voucherCategoryList.insert(0, VoucherCategory.empty());
    category.value = voucherCategoryList[0];
  }

  void updateCategory(category) {
    this.category.value = category;
    pagingController.refresh();
  }

  Future<void> updateNearMe(isSelected) async {
    _isNearMe = isSelected;

    try {
      var isPermitted = await _checkLocationPermission();
      if (!isPermitted) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position.toString());
    } catch (e) {
      CommonFunctions.catchExceptionError(e);
    }
  }

  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {

      // ask for permission
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // if denied
        return false;
      }
    }
     return true;
  }

  Future<List> _getVoucherList() async {
    Map<String, dynamic> response = await _voucherProvider.getVoucherList(
        page: _currentPage,
        limit: _limit,
        cateId: this.category.value.voucherCategoryId! < 0
            ? 0
            : this.category.value.voucherCategoryId);
    pagination = response['_meta'];

    return response['data'];
  }

  /// Lazy loading when list of available vouchers
  ///
  /// Author: UyenNLP
  Future<void> _fetchPage(int pageKey) async {
    try {
      var voucherList = await _getVoucherList();

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
      CommonFunctions.catchExceptionError(error);
    }
  }
}
