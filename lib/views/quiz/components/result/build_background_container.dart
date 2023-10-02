import 'package:flutter/material.dart';

class BuildBackgroundContainer extends StatelessWidget {
  const BuildBackgroundContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/quizz/crystals.png',
          height: 120,
        ),
      ],
    );
  }
}
