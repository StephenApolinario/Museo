import 'package:flutter/material.dart';
import 'package:museo/helpers/color_from_api.dart';
import 'package:museo/models/quiz.dart';
import 'package:museo/views/quiz/components/main/build_options.dart';

class BuildQuestion extends StatefulWidget {
  final NewQuiz quiz;
  final int index;
  final Function() increaseScore;
  final Function updateParent;

  const BuildQuestion({
    super.key,
    required this.index,
    required this.quiz,
    required this.increaseScore,
    required this.updateParent,
  });

  @override
  State<BuildQuestion> createState() => _BuildQuestionState();
}

class _BuildQuestionState extends State<BuildQuestion> {
  @override
  Widget build(BuildContext context) {
    final NewQuestion question = widget.quiz.questions[widget.index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question
        Center(
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 140,
              minWidth: 300,
            ),
            decoration: BoxDecoration(
              color: colorFromApi(color: widget.quiz.color),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    question.text,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        // Options
        Expanded(
          child: BuildOptions(
            question: question,
            onClickedOption: (option) {
              if (question.isLocked) {
                return;
              } else {
                setState(() {
                  question.isLocked = true;
                  question.selectedOption = option;
                });
                if (question.selectedOption!.isCorrect) {
                  widget.increaseScore();
                }
                widget.updateParent();
              }
            },
          ),
        )
      ],
    );
  }
}
