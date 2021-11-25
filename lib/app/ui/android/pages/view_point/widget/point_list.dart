import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/view_point_controller.dart';
import 'package:bikes_user/app/data/models/point_history.dart';
import 'package:bikes_user/app/ui/android/pages/view_point/widget/point_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PointList extends StatelessWidget {
  PointList({Key? key}) : super(key: key);
  final _viewPointController = Get.find<ViewPointController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _viewPointController,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 22.0, right: 22.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 230,
              child: RefreshIndicator(
                onRefresh: () => Future.sync(
                  () => _viewPointController.pagingController.refresh(),
                ),
                child: PagedListView<int, dynamic>(
                  pagingController: _viewPointController.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<dynamic>(
                      itemBuilder: (context, item, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: PointCard(
                              pointHistory: PointHistory.fromJson(
                                  _viewPointController
                                      .pagingController.itemList!
                                      .elementAt(index)),
                            ),
                          ),
                      noItemsFoundIndicatorBuilder: (BuildContext context) {
                        return Text(CustomErrorsString.kNoHistory.tr);
                      }),
                ),
              ),
            ),
          );
        });
  }
}
