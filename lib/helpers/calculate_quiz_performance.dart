import 'package:flutter/material.dart';
import 'package:museo/providers/user/user.dart';
import 'package:provider/provider.dart';

// At the end of all the application's quizzes, the user receives a score.
// Every quiz must have a minimum score of 0 (0 correct Awnsers) and a maximum score of 100 (100% correct Awnsers).
// So, to calculate the user's performance, you need to loop through each quiz performance and calculate the average score.

class QuizPerformance {
  final String quiz;
  final int score;

  QuizPerformance({
    required this.quiz,
    required this.score,
  });
}

calculateQuizPerformance(BuildContext context) {
  final userProvider = Provider.of<User>(context, listen: true);
  final userProviderQuizPeformances = userProvider.loggedUser.quizPerformances;

  List<QuizPerformance> userPerformanceQuizzes =
      userProviderQuizPeformances.map((item) {
    return QuizPerformance(
      quiz: item['quiz'],
      score: item['score'],
    );
  }).toList();

  if (userPerformanceQuizzes.isEmpty) {
    return null;
  }

  final sumOfScores = userPerformanceQuizzes.fold(0, (previousValue, element) {
    return previousValue + element.score;
  });

  final userPerfomance = (sumOfScores / (userPerformanceQuizzes.length * 100));

  return userPerfomance;
}
