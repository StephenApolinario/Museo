import 'package:flutter/material.dart';
import 'package:museo/models/tour/tour_piece.dart';

class SpeakAboutTourPiece with ChangeNotifier {
  late TourPiece tempPiece;
  late List<String> originalQueue;
  late List<String> tempQueue;

  void updateTempPiece({required TourPiece tourPiece}) {
    tempQueue = [];
    tempPiece = tourPiece;
    updateOriginalQueue(tourPiece: tempPiece);
    notifyListeners();
  }

  void updateOriginalQueue({required TourPiece tourPiece}) {
    originalQueue = [
      tourPiece.title,
      tourPiece.subtitle,
      tourPiece.description,
    ];
  }
}
