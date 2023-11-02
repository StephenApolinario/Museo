import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/gen/assets.gen.dart';
import 'package:museo/providers/user/user.dart';
import 'package:provider/provider.dart';

class BuildTopProfileInformations extends StatelessWidget {
  const BuildTopProfileInformations({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        profilePicture(context),
        const SizedBox(height: 10),
        profileName(context),
      ],
    );
  }

  Widget profilePicture(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: SizedBox(
          width: 100.0,
          height: 100.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              //TODO: In future, when the user upload an image, you must change this code.
              image: userProvider.loggedUser.picture !=
                      'https://www.nopicture.com.br/'
                  ? NetworkImage(userProvider.loggedUser.picture)
                  : AssetImage(Assets.user.defaultProfilePicture.path)
                      as ImageProvider,
            ),
          ),
        ),
      ),
    );
  }

  Widget profileName(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: true);

    return Center(
      child: Column(
        children: [
          Text(
            userProvider.loggedUser.name,
            style: const TextStyle(
              fontSize: 20,
              color: mainBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            userProvider.loggedUser.lastName,
            style: const TextStyle(
              fontSize: 16,
              color: mainBlue,
            ),
          ),
        ],
      ),
    );
  }
}
