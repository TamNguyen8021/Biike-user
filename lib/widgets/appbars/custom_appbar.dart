import 'package:flutter/material.dart';

/// This widget is the top appbar on home page
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Widgets for leading property in [AppBar]
  final Widget? leadingWidget;
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
      this.leadingWidget,
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
    if (hasShape) {
      shapeBorder = RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)));
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
