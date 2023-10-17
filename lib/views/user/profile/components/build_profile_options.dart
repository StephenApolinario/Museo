import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/constants/routes.dart' as routes;
import 'package:museo/constants/routes.dart';

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
        logout(),
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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.key_sharp),
                      SizedBox(width: 10),
                      // TODO -> MUST be provided by L10N
                      Text('Change Password'),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_sharp,
                color: mainBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logout() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 30),
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () => print('ok'), // TODO -> Complete the API Logout.
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Colors.red),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ), // TODO -> MUST be provided by L10N
                    ],
                  ),
                ],
              ),
              Icon(
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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_box_rounded),
                      SizedBox(width: 10),
                      // TODO -> MUST be provided by L10N
                      Text('Change Information'),
                    ],
                  ),
                ],
              ),
              Icon(
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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 10),
                      Text('Favorites'), // TODO -> MUST be provided by L10N
                    ],
                  ),
                ],
              ),
              Icon(
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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star_border),
                      SizedBox(width: 10),
                      // TODO -> MUST be provided by L10N
                      Text('Quizzes Emblems'),
                    ],
                  ),
                ],
              ),
              Icon(
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
