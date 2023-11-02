import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';

class RegisteringTitleSubtitle {
  final String title, subtitle;

  RegisteringTitleSubtitle({
    required this.title,
    required this.subtitle,
  });
}

List<RegisteringTitleSubtitle> createRegisteringSteps({
  required BuildContext context,
}) {
  return [
    RegisteringTitleSubtitle(
      title: context.loc.registering_content_title,
      subtitle: context.loc.registering_personal_data_content_subtitle,
    ),
    RegisteringTitleSubtitle(
      title: context.loc.registering_content_title,
      subtitle: context.loc.registering_address_data_content_subtitle,
    ),
    RegisteringTitleSubtitle(
      title: context.loc.registering_content_title,
      subtitle: context.loc.registering_password,
    ),
  ];
}
