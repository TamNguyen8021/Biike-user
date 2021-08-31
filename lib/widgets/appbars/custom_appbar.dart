import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This widget is the top appbar on home page
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? role;
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
      this.role,
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
    ShapeBorder? shapeBorder;
    Widget? leadingWidget;

    if (hasShape) {
      shapeBorder = RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)));
    }

    if (hasLeading) {
      leadingWidget = IconButton(
        onPressed: () {
          if (actionWidgets != null) {
            if (role == 'Customer') {
              Get.offAllNamed('/customerHome');
            } else {
              Get.offAllNamed('/driverHome');
            }
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
        leading: leadingWidget,
        title: title,
        actions: actionWidgets,
        bottom: bottomAppBar,
        shape: shapeBorder,
      ),
    );
  }
}
