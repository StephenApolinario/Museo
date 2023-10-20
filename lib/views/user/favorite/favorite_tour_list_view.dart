import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/tour/tour_piece.dart';
import 'package:museo/providers/favorites/favorites_tours.dart'
    show FavoritesTours;
import 'package:museo/views/user/favorite/favorite_tour_view.dart';
import 'package:provider/provider.dart';

class FavoriteTourListView extends StatefulWidget {
  const FavoriteTourListView({
    super.key,
  });

  @override
  State<FavoriteTourListView> createState() => _FavoriteTourListViewState();
}

class _FavoriteTourListViewState extends State<FavoriteTourListView> {
  @override
  Widget build(BuildContext context) {
    final FavoritesTours favoritesTours = context.watch<FavoritesTours>();
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
            favoritesTours.favoritesTours.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text(
                          'Você ainda não tem favoritos!'), // TODO:  MUST be provided by L10N
                    ),
                  )
                : buildFavoritesList(provider: favoritesTours),
          ],
        ),
      ),
    );
  }

  buildFavoritesList({required FavoritesTours provider}) {
    return GridView.builder(
      itemCount: provider.favoritesTours.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Set the number of elements per line
      ),
      itemBuilder: (context, index) => favoritesListView(
        tour: provider.favoritesTours[index],
        context: context,
      ),
    );
  }

  favoritesListView({required TourPiece tour, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FavoriteTourView(
                tour: tour,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: mainBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  objectImage(tour),
                  objectTitle(tour),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text objectTitle(TourPiece object) => Text(
        object.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
      );

  ClipRRect objectImage(TourPiece object) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        object.image,
        fit: BoxFit.fill,
      ),
    );
  }
}
