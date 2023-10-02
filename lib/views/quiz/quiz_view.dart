import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/views/quiz/components/main/build_question_options.dart';
import 'package:museo/views/quiz/components/main/build_continue_button.dart';
import 'package:museo/views/quiz/components/main/build_question_count.dart';
import 'package:museo/views/quiz/components/main/build_quizz_title.dart';

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

class Quiz {
  final String title;
  final List<Question> questions;

  Quiz({
    required this.title,
    required this.questions,
  });
}

class QuizView extends StatefulWidget {
  final String tourMode;
  const QuizView({
    super.key,
    required this.tourMode,
  });

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
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
  late final Quiz fakeQuiz = Quiz(title: 'Ala Azul', questions: fakeQuestions);
  late PageController _controller;
  int _questionNumber = 1;
  int _score = 0;

  void _increaseScore() {
    setState(() {
      _score++;
    });
  }

  void _updateParent() {
    setState(() {});
  }

  void _increaseQuestionNumber() {
    setState(() {
      _questionNumber++;
    });
  }

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
        // TODO Title from context.loc
        title: const Text('QUIZ'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildQuizTitle(quiz: fakeQuiz),
          BuildQuestionCount(questionNumber: _questionNumber, quiz: fakeQuiz),
          QuestionWithOptions(
            updateParent: _updateParent,
            quiz: fakeQuiz,
            controller: _controller,
            increaseScore: _increaseScore,
          ),
          BuildContinueButton(
            context: context,
            quiz: fakeQuiz,
            questionNumber: _questionNumber - 1,
            controller: _controller,
            score: _score,
            tourMode: widget.tourMode,
            increaseQuestionNumber: _increaseQuestionNumber,
          ),
        ],
      ),
    );
  }
}
