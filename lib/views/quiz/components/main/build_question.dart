import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/models/quizz/quiz.dart';
import 'package:museo/views/quiz/components/main/build_options.dart';

class BuildQuestion extends StatefulWidget {
  final Question question;
  final Function() increaseScore;
  final Function updateParent;

  const BuildQuestion({
    super.key,
    required this.question,
    required this.increaseScore,
    required this.updateParent,
  });

  @override
  State<BuildQuestion> createState() => _BuildQuestionState();
}

class _BuildQuestionState extends State<BuildQuestion> {
  @override
  Widget build(BuildContext context) {
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
              // TODO This color must be provided by an API
              color: mainBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.question.text,
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
            question: widget.question,
            onClickedOption: (option) {
              if (widget.question.isLocked) {
                return;
              } else {
                setState(() {
                  widget.question.isLocked = true;
                  widget.question.selectedOption = option;
                });
                if (widget.question.selectedOption!.isCorrect) {
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
