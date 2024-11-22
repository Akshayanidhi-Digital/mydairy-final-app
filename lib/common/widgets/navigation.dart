import 'package:flutter/material.dart';

import 'message.dart';

final _ctx = Keys.navigatorKey().currentState!;

_material(Widget widget) {
  return CustomPageTransition(page: widget);
  // return MaterialPageRoute(builder: (context) => widget);
}

//! Routing => ....
navigationPop() => _ctx.pop();
navigationTo(Widget widget) => _ctx.push(_material(widget));
navigationRemoveUntil(Widget widget) =>
    _ctx.pushAndRemoveUntil(_material(widget), (Route route) => false);

// navigationToReplacement(Widget widget) => _ctx!.pushReplacement(_material(widget));
// ! Animation router
class CustomPageTransition extends PageRouteBuilder {
  final Widget page;

  CustomPageTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
}
