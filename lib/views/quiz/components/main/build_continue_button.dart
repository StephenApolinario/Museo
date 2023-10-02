import 'package:flutter/material.dart';
import 'package:museo/views/quiz/quiz_result_view.dart';
import 'package:museo/views/quiz/quiz_view.dart' show Quiz;

class BuildContinueButton extends StatelessWidget {
  final PageController controller;
  final BuildContext context;
  final Quiz quiz;
  final Function increaseQuestionNumber;
  final int questionNumber, score;
  final String tourMode;

  const BuildContinueButton({
    super.key,
    required this.quiz,
    required this.questionNumber,
    required this.controller,
    required this.context,
    required this.score,
    required this.tourMode,
    required this.increaseQuestionNumber,
  });

  @override
  Widget build(BuildContext context) {
    bool isLocked = quiz.questions[questionNumber].isLocked;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedOpacity(
            opacity: isLocked ? 1.0 : 0,
            duration:
                isLocked ? const Duration(milliseconds: 500) : Duration.zero,
            curve: Curves.easeInOut,
            child: buildElevatedButton(
              increaseQuestionNumber: increaseQuestionNumber,
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton buildElevatedButton({
    required Function increaseQuestionNumber,
  }) {
    return ElevatedButton(
      onPressed: () {
        if (questionNumber + 1 < quiz.questions.length) {
          controller.nextPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInExpo,
          );
          increaseQuestionNumber();
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                tourMode: tourMode,
                score: score,
                questions: quiz.questions,
              ),
            ),
          );
        }
      },
      child: Text(
        questionNumber < quiz.questions.length ? 'Next Page' : 'See the result',
      ),
    );
  }
}
