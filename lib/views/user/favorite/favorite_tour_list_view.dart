import 'dart:async';

import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/extensions/string.dart';
import 'package:museo/models/tour_piece.dart';
import 'package:museo/providers/user/user.dart';
import 'package:museo/views/user/favorite/favorite_tour_view.dart';
import 'package:provider/provider.dart';

class FavoriteTourListView extends StatelessWidget {
  const FavoriteTourListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: true);
    final List<dynamic> favorites = userProvider.loggedUser.favorites;

    List<TourPiece> favoritesTourPieces = favorites.map((item) {
      return TourPiece(
        id: item['_id'],
        title: item['title'],
        subtitle: item['subtitle'],
        description: item['description'],
        image: item['image'],
        rssi: item['rssi'],
        color: item['color'],
        beacon: item['beacon'],
        tour: item['tour'],
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.loc.favorite,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            favoritesTourPieces.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(context.loc.no_favorites_yet),
                    ),
                  )
                : buildFavoritesList(favorites: favoritesTourPieces),
          ],
        ),
      ),
    );
  }

  buildFavoritesList({required List<TourPiece> favorites}) {
    return GridView.builder(
      itemCount: favorites.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Set the number of elements per line
      ),
      itemBuilder: (context, index) => favoritesListView(
        favoriteMuseumPiece: favorites[index],
        context: context,
      ),
    );
  }

  favoritesListView({
    required TourPiece favoriteMuseumPiece,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FavoriteTourView(
                favoriteMuseumPiece: favoriteMuseumPiece,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: favoriteMuseumPiece.color.fromHex(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  objectImage(favoriteMuseumPiece),
                  objectTitle(favoriteMuseumPiece),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text objectTitle(TourPiece favorite) => Text(
        favorite.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
      );

  Widget objectImage(TourPiece favorite) {
    return FutureBuilder(
      future: getImage(favorite.image),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              favorite.image,
              fit: BoxFit.fill,
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

Future<ImageProvider> getImage(String imageUrl) async {
  ImageProvider imageProvider = NetworkImage(imageUrl);
  Completer<ImageProvider> completer = Completer();
  NetworkImage(imageUrl)
      .resolve(
        const ImageConfiguration(),
      )
      .addListener(
        ImageStreamListener(
          (info, synchronousCall) {
            completer.complete(imageProvider);
          },
          onError: (dynamic exception, StackTrace? stackTrace) {
            completer.completeError(exception, stackTrace);
          },
        ),
      );
  return completer.future;
}
