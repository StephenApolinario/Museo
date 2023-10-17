import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/models/beacon/beacons.dart';

// A explanation of how beacons/tours/quizzes works are inside the models/beacon/beacons.dart
class Quiz implements Beacon {
  final String title, beaconUUID;
  final int rssi;
  final List<Question> questions;
  final Color color;
  late bool isCompleted;
  late int score;

  Quiz({
    required this.beaconUUID,
    this.isCompleted = false,
    this.score = 0,
    required this.rssi,
    required this.title,
    required this.questions,
    required this.color,
  });
}

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

// All the lines above are just examples. The original should be retrive from API.
final List<Question> fakeRedQuizQuestions = [
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

final List<Question> fakeBlueQuizQuestions = [
  Question(
    text: 'How much is 16 + 16?',
    color: mainBlue,
    options: [
      Option(awnser: '30', isCorrect: false),
      Option(awnser: '32', isCorrect: true),
      Option(awnser: '16', isCorrect: false),
    ],
  ),
  Question(
    text: 'How much is 40 + 44?',
    color: mainBlue,
    options: [
      Option(awnser: '40', isCorrect: false),
      Option(awnser: '84', isCorrect: true),
      Option(awnser: '260', isCorrect: false),
    ],
  ),
];
