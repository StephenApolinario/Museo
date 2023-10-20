import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';

class BuildTopProfileInformations extends StatelessWidget {
  const BuildTopProfileInformations({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        profilePicture(),
        const SizedBox(height: 10),
        profileName(),
      ],
    );
  }

  Widget profilePicture() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: SizedBox(
          width: 100.0,
          height: 100.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: const Image(
              image: NetworkImage(
                  // TODO:  This MUST be provided by API.
                  'https://i.pinimg.com/564x/97/aa/84/97aa847d061a14894178805f1d551500.jpg'),
            ),
          ),
        ),
      ),
    );
  }

  Widget profileName() {
    return const Center(
      child: Column(
        children: [
          Text(
            'Stephen', // TODO:  This MUST be provided by API.
            style: TextStyle(
              fontSize: 20,
              color: mainBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Michael Apolinário', // TODO:  This MUST be provided by API.
            style: TextStyle(
              fontSize: 16,
              color: mainBlue,
            ),
          ),
        ],
      ),
    );
  }
}
