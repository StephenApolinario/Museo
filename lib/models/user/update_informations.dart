import 'package:flutter/material.dart';

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
    UpdateInformationTitle(
      title: 'Personal Data', // TODO -> MUST be provided by L10N
    ),
    UpdateInformationTitle(
      title: 'Address Data', // TODO -> MUST be provided by L10N
    ),
  ];
}
