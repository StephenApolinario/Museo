import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/quiz.dart';
import 'package:museo/models/tour_mode.dart';
import 'package:museo/views/quiz/components/main/build_question_options.dart';
import 'package:museo/views/quiz/components/main/build_continue_button.dart';
import 'package:museo/views/quiz/components/main/build_question_count.dart';
import 'package:museo/views/quiz/components/main/build_quizz_title.dart';

class QuizView extends StatefulWidget {
  final TourMode tourMode;
  final NewQuiz quiz;

  const QuizView({
    super.key,
    required this.tourMode,
    required this.quiz,
  });

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
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
        title: Text(context.loc.quiz_title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildQuizTitle(quiz: widget.quiz),
          BuildQuestionCount(
            questionNumber: _questionNumber,
            quiz: widget.quiz,
          ),
          QuestionWithOptions(
            updateParent: _updateParent,
            quiz: widget.quiz,
            controller: _controller,
            increaseScore: _increaseScore,
          ),
          BuildContinueButton(
            context: context,
            quiz: widget.quiz,
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
