import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/models/quizz/quiz.dart';

class BuildQuestionCount extends StatelessWidget {
  const BuildQuestionCount({
    super.key,
    required int questionNumber,
    required this.quiz,
  }) : _questionNumber = questionNumber;

  final int _questionNumber;
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16),
      // TODO This strings must be provided by an API
      child: Text(
        'Pergunta $_questionNumber/${quiz.questions.length}',
        style: const TextStyle(
          color: mainBlue,
          fontSize: 22,
        ),
      ),
    );
  }
}
