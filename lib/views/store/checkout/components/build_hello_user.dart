import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/gen/assets.gen.dart';
import 'package:museo/providers/user/user.dart';
import 'package:provider/provider.dart';

class BuildHelloUser extends StatelessWidget {
  const BuildHelloUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          UserMessage(),
          UserImage(),
        ],
      ),
    );
  }
}

class UserMessage extends StatelessWidget {
  const UserMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(left: 65),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: mainBlue,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, right: 5, left: 20),
                child: Text(
                  '${context.loc.hello}, ${userProvider.loggedUser.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);

    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.shade800,
          width: 2,
        ),
        image: DecorationImage(
          //TODO: In future, when the user upload an image, you must change this code.
          image:
              userProvider.loggedUser.picture != 'https://www.nopicture.com.br/'
                  ? NetworkImage(userProvider.loggedUser.picture)
                  : AssetImage(Assets.user.defaultProfilePicture.path)
                      as ImageProvider,

          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
