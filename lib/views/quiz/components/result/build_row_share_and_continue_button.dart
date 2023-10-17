import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/models/tour/tour_mode.dart';
import 'package:museo/views/tour/tour_view.dart';

class BuildRowShareAndContinueButton extends StatelessWidget {
  const BuildRowShareAndContinueButton({
    super.key,
    required this.tourMode,
  });

  final TourMode tourMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Share icon
        ElevatedButton(
          // TODO -> Share by what? Twitter? Share the points and image?
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: mainBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(
                color: mainGray,
              ),
            ),
          ),
          child: const Icon(
            Icons.share_outlined,
            color: Colors.white,
          ),
        ),
        // Continue button
        ElevatedButton(
          // TODO Going back to the page waiting for some beacon
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TourView(
                  tourMode: tourMode, // TODO -> Uncomment line
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: mainBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(
                color: mainGray,
              ),
            ),
          ),
          child: const Text(
            'Continuar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
