import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

/// This widget is the top appbar on home page
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Widgets for leading property in [AppBar]
  final Widget? leadingWidget;
  final Widget? title;
  final AppBar appBar;
  final bool isVisible;

  /// Widgets for action property in [AppBar]
  final List<Widget>? actionWidgets;
  final PreferredSizeWidget? bottomAppBar;

  const CustomAppBar(
      {Key? key,
      required this.isVisible,
      this.leadingWidget,
      this.title,
      required this.appBar,
      this.actionWidgets,
      this.bottomAppBar})
      : super(key: key);

  @override
  Size get preferredSize =>
      new Size.fromHeight(appBar.preferredSize.height + 40.0);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: AppBar(
        leading: leadingWidget,
        title: title,
        backgroundColor: CustomColors.kBlue,
        foregroundColor: Colors.white,
        actions: actionWidgets,
        bottom: bottomAppBar,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))),
      ),
    );
  }
}
