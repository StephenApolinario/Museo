import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/utilities/dialogs/generic_dialog.dart';

Future<bool> showStartDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: context.loc.start_dialog_title,
    content: context.loc.start_dialog_content,
    optionsBuilder: () => {
      context.loc.start_dialog_option_no: false,
      context.loc.start_dialog_option_yes: true,
    },
  ).then((value) => value);
}
