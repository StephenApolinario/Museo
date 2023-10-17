import 'package:museo/models/beacon/beacons.dart';

// A explanation of how beacons/tours/quizzes works are inside the models/beacon/beacons.dart

class TourMode {
  final String title, description, icon;
  final List<Beacon> tourBeacons;

  static const int maxNameLength = 13;
  static const int maxDescriptionLength = 70;

  TourMode({
    required this.title,
    required this.description,
    required this.icon,
    required this.tourBeacons,
  }) {
    if (title.length > maxNameLength) {
      throw ArgumentError(
          'Name exceeds maximum length of $maxNameLength characters');
    }
    if (description.length > maxDescriptionLength) {
      throw ArgumentError(
          'Description exceeds maximum length of $maxDescriptionLength characters');
    }
  }
}

// All the lines above are just examples. The original should be retrive from API.
// A list of tour type have tourBeacons (Quizzes and pieces), title, description and icon.
List<TourMode> fakeTourMode = [
  TourMode(
    tourBeacons: fakeNormalTourDataBeacons,
    title: 'Normal',
    description: 'Normal description',
    icon: 'assets/tour/fast.svg',
  ),
  TourMode(
    tourBeacons: fakeDetailedTourDataBeacons,
    title: 'Detailed',
    description: 'Detailed description',
    icon: 'assets/tour/fast.svg',
  ),
  TourMode(
    tourBeacons: fakeFastTourDataBeacons,
    title: 'Fast',
    description:
        'Don\'t have enough time? Take a quick tour and enjoy the brief details',
    icon: 'assets/tour/fast.svg',
  ),
];
