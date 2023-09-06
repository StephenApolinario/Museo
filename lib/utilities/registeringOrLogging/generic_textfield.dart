import 'package:flutter/material.dart';

Column commonTextField({
  required String hintTitle,
  Color textFieldColor = Colors.white,
  double fontSize = 16,
  Alignment alignment = Alignment.topLeft,
  String? hintText,
  bool suggestions = false,
  bool autocorrect = false,
  bool paddingTop = true,
  double textFieldPadding = 10,
  Color fillColor = Colors.white,
  double textFieldBorder = 5.0,
  TextInputType keyboardType = TextInputType.text,
}) {
  List<Widget> widgets = [];

  // Sizedbox on top.
  if (paddingTop) {
    widgets.add(const SizedBox(height: 20));
  }

  // Align Widget
  widgets.add(
    Align(
      alignment: alignment,
      child: Text(
        hintTitle,
        style: TextStyle(
          color: textFieldColor,
          fontSize: fontSize,
        ),
      ),
    ),
  );

  // Textfield
  widgets.add(
    TextField(
      enableSuggestions: suggestions,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      style: const TextStyle(
        fontSize: 12,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: textFieldPadding),
        fillColor: fillColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(textFieldBorder),
          ),
        ),
      ),
    ),
  );

  return Column(
    children: widgets,
  );
}
