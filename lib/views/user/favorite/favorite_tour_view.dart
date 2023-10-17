import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/tour/tour_piece.dart';
import 'package:museo/providers/favorites/favorites_tours.dart';
import 'package:provider/provider.dart';

class FavoriteTourView extends StatefulWidget {
  final TourPiece tour;

  const FavoriteTourView({
    super.key,
    required this.tour,
  });

  @override
  State<FavoriteTourView> createState() => _FavoriteTourViewState();
}

class _FavoriteTourViewState extends State<FavoriteTourView> {
  late FavoritesTours favoritesTours;

  @override
  void initState() {
    favoritesTours = Provider.of<FavoritesTours>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.favorite),
        actions: [
          IconButton(
            onPressed: () async {
              favoritesTours.removeToFavorite(
                context: context,
                tour: widget.tour,
              );
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
          ),
        ],
      ),
      // drawer: const menu.NavigationDrawer(),
      body: Column(
        children: [
          // Image - Title - Subtitle
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
              left: 16,
              right: 16,
            ),
            child: TourImageWithTitleAndSubtitle(
              title: widget.tour.title,
              subtitle: widget.tour.subtitle,
              image: widget.tour.image,
            ),
          ),
          // Blue Container with Description and Play/Speed
          VerticallyTextAndIcons(
            description: widget.tour.description,
            color: mainBlue,
          ),
        ],
      ),
    );
  }
}

class TourImageWithTitleAndSubtitle extends StatelessWidget {
  final String image, title, subtitle;

  const TourImageWithTitleAndSubtitle({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image on top
        ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Image.asset(
            image,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 10),
        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
        // Subtitle
        Text(
          subtitle,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class VerticallyTextAndIcons extends StatelessWidget {
  final String description;
  final Color color;

  const VerticallyTextAndIcons({
    super.key,
    required this.description,
    this.color = mainBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
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
                        description,
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow),
                  Icon(Icons.speed),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
