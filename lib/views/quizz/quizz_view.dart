import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/views/quizz/quizz_result_view.dart';

class Question {
  final String text;
  final Color color;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    required this.color,
    this.isLocked = false,
    this.selectedOption,
  });
}

class Option {
  final String awnser;
  final bool isCorrect;

  Option({
    required this.awnser,
    required this.isCorrect,
  });
}

final List<Question> fakeQuestions = [
  Question(
    text: 'How much is 2 + 2?',
    color: mainBlue,
    options: [
      Option(awnser: '3', isCorrect: false),
      Option(awnser: '4', isCorrect: true),
      Option(awnser: '1', isCorrect: false),
    ],
  ),
  Question(
    text: 'How much is 4 + 4?',
    color: mainBlue,
    options: [
      Option(awnser: '4', isCorrect: false),
      Option(awnser: '8', isCorrect: true),
      Option(awnser: '26', isCorrect: false),
    ],
  ),
];

class QuizzView extends StatefulWidget {
  final String tourMode;
  const QuizzView({
    super.key,
    required this.tourMode,
  });

  @override
  State<QuizzView> createState() => _QuizzViewState();
}

class _QuizzViewState extends State<QuizzView> {
  late PageController _controller;
  int _questionNumber = 1;
  int _score = 0;
  bool _isLocked = false;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QUIZZ'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title on top
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // TODO This color must be provided by an API
              color: mainBlue,
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 16),
              child: Text(
                // TODO This title must be provided by an API
                'Ala Azul',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          // Question number / Questions length (1/2 ~~ 2/10)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16),
            // TODO This strings must be provided by an API
            child: Text(
              'Pergunta $_questionNumber/${fakeQuestions.length}',
              style: const TextStyle(
                color: mainBlue,
                fontSize: 22,
              ),
            ),
          ),
          // Build the quizz with the question and awnsers options
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: PageView.builder(
                itemCount: fakeQuestions.length,
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final question = fakeQuestions[index];
                  return buildQuestion(question);
                },
              ),
            ),
          ),
          // Button on the bottom (Continue or View Result)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedOpacity(
                  opacity: _isLocked ? 1.0 : 0,
                  duration: _isLocked
                      ? const Duration(milliseconds: 500)
                      : Duration.zero,
                  curve: Curves.easeInOut,
                  child: buildElevatedButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildQuestion(Question question) {
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
          child: OptionsWidget(
            question: question,
            onClickedOption: (option) {
              if (question.isLocked) {
                return;
              } else {
                setState(() {
                  question.isLocked = true;
                  question.selectedOption = option;
                });
                _isLocked = question.isLocked;
                if (question.selectedOption!.isCorrect) {
                  _score++;
                }
              }
            },
          ),
        )
      ],
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        if (_questionNumber < fakeQuestions.length) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInExpo,
          );

          setState(() {
            _questionNumber++;
            _isLocked = false;
          });
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                tourMode: widget.tourMode,
                score: _score,
                questions: fakeQuestions,
              ),
            ),
          );
        }
      },
      child: Text(
        _questionNumber < fakeQuestions.length ? 'Next Page' : 'See the result',
      ),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionsWidget({
    super.key,
    required this.question,
    required this.onClickedOption,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: question.options
              .map((option) => buildOption(context, option))
              .toList(),
        ),
      );

  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                option.awnser,
                style: const TextStyle(fontSize: 20),
              ),
              getIconForOption(option, question),
            ],
          ),
        ),
      ),
    );
  }

  Color getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect ? Colors.green : Colors.red;
      } else if (option.isCorrect) {
        return Colors.green;
      }
    }
    return mainBlue;
  }

  Widget getIconForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.cancel, color: Colors.red);
      } else if (option.isCorrect) {
        return const Icon(Icons.check_circle, color: Colors.green);
      }
    }
    return const SizedBox.shrink();
  }
}
