import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

/// This widget is the app bar on home page
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingWidget;
  final Widget? title;
  final AppBar appBar;

  /// Widgets for 'action' property in [AppBar]
  final List<Widget>? actionWidgets;

  const CustomAppBar(
      {Key? key,
      this.leadingWidget,
      this.title,
      required this.appBar,
      this.actionWidgets})
      : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leadingWidget,
      title: title,
      backgroundColor: CustomColors.blue,
      foregroundColor: Colors.white,
      actions: actionWidgets,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))),
    );
  }
}
