import 'package:flutter/material.dart';
import 'package:museo/models/tour/tour_piece.dart';

class FavoritesTours with ChangeNotifier {
  late List<TourPiece> favoritesTours = [];

  void addToFavorite({
    required TourPiece tour,
    required BuildContext context,
  }) {
    late String snackBarText;

    bool alreadyAdded = favoritesTours.any((element) => element == tour);

    if (!alreadyAdded) {
      snackBarText =
          'You add to your favorites!'; // TODO -> MUST be provided by L10N
      favoritesTours.add(tour);
    } else {
      snackBarText =
          'You\'ve already added it to your favorites!'; // TODO -> MUST be provided by L10N
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackBarText), // TODO -> MUST be provided by L10N
        backgroundColor: alreadyAdded ? Colors.red.shade300 : Colors.green,
      ),
    );
    notifyListeners();
  }

  void removeToFavorite({
    required TourPiece tour,
    required BuildContext context,
  }) {
    late String snackBarText;

    bool alreadyAdded = favoritesTours.any((element) => element == tour);

    if (!alreadyAdded) {
      snackBarText = 'There is some error!'; // TODO -> MUST be provided by L10N
    } else {
      favoritesTours.remove(tour);
      snackBarText =
          'You\'ve deleted from your favorites!'; // TODO -> MUST be provided by L10N
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackBarText), // TODO -> MUST be provided by L10N
        backgroundColor: Colors.red.shade300,
      ),
    );
    notifyListeners();
  }
}

FavoritesTours fakeFavorites = FavoritesTours();
