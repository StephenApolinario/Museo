import 'package:flutter/material.dart';
import 'package:museo/models/quiz.dart';
import 'package:museo/views/quiz/components/main/build_question.dart';

class QuestionWithOptions extends StatelessWidget {
  final NewQuiz quiz;
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
            return BuildQuestion(
              updateParent: updateParent,
              quiz: quiz,
              index: index,
              increaseScore: increaseScore,
            );
          },
        ),
      ),
    );
  }
}
