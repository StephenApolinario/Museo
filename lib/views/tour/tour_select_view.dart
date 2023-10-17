import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/tour/tour_mode.dart';
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
    if (fakeTourMode.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: fakeTourMode.length,
        itemBuilder: (context, index) {
          return buildTourTypeList(index: index);
        },
      );
    } else {
      return const Text(
        'Sorry, but there doesn\'t seem to be any tour at the moment',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget buildTourTypeList({required int index}) {
    if (index % 2 == 0) {
      if (index == fakeTourMode.length - 1) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TourCard(
              tourMode: fakeTourMode[index],
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TourCard(
              tourMode: fakeTourMode[index],
            ),
            TourCard(
              tourMode: fakeTourMode[index + 1],
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return TourView(
                  tourMode: tourMode, // TODO -> Uncomment line
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
                  tourMode.icon,
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
                  tourMode.description,
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
