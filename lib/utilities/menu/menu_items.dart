import 'package:flutter/material.dart';

typedef Tap<T> = Function();

ListTile menuItem({
  required BuildContext context,
  required IconData icon,
  required String title,
  String? route,
  Tap? onTapAction,
}) {
  return ListTile(
    textColor: Colors.white,
    iconColor: Colors.white,
    leading: Icon(icon),
    title: Text(title),
    onTap: () {
      if (onTapAction != null) {
        onTapAction();
      } else if (route != null) {
        Navigator.pop(context);
        Navigator.of(context).pushNamed(route);
      }
    },
  );
}
