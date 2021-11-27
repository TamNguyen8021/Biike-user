import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

/// This widget is the top appbar on [HomePage]
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasLeading;
  final Function() onPressedFunc;
  final Widget? title;
  final AppBar appBar;
  final bool isVisible;
  final bool hasShape;
  final color;

  /// Widgets for action property in [AppBar]
  final List<Widget>? actionWidgets;
  final PreferredSizeWidget? bottomAppBar;

  const CustomAppBar(
      {Key? key,
      required this.isVisible,
      required this.hasShape,
      required this.hasLeading,
      required this.onPressedFunc,
      this.title,
      this.color,
      required this.appBar,
      this.actionWidgets,
      this.bottomAppBar})
      : super(key: key);

  @override
  Size get preferredSize {
    Size appbarSize = Size.fromHeight(appBar.preferredSize.height);
    if (bottomAppBar != null) {
      appbarSize = Size.fromHeight(appBar.preferredSize.height + 40.0);
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
        onPressed: onPressedFunc,
        icon: Icon(
          Icons.arrow_back,
        ),
      );
    }
    // sửa lỗi giựt khi switch: vanlnt
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: isVisible
          ? AppBar(
              leading: _leadingWidget,
              title: title,
              actions: actionWidgets,
              bottom: bottomAppBar,
              shape: _shapeBorder,
              elevation: color != null ? 0 : 4,
              backgroundColor: color != null
                  ? color
                  : ModalRoute.of(context)!.settings.name ==
                              CommonRoutes.HOME &&
                          Biike.role.value == Role.biker
                      ? CustomColors.kOrange
                      : CustomColors.kBlue,
            )
          : SizedBox.shrink(),
    );
  }
}
