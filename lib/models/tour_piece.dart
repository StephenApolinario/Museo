// A explanation of how beacons/tours/quizzes works are inside the models/beacon/beacons.dart
class TourPiece {
  final String id, title, subtitle, description, image, beacon, tour, color;
  final int rssi;

  TourPiece({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    required this.rssi,
    required this.color,
    required this.beacon,
    required this.tour,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'image': image,
      'rssi': rssi,
      'color': color,
      'beacon': beacon,
      'tour': tour,
    };
  }
}
