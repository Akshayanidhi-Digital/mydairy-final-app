import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? elevation;
  final bool? boolLeading, centerTitle, actions, lead;
  final Widget? leading, titleWidget;
  final PreferredSizeWidget? bottom;
  final String title;
  final List<Widget>? actionList;
  final Color? bgColor, txtColor;
  final AppBar appBar = AppBar();
  BaseAppBar(
      {super.key,
      this.boolLeading,
      this.elevation,
      this.actions,
      this.leading,
      this.bottom,
      this.lead = false,
      this.centerTitle,
      required this.title,
      this.titleWidget,
      this.bgColor,
      this.txtColor,
      this.actionList});

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 5.0,
      foregroundColor: AppColor.whiteClr,
      backgroundColor: bgColor ?? AppColor.appColor,
      elevation: elevation,
      automaticallyImplyLeading: boolLeading ?? true,
      // leading: leading,
      leading: lead == false
          ? GestureDetector(
              onTap: () => navigationPop(),
              child: Icon(
                Icons.arrow_back,
                size: 26.sp,
              ))
          : leading,
      title: titleWidget ??
          Text(
            title.tr(),
            style: TextStyle(
              color: txtColor ?? AppColor.whiteClr,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
      centerTitle: centerTitle ?? false,
      actions: actionList,
      bottom: bottom,
    );
  }
}
