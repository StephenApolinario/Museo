import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/tour_mode.dart';
import 'package:museo/services/tour_service.dart';
import 'package:museo/views/tour/tour_view.dart';

class TourSelectView extends StatelessWidget {
  const TourSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        backgroundColor: mainBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          context.loc.route_title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
        // Get all avaliables Tour Mode with Quizzes and Museum Pieces
        future: TourService().getTourModes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  'Sorry, but there doesn\'t seem to be any tour at the moment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  optionTitle(context),
                  TourOptions(
                    tourModes: snapshot.data as List<TourMode>,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }

  Center optionTitle(BuildContext context) {
    return Center(
      child: Text(
        context.loc.choose_tour_option,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}

class TourOptions extends StatelessWidget {
  final List<TourMode> tourModes;

  const TourOptions({
    super.key,
    required this.tourModes,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: tourModes.length,
          itemBuilder: (context, index) {
            return buildTourTypeList(index: index);
          },
        ),
      ),
    );
  }

  Widget buildTourTypeList({required int index}) {
    if (index % 2 == 0) {
      if (index == tourModes.length - 1) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TourCard(
              tourMode: tourModes[index],
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TourCard(
              tourMode: tourModes[index],
            ),
            TourCard(
              tourMode: tourModes[index + 1],
            ),
          ],
        );
      }
    } else {
      return Container();
    }
  }
}

class TourCard extends StatelessWidget {
  final TourMode tourMode;

  const TourCard({
    super.key,
    required this.tourMode,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return TourView(
                tourMode: tourMode,
              );
            },
          ),
        );
      },
      child: Container(
        height: 210,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Image(
                image: NetworkImage(tourMode.image),
                height: 50,
                width: 50,
              ),
              // Tour name
              const SizedBox(height: 10),
              Text(
                tourMode.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              // Description
              const SizedBox(height: 10),
              Text(
                tourMode.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
