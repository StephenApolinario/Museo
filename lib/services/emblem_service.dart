import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:museo/services/endpoints.dart';

class EmblemService {
  Future getEmblemQuizTitle(BuildContext context, String quizID) async {
    var response = await http.get(
      Api().quiz(endpoint: quizID),
    );

    if (response.statusCode == 200) {
      final quiz = jsonDecode(response.body)['quiz'];
      return quiz['title'];
    }
  }
}
