import 'package:flutter/material.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  Color fromHex() {
    String hexColor = replaceAll('#', '');

    RegExp hexRegex = RegExp(r'^([0-9a-fA-F]{6}|[0-9a-fA-F]{8})$');

    if (!hexRegex.hasMatch(hexColor)) {
      return Colors.black;
    }

    int parsedColor = int.parse(hexColor, radix: 16);

    return Color(parsedColor);
  }
}
