import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/views/tour/tour_view.dart';

class TourType {
  final String name, description, icon;

  static const int maxNameLength = 13;
  static const int maxDescriptionLength = 70;

  TourType({
    required this.name,
    required this.description,
    required this.icon,
  }) {
    if (name.length > maxNameLength) {
      throw ArgumentError(
          'Name exceeds maximum length of $maxNameLength characters');
    }
    if (description.length > maxDescriptionLength) {
      throw ArgumentError(
          'Description exceeds maximum length of $maxDescriptionLength characters');
    }
  }
}

List<TourType> fakeTourType = [
  TourType(
    name: 'Fast',
    description:
        'Don\'t have enough time? Take a quick tour and enjoy the brief details',
    icon: 'assets/tour/fast.svg',
  ),
  TourType(
    name: 'Normal',
    description: 'Normal description',
    icon: 'assets/tour/fast.svg',
  ),
  TourType(
    name: 'Detailed',
    description: 'Detailed description',
    icon: 'assets/tour/fast.svg',
  ),
  TourType(
    name: 'Detailed',
    description: 'Detailed description',
    icon: 'assets/tour/fast.svg',
  ),
  TourType(
    name: 'Detailed',
    description: 'Detailed description',
    icon: 'assets/tour/fast.svg',
  ),
  TourType(
    name: 'Detailed',
    description: 'Detailed description',
    icon: 'assets/tour/fast.svg',
  ),
  TourType(
    name: 'Detailed',
    description: 'Detailed description',
    icon: 'assets/tour/fast.svg',
  ),
  TourType(
    name: 'Detailed',
    description: 'Detailed description',
    icon: 'assets/tour/fast.svg',
  ),
];

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
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Text(
                'Choose one tour option',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: TourOptions(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TourOptions extends StatelessWidget {
  const TourOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (fakeTourType.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: fakeTourType.length,
        itemBuilder: (context, index) {
          if (index % 2 == 0) {
            if (index == fakeTourType.length - 1) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TourCard(
                    name: fakeTourType[index].name,
                    description: fakeTourType[index].description,
                    icon: fakeTourType[index].icon,
                  ),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TourCard(
                    name: fakeTourType[index].name,
                    description: fakeTourType[index].description,
                    icon: fakeTourType[index].icon,
                  ),
                  TourCard(
                    name: fakeTourType[index + 1].name,
                    description: fakeTourType[index + 1].description,
                    icon: fakeTourType[index + 1].icon,
                  ),
                ],
              );
            }
          } else {
            return Container();
          }
        },
      );
    } else {
      return const Text(
        'Sorry, but there doesn\'t seem to be any tour at the moment',
        textAlign: TextAlign.center,
      );
    }
  }
}

class TourCard extends StatelessWidget {
  final String name, description, icon;

  const TourCard({
    super.key,
    required this.name,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return TourView(
                  mode: name,
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
              children: [
                // Icon
                SvgPicture.asset(
                  icon,
                  height: 50,
                  width: 50,
                ),
                // Tour name
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                // Description
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
