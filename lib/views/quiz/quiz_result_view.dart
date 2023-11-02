import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/quiz.dart';
import 'package:museo/models/tour_mode.dart';
import 'package:museo/views/quiz/components/result/build_result_container.dart';
import 'package:museo/views/quiz/components/result/build_row_share_and_continue_button.dart';

class ResultPage extends StatelessWidget {
  final NewQuiz quiz;
  final TourMode tourMode;

  const ResultPage({
    super.key,
    required this.quiz,
    required this.tourMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO This color/image must be provided by an API ?
      backgroundColor: const Color.fromARGB(255, 107, 13, 13),
      appBar: AppBar(
        title: Text(context.loc.quiz_performance),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  ResultTitle(
                      title:
                          '${context.loc.completed_quiz} ${quiz.title.toLowerCase()}!'),
                  const SizedBox(height: 150),
                  MiddleContainer(quiz: quiz, tourMode: tourMode),
                  const SizedBox(height: 30),
                  BuildRowShareAndContinueButton(tourMode: tourMode)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultTitle extends StatelessWidget {
  final String title;

  const ResultTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    );
  }
}

class MiddleContainer extends StatelessWidget {
  const MiddleContainer({
    super.key,
    required this.quiz,
    required this.tourMode,
  });

  final NewQuiz quiz;
  final TourMode tourMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: BuildResultContainer(quiz: quiz),
        ),
      ],
    );
  }
}
