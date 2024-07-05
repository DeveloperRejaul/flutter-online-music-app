import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Nav {
  static void push(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: page,
      ),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static void replace(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: page,
      ),
      (route) => false,
    );
  }
}
