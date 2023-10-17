import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BuildQuizzesPerfomance extends StatelessWidget {
  const BuildQuizzesPerfomance({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Quizzes perfomance', // TODO -> MUST be provided by L10N
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            CircularPercentIndicator(
              radius: 60,
              lineWidth: 13,
              progressColor: Colors.green.shade500,
              animation: true,
              percent: 0.78, // TODO -> This should be given by the API
              circularStrokeCap: CircularStrokeCap.round,
              animateFromLastPercent: true,
              animationDuration: 800,
              center: const Text(
                '78%', // TODO -> This should be given by the API
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
