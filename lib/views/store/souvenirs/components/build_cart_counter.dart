import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/views/store/components/build_outilned_button.dart';

class BuildCartCounter extends StatefulWidget {
  const BuildCartCounter({super.key});

  @override
  State<BuildCartCounter> createState() => _BuildCartCounterState();
}

class _BuildCartCounterState extends State<BuildCartCounter> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildOutlinedButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            numOfItems.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: grayStoreColor,
              fontSize: 20,
            ),
          ),
        ),
        buildOutlinedButton(
          icon: Icons.add,
          press: () {
            setState(() {
              numOfItems++;
            });
          },
        ),
      ],
    );
  }
}
