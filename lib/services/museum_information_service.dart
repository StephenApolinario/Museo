import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:museo/models/museum_information.dart';
import 'package:museo/services/endpoints.dart';

class MuseumInformationService {
  Future getMuseumInformation(BuildContext context) async {
    var response = await http.get(
      Api().museumInformation(endpoint: ''),
    );

    if (response.statusCode == 200) {
      final museumInformationJson =
          jsonDecode(response.body)['museumInformations'];
      final museumInformation =
          MuseumInformation.fromJson(museumInformationJson);

      return museumInformation;
    }
  }
}
