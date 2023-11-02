import 'package:flutter/material.dart';
import 'package:museo/models/museum_piece.dart';

class SpeakAboutTourPiece with ChangeNotifier {
  late MuseumPiece tempPiece;
  late List<String> originalQueue;
  late List<String> tempQueue;

  void updateTempPiece({required MuseumPiece tourPiece}) {
    tempQueue = [];
    tempPiece = tourPiece;
    updateOriginalQueue(tourPiece: tempPiece);
    notifyListeners();
  }

  void updateOriginalQueue({required MuseumPiece tourPiece}) {
    originalQueue = [
      tourPiece.title,
      tourPiece.subtitle,
      tourPiece.description,
    ];
  }
}
