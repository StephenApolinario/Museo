import 'dart:ui';
import 'package:museo/models/beacon/beacons.dart';

// A explanation of how beacons/tours/quizzes works are inside the models/beacon/beacons.dart
class TourPiece implements Beacon {
  final String title, subtitle, description, image, beaconUUID;
  final int rssi;
  final Color color;

  TourPiece({
    required this.beaconUUID,
    required this.rssi,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
  });
}
