import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/models/quizz/quiz.dart';

class BuildQuizTitle extends StatelessWidget {
  const BuildQuizTitle({
    super.key,
    required this.quiz,
  });

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // TODO This color must be provided by an API
        color: mainBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 16),
        child: Text(
          // TODO This title must be provided by an API
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
