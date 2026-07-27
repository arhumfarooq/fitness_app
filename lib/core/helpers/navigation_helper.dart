import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationHelper {
  static void go(BuildContext context, String route) {
    context.go(route);
  }

  static void push(BuildContext context, String route) {
    context.push(route);
  }

  static void pop(BuildContext context) {
    if (context.canPop()) context.pop();
  }

  static void replace(BuildContext context, String route) {
    context.pushReplacement(route);
  }
}
