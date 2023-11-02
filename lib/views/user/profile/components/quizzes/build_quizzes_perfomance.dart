import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/helpers/calculate_quiz_performance.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BuildQuizzesPerfomance extends StatelessWidget {
  const BuildQuizzesPerfomance({super.key});

  @override
  Widget build(BuildContext context) {
    final userPeformance = calculateQuizPerformance(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            quizzPerformanceTitle(context),
            quizzPerformance(userPeformance, context),
          ],
        ),
      ),
    );
  }

  Text quizzPerformanceTitle(BuildContext context) {
    return Text(
      context.loc.performance_quiz,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget quizzPerformance(userPeformance, BuildContext context) {
    if (userPeformance == null) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.loc.no_performance_quiz,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: mainBlue,
              ),
            ),
          ],
        ),
      );
    } else {
      return CircularPercentIndicator(
        radius: 60,
        lineWidth: 13,
        progressColor: Colors.green.shade500,
        animation: true,
        percent: userPeformance,
        circularStrokeCap: CircularStrokeCap.butt,
        animateFromLastPercent: true,
        animationDuration: 800,
        center: Text(
          '${(userPeformance * 100).toStringAsFixed(2).replaceAll('.', ',')}%',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    }
  }
}
