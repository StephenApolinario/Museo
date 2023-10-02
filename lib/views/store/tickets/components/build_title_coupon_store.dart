import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';

class BuildTitleCouponStore extends StatelessWidget {
  final String title;

  const BuildTitleCouponStore({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: mainBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 16),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
