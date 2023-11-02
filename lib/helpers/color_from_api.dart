import 'dart:ui';

import 'package:museo/constants/colors.dart';

// Color colorFromApi({required String color}) {
//   return Color(int.parse(color.substring(0, 6), radix: 16) + 0xFF000000);
// }

Color colorFromApi({required String color}) {
  RegExp colorRegex = RegExp(r'^(?:[0-9a-fA-F]{3}){1,2}$');
  if (!colorRegex.hasMatch(color)) {
    return mainBlue; // Return a default color in case of an error.
  }
  return Color(int.parse(color.substring(0, 6), radix: 16) + 0xFF000000);
}
