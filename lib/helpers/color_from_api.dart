import 'dart:ui';

import 'package:museo/constants/colors.dart';

// Color colorFromApi({required String color}) {
//   return Color(int.parse(color.substring(0, 6), radix: 16) + 0xFF000000);
// }

Color colorFromApi({required String color}) {
  if (color.isEmpty || color.length < 6) {
    return mainBlue; // Return a default color in case of an error.
  }
  return Color(int.parse(color.substring(0, 6), radix: 16) + 0xFF000000);
}
