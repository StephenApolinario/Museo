import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/quiz.dart';
import 'package:museo/models/tour_mode.dart';
import 'package:museo/services/quiz_service.dart';
import 'package:museo/views/quiz/quiz_result_view.dart';

class BuildContinueButton extends StatelessWidget {
  final PageController controller;
  final BuildContext context;
  final NewQuiz quiz;
  final Function increaseQuestionNumber;
  final int questionNumber, score;
  final TourMode tourMode;

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
      onPressed: () async {
        if (questionNumber + 1 < quiz.questions.length) {
          controller.nextPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInExpo,
          );
          increaseQuestionNumber();
        } else {
          // Now, its time to send data to the API.

          await QuizService().sendPerformanceByAES(context, quiz, score);
          if (context.mounted) {
            quiz.isCompleted = true;
            quiz.score = score;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(
                  tourMode: tourMode,
                  quiz: quiz,
                ),
              ),
            );
          }
        }
      },
      child: Text(
        questionNumber < quiz.questions.length
            ? context.loc.next_question
            : context.loc.see_quiz_result,
      ),
    );
  }
}
