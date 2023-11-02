import 'package:flutter/material.dart';
import 'package:museo/helpers/color_from_api.dart';
import 'package:museo/models/quiz.dart';

class BuildQuizTitle extends StatelessWidget {
  const BuildQuizTitle({
    super.key,
    required this.quiz,
  });

  final NewQuiz quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorFromApi(color: quiz.color),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 16),
        child: Text(
          quiz.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
