import 'dart:async';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

switchButton(
    {bool positive = false,
    FutureOr<void> Function(TapProperties<bool>)? onTap}) {
  return CustomAnimatedToggleSwitch<bool>(
    current: positive,
    values: const [false, true],
    spacing: 0.0,
    indicatorSize: const Size.square(30.0),
    animationDuration: const Duration(milliseconds: 200),
    animationCurve: Curves.linear,
    // onChanged: onChanged, // (b) =>  positive = b,
    iconBuilder: (context, local, global) {
      return const SizedBox();
    },
    cursors: const ToggleCursors(defaultCursor: SystemMouseCursors.click),
    onTap: onTap, // (_) => setState(() => positive = !positive),
    iconsTappable: false,
    wrapperBuilder: (context, global, child) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              left: 10.0,
              right: 10.0,
              height: 20.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: positive == true ? AppColor.bluelightClr : AppColor.grey,
                
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                ),
              )),
          child,
        ],
      );
    },
    foregroundIndicatorBuilder: (context, global) {
      return SizedBox.fromSize(
        size: global.indicatorSize,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: positive == true ? AppColor.appColor : AppColor.whiteClr,
   
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 0.05,
                  blurRadius: 1.1,
                  offset: Offset(0.0, 0.8))
            ],
          ),
        ),
      );
    },
  );
}
