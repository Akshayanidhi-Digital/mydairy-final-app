import 'dart:async';

import 'package:flutter/material.dart';

import '../../export.dart';
import 'respond.dart';

Future noInernet() async {
  return snackBarMessage(
      msg: Msg.noInternet, color: Colors.cyan, txtcolor: AppColor.blackClr);
}

snackBarMessage({required String msg, Color? color, Color? txtcolor}) {
  Keys.scaffoldkey().currentState!.showSnackBar(SnackBar(
        dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(bottom: 10.0.h, right: 20.w, left: 20.w),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColor.whiteClr),
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Text(" $msg",
            style: TextStyle(
                color: txtcolor ?? AppColor.whiteClr,
                fontFamily: "Roboto",
                fontSize: 15.w)),
        backgroundColor: color ?? AppColor.blackClr,
      ));
  Future.delayed(const Duration(seconds: 3), () {
    Keys.scaffoldkey().currentState?.clearSnackBars();
  });
}

errorSnacMsg(Respond response) {
  return snackBarMessage(msg: response.message!);
}

successMsg(Respond response) {
  return snackBarMessage(msg: response.message!, color: AppColor.greenClr);
}

Widget noDataFound() {
  return Center(
      child: Text("No data found",
          style: TextStyle(color: AppColor.appColor, fontSize: 16.sp)));
}

Widget emptyList() {
  return Center(
      child: Text("No data",
          style: TextStyle(color: AppColor.appColor, fontSize: 16.sp)));
}

class Keys {
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<NavigatorState> navigatorKey() {
    return _navigatorKey;
  }

  static GlobalKey<ScaffoldMessengerState> scaffoldkey() {
    return _scaffoldMessengerKey;
  }
}
