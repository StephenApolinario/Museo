import 'package:museo/models/beacon/beacons.dart';
import 'package:museo/models/quizz/quiz.dart';

class Emblem {
  final String title, imagePath;
  final int minPoints, maxPoints;
  final Quiz quiz;

  Emblem({
    required this.title,
    required this.imagePath,
    required this.maxPoints,
    required this.minPoints,
    required this.quiz,
  });
}

// All the lines above are just examples. The original should be retrive from API.
List<Emblem> fakeEmblemsData = [
  Emblem(
    title: 'Emblema de ouro',
    imagePath:
        'https://e7.pngegg.com/pngimages/207/884/png-clipart-gold-medal-silver-medal-bronze-medal-realistic-gold-medal-gold-coin-medal.png',
    maxPoints: 1000,
    minPoints: 800,
    quiz: fakeDetailedTourDataQuizzes[0],
  ),
  Emblem(
    title: 'Emblema de prata',
    imagePath:
        'https://e7.pngegg.com/pngimages/723/149/png-clipart-gold-medal-gold-medal-illustration-silver-brand-painted-hand.png',
    maxPoints: 1000,
    minPoints: 800,
    quiz: fakeDetailedTourDataQuizzes[0],
  ),
  Emblem(
    title: 'Emblema de bronze',
    imagePath:
        'https://e7.pngegg.com/pngimages/919/532/png-clipart-bronze-medal-bronze-medal-gold-medal-medal-medal-gold.png',
    maxPoints: 1000,
    minPoints: 800,
    quiz: fakeDetailedTourDataQuizzes[0],
  ),
  Emblem(
    title: 'Emblema de ouro',
    imagePath:
        'https://e7.pngegg.com/pngimages/207/884/png-clipart-gold-medal-silver-medal-bronze-medal-realistic-gold-medal-gold-coin-medal.png',
    maxPoints: 1000,
    minPoints: 800,
    quiz: fakeDetailedTourDataQuizzes[1],
  ),
  Emblem(
    title: 'Emblema de prata',
    imagePath:
        'https://e7.pngegg.com/pngimages/723/149/png-clipart-gold-medal-gold-medal-illustration-silver-brand-painted-hand.png',
    maxPoints: 1000,
    minPoints: 800,
    quiz: fakeDetailedTourDataQuizzes[1],
  ),
  Emblem(
    title: 'Emblema de bronze',
    imagePath:
        'https://e7.pngegg.com/pngimages/919/532/png-clipart-bronze-medal-bronze-medal-gold-medal-medal-medal-gold.png',
    maxPoints: 1000,
    minPoints: 800,
    quiz: fakeDetailedTourDataQuizzes[1],
  ),
];

// TODO:  Emblems data should be given by API.
List<Emblem> fakeUserEmblemsData = [
  fakeEmblemsData[0],
  fakeEmblemsData[5],
];
