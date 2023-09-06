import 'package:flutter/material.dart';

ListTile menuItem({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String route,
}) {
  return ListTile(
    textColor: Colors.white,
    iconColor: Colors.white,
    leading: Icon(icon),
    title: Text(title),
    onTap: () {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(route);
    },
  );
}
