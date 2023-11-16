import 'dart:async';

import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/extensions/string.dart';
import 'package:museo/models/tour_piece.dart';
import 'package:museo/services/user_service.dart';

class FavoriteTourView extends StatefulWidget {
  final TourPiece favoriteMuseumPiece;

  const FavoriteTourView({
    super.key,
    required this.favoriteMuseumPiece,
  });

  @override
  State<FavoriteTourView> createState() => _FavoriteTourViewState();
}

class _FavoriteTourViewState extends State<FavoriteTourView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.favorite),
        actions: [
          IconButton(
            onPressed: () async {
              UserService().removeFavorite(
                context,
                widget.favoriteMuseumPiece.id,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.loc.favorite_removed),
                  backgroundColor: Colors.red.shade300,
                ),
              );
            },
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
              left: 16,
              right: 16,
            ),
            child: TourImageWithTitleAndSubtitle(
                favoriteMuseumPiece: widget.favoriteMuseumPiece),
          ),
          VerticallyTextAndIcons(
            favorite: widget.favoriteMuseumPiece,
          ),
        ],
      ),
    );
  }
}

class TourImageWithTitleAndSubtitle extends StatelessWidget {
  final TourPiece favoriteMuseumPiece;

  const TourImageWithTitleAndSubtitle({
    super.key,
    required this.favoriteMuseumPiece,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        favoriteImage(),
        const SizedBox(height: 10),
        favoriteTitle(),
        favoriteSubtitle(),
      ],
    );
  }

  Text favoriteSubtitle() {
    return Text(
      favoriteMuseumPiece.subtitle,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }

  Text favoriteTitle() {
    return Text(
      favoriteMuseumPiece.title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 25,
      ),
    );
  }

  Widget favoriteImage() {
    return FutureBuilder(
      future: getImage(favoriteMuseumPiece.image),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Image.network(
              favoriteMuseumPiece.image,
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

class VerticallyTextAndIcons extends StatelessWidget {
  final TourPiece favorite;

  const VerticallyTextAndIcons({
    super.key,
    required this.favorite,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: favorite.color.fromHex(),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: secondBlue,
            width: 3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Text(
                        favorite.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Icon(Icons.play_arrow),
              //     Icon(Icons.speed),
              //   ],
              // ),
            ],
          ),
        ),
      ),
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
