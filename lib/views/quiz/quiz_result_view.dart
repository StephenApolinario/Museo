import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museo/views/quiz/components/result/build_background_container.dart';
import 'package:museo/views/quiz/components/result/build_result_container.dart';
import 'package:museo/views/quiz/components/result/build_row_share_and_continue_button.dart';
import 'package:museo/views/quiz/quiz_view.dart' show Question;

class ResultPage extends StatelessWidget {
  final int score;
  final List<Question> questions;
  final String tourMode;

  const ResultPage({
    super.key,
    required this.score,
    required this.questions,
    required this.tourMode,
  });

  @override
  Widget build(BuildContext context) {
    final int quizzResult = ((score / questions.length) * 100).round();

    return Scaffold(
      // TODO This color/image must be provided by an API
      backgroundColor: const Color.fromARGB(255, 107, 13, 13),
      appBar: AppBar(
        // TODO This color must be provided by l10n
        title: const Text('Resultado do seu quiz!'),
      ),
      body: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              // TODO This must be provided by an API
              'assets/quizz/dots.svg',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  // TODO This must be provided by an API
                  const ResultTitle(title: 'VOCÊ COMPLETOU A ALA VERMELHA!'),
                  const SizedBox(height: 150),
                  MiddleContainer(quizzResult: quizzResult, tourMode: tourMode),
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
    required this.quizzResult,
    required this.tourMode,
  });

  final int quizzResult;
  final String tourMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Stack(
                children: [
                  BuildResultContainer(quizzResult: quizzResult),
                  const BuildBackgroundContainer(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
