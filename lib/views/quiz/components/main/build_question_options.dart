import 'package:flutter/material.dart';
import 'package:museo/models/quizz/quiz.dart';
import 'package:museo/views/quiz/components/main/build_question.dart';

class QuestionWithOptions extends StatelessWidget {
  final Quiz quiz;
  final PageController controller;
  final Function() increaseScore;
  final Function updateParent;

  const QuestionWithOptions({
    super.key,
    required this.quiz,
    required this.controller,
    required this.increaseScore,
    required this.updateParent,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: PageView.builder(
          itemCount: quiz.questions.length,
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final question = quiz.questions[index];
            return BuildQuestion(
              updateParent: updateParent,
              question: question,
              increaseScore: increaseScore,
            );
          },
        ),
      ),
    );
  }
}
