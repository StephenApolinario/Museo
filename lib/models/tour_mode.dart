import 'package:museo/models/museum_piece.dart';
import 'package:museo/models/quiz.dart';

class TourMode {
  final String id, title, subtitle, image;
  final List<MuseumPiece> tourPieces;
  final List<NewQuiz> tourQuizzes;

  static const int maxNameLength = 13;
  static const int maxDescriptionLength = 70;

  TourMode({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.tourPieces,
    required this.tourQuizzes,
  });

  factory TourMode.fromJson(Map<String, dynamic> json) {
    var tourMuseumPiecesData = json['museumPieces'] as List<dynamic>;
    var tourQuizzesData = json['quizzes'] as List<dynamic>;

    List<MuseumPiece> tourPieces = tourMuseumPiecesData
        .map((piece) => MuseumPiece(
              id: piece['_id'],
              title: piece['title'],
              subtitle: piece['subtitle'],
              description: piece['description'],
              image: piece['image'],
              color: piece['color'],
              beaconUUID: piece['beacon']['uuid'],
              rssi: piece['rssi'],
            ))
        .toList();

    List<NewQuiz> tourQuizzes = tourQuizzesData
        .map((quiz) => NewQuiz(
              id: quiz['_id'],
              title: quiz['title'],
              beaconUUID: quiz['beacon']['uuid'],
              color: quiz['color'],
              rssi: quiz['rssi'],
              questions: (quiz['questions'] as List<dynamic>)
                  .map((question) => NewQuestion(
                        text: question['text'],
                        color: question['color'],
                        options: (question['options'] as List<dynamic>)
                            .map((option) => NewOption(
                                  awnser: option['answer'],
                                  isCorrect: option['isCorrect'],
                                ))
                            .toList(),
                      ))
                  .toList(),
            ))
        .toList();

    return TourMode(
      id: json['_id'],
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
      tourPieces: tourPieces,
      tourQuizzes: tourQuizzes,
    );
  }
}
