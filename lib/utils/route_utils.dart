import 'package:flutter/material.dart';

Future toNext(context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (_) => widget));

class GlobalContext {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext context = navigatorKey.currentState!.context;
}
