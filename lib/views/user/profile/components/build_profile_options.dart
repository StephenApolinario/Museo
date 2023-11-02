import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/constants/routes.dart' as routes;
import 'package:museo/constants/routes.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/services/user_service.dart';

class BuildProfileOptions extends StatelessWidget {
  const BuildProfileOptions({
    super.key,
    required BuildContext context,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        favorites(context: context),
        quizzesEmblems(context: context),
        updateInformation(context: context),
        updatePassword(context: context),
        logout(context),
      ],
    );
  }

  Widget updatePassword({
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () => Navigator.of(context).pushNamed(
          routes.userUpdatePassword,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: mainBlue),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.key_sharp),
                      const SizedBox(width: 10),
                      Text(context.loc.update_password),
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_sharp,
                color: mainBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 30),
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () {
          UserService().logout(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Colors.red),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        context.loc.logout,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget updateInformation({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () => Navigator.of(context).pushNamed(userUpdateInformation),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: mainBlue),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.account_box_rounded),
                      const SizedBox(width: 10),
                      Text(context.loc.update_information),
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_sharp,
                color: mainBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget favorites({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () => Navigator.of(context).pushNamed(routes.favorites),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: mainBlue),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.favorite_border),
                      const SizedBox(width: 10),
                      Text(context.loc.favorite_pieces),
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_sharp,
                color: mainBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  quizzesEmblems({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () => Navigator.of(context).pushNamed(quizzEmblems),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: mainBlue),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star_border),
                      const SizedBox(width: 10),
                      Text(context.loc.emblem_quizzes),
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_sharp,
                color: mainBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
