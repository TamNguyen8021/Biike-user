import 'package:bikes_user/main.dart';
import 'package:bikes_user/pages/home/view/home_page.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This widget is the top appbar on [HomePage]
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasLeading;
  final Widget? title;
  final AppBar appBar;
  final bool isVisible;
  final bool hasShape;

  /// Widgets for action property in [AppBar]
  final List<Widget>? actionWidgets;
  final PreferredSizeWidget? bottomAppBar;

  const CustomAppBar(
      {Key? key,
      required this.isVisible,
      required this.hasShape,
      required this.hasLeading,
      this.title,
      required this.appBar,
      this.actionWidgets,
      this.bottomAppBar})
      : super(key: key);

  @override
  Size get preferredSize {
    Size appbarSize = new Size.fromHeight(appBar.preferredSize.height);
    if (bottomAppBar != null) {
      appbarSize = new Size.fromHeight(appBar.preferredSize.height + 40.0);
    }
    return appbarSize;
  }

  @override
  Widget build(BuildContext context) {
    ShapeBorder? _shapeBorder;
    Widget? _leadingWidget;

    if (hasShape) {
      _shapeBorder = RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)));
    }

    if (hasLeading) {
      _leadingWidget = IconButton(
        onPressed: () {
          if (ModalRoute.of(context)!.settings.name.toString() == '/profile') {
            Get.offAllNamed('/home');
          } else {
            Get.back();
          }
        },
        icon: Icon(
          Icons.arrow_back,
        ),
      );
    }
    return Visibility(
      visible: isVisible,
      child: AppBar(
        backwardsCompatibility: false,
        leading: _leadingWidget,
        title: title,
        actions: actionWidgets,
        bottom: bottomAppBar,
        shape: _shapeBorder,
        backgroundColor: ModalRoute.of(context)!.settings.name == '/home' &&
                Biike.role.value == Role.Driver
            ? CustomColors.kOrange
            : CustomColors.kBlue,
      ),
    );
  }
}
