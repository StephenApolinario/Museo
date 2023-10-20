import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';

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
              child: const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 20),
                child: Text(
                  // TODO:  This string must be provided by L10N
                  // TODO:  The name of the user must be provided by an API
                  'Olá, Stephen',
                  style: TextStyle(
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
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.shade800,
          width: 2,
        ),
        image: const DecorationImage(
          // TODO:  This image must be provided by API
          image: NetworkImage(
              'https://media.istockphoto.com/id/1223671392/vector/default-profile-picture-avatar-photo-placeholder-vector-illustration.jpg?s=612x612&w=0&k=20&c=s0aTdmT5aU6b8ot7VKm11DeID6NctRCpB755rA1BIP0='),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
