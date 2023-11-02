import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:museo/models/tour_mode.dart';
import 'package:museo/services/endpoints.dart';

class TourService {
  Future getTourModes() async {
    // 1. Get all Tour Modes
    final response = await http.get(Api().tourMode(endpoint: ''));

    if (response.statusCode != 200) {
      return null;
    }

    final jsonTours = jsonDecode(response.body)['tours'];

    // 2. Get all Quizzes and Museum Pieces from each Tour Mode
    for (var tourMode in jsonTours) {
      final tourModeBeacons = await http.get(
        Api().tourMode(endpoint: 'beacons/${tourMode['_id']}'),
      );

      tourMode['museumPieces'] =
          jsonDecode(tourModeBeacons.body)['museumPieces'];
      tourMode['quizzes'] = jsonDecode(tourModeBeacons.body)['quizzes'];
    }

    // Get all available tours
    List<TourMode> tourList = jsonTours.map<TourMode>((tourMode) {
      return TourMode.fromJson(tourMode);
    }).toList();

    return tourList;
  }
}
