import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';

class UpdateInformationTitle {
  final String title;

  UpdateInformationTitle({
    required this.title,
  });
}

List<UpdateInformationTitle> createUpdateInformationSteps({
  required BuildContext context,
}) {
  return [
    UpdateInformationTitle(title: context.loc.personal_data),
    UpdateInformationTitle(title: context.loc.address_data),
  ];
}
