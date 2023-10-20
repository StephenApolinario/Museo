import 'package:flutter/material.dart';

class BuildResultContainer extends StatelessWidget {
  const BuildResultContainer({
    super.key,
    required this.quizzResult,
  });

  final int quizzResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // TODO This color/image must be provided by an API
        color: const Color.fromARGB(247, 126, 69, 69),
        borderRadius: BorderRadius.circular(6),
      ),
      constraints: const BoxConstraints(
        minHeight: 200,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // TODO:  Change the points to an IMAGE. Provided by API
            // 90 -- 100 -> Diamond
            // 70 -- 90  -> Gold
            // 50 -- 70  -> Silver
            // 00 -- 50  -> Bronze
            const Text(
              'Pontos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const Text(
              '380',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 50),
            // TODO This strings must be provided by an API
            Text(
              'Você obteve um desempenho de $quizzResult%',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
