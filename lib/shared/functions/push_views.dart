import 'package:flutter/material.dart';

Future<T?>? pushView<T>(BuildContext context, String route, {dynamic arguments}) {
  return Navigator.pushNamed<T>(context, route);
}

Future<T?>? pushUntilView<T>(BuildContext context, String name,
    {dynamic arguments, bool Function(Route<dynamic>)? route}) {
  return Navigator.pushNamedAndRemoveUntil(context, name, route ?? (route) => false,
      arguments: arguments);
}

void closeView<T>(BuildContext context, {T? result}) {
  return Navigator.pop(context, result);
}

Future<T?>? closePushView<T, TO>(BuildContext context, String route,
    {dynamic result, dynamic arguments}) {
  return Navigator.popAndPushNamed<T, TO>(context, route,
      result: result, arguments: arguments);
}

Future<T?>? pushReplacementView<T, TO>(BuildContext context, String route,
    {dynamic result, dynamic arguments}) {
  return Navigator.pushReplacementNamed<T, TO>(context, route,
      result: result, arguments: arguments);
}
