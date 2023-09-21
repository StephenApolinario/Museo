import 'dart:async';

import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';

class RideView extends StatefulWidget {
  const RideView({
    super.key,
    required this.rideMode,
  });
  final String rideMode;

  @override
  State<RideView> createState() => _RideViewState();
}

class _RideViewState extends State<RideView> {
  // TODO
  // [ ] Instead of using time, its should detect the beacon ID, check if there is beacon on API, and change the title/subtitle/description and image.
  // [ ] Check if the user really want to got to the next Item if the user spent just a little time on the previous one.
  int currentIndex = 0;
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      // Toggle between index 0 and 1
      setState(() {
        currentIndex = (currentIndex + 1) % 2;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${context.loc.route_title} ${widget.rideMode}'),
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
            child: RideImageWithTitleAndSubtitle(
              title: fakeRide[currentIndex].title,
              subtitle: fakeRide[currentIndex].subtitle,
              image: fakeRide[currentIndex].image,
            ),
          ),
          // Blue Container with Description and Play/Speed
          VerticallyTextAndIcons(
            description: fakeRide[currentIndex].descrption,
          ),
        ],
      ),
    );
  }
}

class RideImageWithTitleAndSubtitle extends StatelessWidget {
  final String image, title, subtitle;

  const RideImageWithTitleAndSubtitle({
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

  const VerticallyTextAndIcons({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: mainBlue,
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

class Ride {
  final String title, subtitle, descrption, image;

  Ride({
    required this.title,
    required this.subtitle,
    required this.descrption,
    required this.image,
  });
}

final List<Ride> fakeRide = [
  Ride(
    title: '1 - This title must be provided by an API',
    subtitle: '1 - This subtitle must be provided by an API',
    image: 'assets/univali.jpg',
    descrption:
        '1 - This text must be provided by an API\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla efficitur lectus vel lorem venenatis dignissim. Aenean nec nulla in enim interdum placerat sed tincidunt mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Integer fermentum vulputate hendrerit. Sed id convallis mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur semper, ex ac sagittis efficitur, neque est convallis mi, et rutrum nisl lorem a massa. Quisque ac magna non erat pellentesque interdum et eu nunc. Quisque iaculis urna quis lobortis volutpat. Nullam gravida odio sit amet felis molestie posuere. Vivamus mollis consequat erat, at egestas leo pulvinar in. Vivamus sagittis, dui vitae venenatis dapibus, risus sem efficitur lorem, ut fermentum dui orci vel justo.',
  ),
  Ride(
    title: '2 - This title must be provided by an API',
    subtitle: '2 - This subtitle must be provided by an API',
    image: 'assets/univali_black_white.jpg',
    descrption:
        '2 - This text must be provided by an API\n Small text here! This text must be provided by an API\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla efficitur lectus vel lorem venenatis dignissim. Aenean nec nulla in enim interdum placerat sed tincidunt mi. ',
  ),
];
