import 'package:flutter/material.dart';
import 'package:museo/helpers/aes_encrypt.dart';
import 'package:museo/models/quiz.dart';
import 'package:museo/services/endpoints.dart';
import 'package:museo/services/user_service.dart';
import 'package:http/http.dart' as http;

class QuizService {
  Future sendPerformanceByAES(
    BuildContext context,
    NewQuiz quiz,
    int score,
  ) async {
    final int quizzResult = ((score / quiz.questions.length) * 100).round();
    String jsonString = '{"quiz": "${quiz.id}","score": $quizzResult}';

    final hash = aesCrypt(jsonString);

    final response = await http.get(
      Api().quiz(endpoint: 'performance/$hash'),
      headers: userJwt(context),
    );

    if (response.statusCode != 200) {
      return null;
    }

    if (context.mounted) {
      await UserService().updateInformationUser(context);
    }
  }
}
