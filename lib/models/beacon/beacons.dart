import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/models/quizz/quiz.dart';
import 'package:museo/models/tour/tour_piece.dart';

abstract class Beacon {}

// All the lines above are just examples. The original should be retrive from API.
final List<Beacon> fakeDetailedTourDataBeacons = [
  ...fakeDetailedTourDataPieces,
  ...fakeDetailedTourDataQuizzes,
];

final List<Beacon> fakeFastTourDataBeacons = [
  ...fakeFastTourDataPieces,
  ...fakeFastTourDataQuizzes,
];

final List<Beacon> fakeNormalTourDataBeacons = [
  ...fakeNormalTourDataPieces,
  ...fakeNormalTourDataQuizzes,
];

final List<TourPiece> fakeDetailedTourDataPieces = [
  TourPiece(
    beaconUUID: '',
    rssi: 40,
    color: Colors.blue,
    title: '1 - This title must be provided by an API',
    subtitle: '1 - This subtitle must be provided by an API',
    image: 'assets/univali.jpg',
    description:
        '1 - This text must be provided by an API\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla efficitur lectus vel lorem venenatis dignissim. Aenean nec nulla in enim interdum placerat sed tincidunt mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Integer fermentum vulputate hendrerit. Sed id convallis mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur semper, ex ac sagittis efficitur, neque est convallis mi, et rutrum nisl lorem a massa. Quisque ac magna non erat pellentesque interdum et eu nunc. Quisque iaculis urna quis lobortis volutpat. Nullam gravida odio sit amet felis molestie posuere. Vivamus mollis consequat erat, at egestas leo pulvinar in. Vivamus sagittis, dui vitae venenatis dapibus, risus sem efficitur lorem, ut fermentum dui orci vel justo.',
  ),
  TourPiece(
    beaconUUID: '',
    rssi: 40,
    color: Colors.blue,
    title: '2 - This title must be provided by an API',
    subtitle: '2 - This subtitle must be provided by an API',
    image: 'assets/univali_black_white.jpg',
    description:
        '2 - This text must be provided by an API\n Small text here! This text must be provided by an API\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla efficitur lectus vel lorem venenatis dignissim. Aenean nec nulla in enim interdum placerat sed tincidunt mi. ',
  ),
];

final List<Quiz> fakeDetailedTourDataQuizzes = [
  Quiz(
    beaconUUID: '',
    rssi: 40,
    title: 'Ala Vermelha',
    questions: fakeRedQuizQuestions,
    color: Colors.red,
  ),
  Quiz(
    beaconUUID: '',
    rssi: 40,
    title: 'Ala Azul',
    questions: fakeBlueQuizQuestions,
    color: mainBlue,
  )
];

final List<TourPiece> fakeFastTourDataPieces = [
  TourPiece(
    beaconUUID: '',
    rssi: 40,
    color: Colors.blue,
    title: '1 - This title must be provided by an API',
    subtitle: '1 - This subtitle must be provided by an API',
    image: 'assets/univali.jpg',
    description:
        '1 - This text must be provided by an API\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla efficitur lectus vel lorem venenatis dignissim. Aenean nec nulla in enim interdum placerat sed tincidunt mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Integer fermentum vulputate hendrerit. Sed id convallis mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur semper, ex ac sagittis efficitur, neque est convallis mi, et rutrum nisl lorem a massa. Quisque ac magna non erat pellentesque interdum et eu nunc. Quisque iaculis urna quis lobortis volutpat. Nullam gravida odio sit amet felis molestie posuere. Vivamus mollis consequat erat, at egestas leo pulvinar in. Vivamus sagittis, dui vitae venenatis dapibus, risus sem efficitur lorem, ut fermentum dui orci vel justo.',
  ),
  TourPiece(
    beaconUUID: '',
    rssi: 40,
    color: Colors.blue,
    title: '2 - This title must be provided by an API',
    subtitle: '2 - This subtitle must be provided by an API',
    image: 'assets/univali_black_white.jpg',
    description:
        '2 - This text must be provided by an API\n Small text here! This text must be provided by an API\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla efficitur lectus vel lorem venenatis dignissim. Aenean nec nulla in enim interdum placerat sed tincidunt mi. ',
  ),
];

final List<Quiz> fakeFastTourDataQuizzes = [
  Quiz(
    beaconUUID: '',
    rssi: 40,
    title: 'Ala Vermelha',
    questions: fakeRedQuizQuestions,
    color: Colors.red,
  ),
];

final List<TourPiece> fakeNormalTourDataPieces = [
  TourPiece(
    beaconUUID: 'CF:5E:DC:11:7B:42',
    rssi: 40,
    color: Colors.blue,
    title: '1 - This title must be provided by an API',
    subtitle: '1 - This subtitle must be provided by an API',
    image: 'assets/univali.jpg',
    description: 'Peça 01',
    // description:
    //     '1 - This text must be provided by an API\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla efficitur lectus vel lorem venenatis dignissim. Aenean nec nulla in enim interdum placerat sed tincidunt mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Integer fermentum vulputate hendrerit. Sed id convallis mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur semper, ex ac sagittis efficitur, neque est convallis mi, et rutrum nisl lorem a massa. Quisque ac magna non erat pellentesque interdum et eu nunc. Quisque iaculis urna quis lobortis volutpat. Nullam gravida odio sit amet felis molestie posuere. Vivamus mollis consequat erat, at egestas leo pulvinar in. Vivamus sagittis, dui vitae venenatis dapibus, risus sem efficitur lorem, ut fermentum dui orci vel justo.',
  ),
  TourPiece(
    beaconUUID: 'CA:F4:AF:BE:CE:C2',
    rssi: 40,
    color: Colors.blue,
    title: '2 - This title must be provided by an API',
    subtitle: '2 - This subtitle must be provided by an API',
    image: 'assets/univali_black_white.jpg',
    description: 'Peça 02',
    //   description:
    //       '2 - This text must be provided by an API\n Small text here! This text must be provided by an API\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla efficitur lectus vel lorem venenatis dignissim. Aenean nec nulla in enim interdum placerat sed tincidunt mi. ',
  ),
];

final List<Quiz> fakeNormalTourDataQuizzes = [
  Quiz(
    beaconUUID: 'DF:6A:FB:49:44:C5',
    rssi: 40,
    title: 'Ala Vermelha',
    questions: fakeRedQuizQuestions,
    color: Colors.red,
  ),
  Quiz(
    beaconUUID: 'F1:E1:08:E0:37:CD',
    rssi: 40,
    title: 'Ala Azul',
    questions: fakeBlueQuizQuestions,
    color: mainBlue,
  )
];
