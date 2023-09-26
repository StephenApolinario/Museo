import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/views/quizz/quizz_view.dart' show Question;
import 'package:museo/views/tour/tour_view.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final List<Question> questions;
  final String tourMode;

  const ResultPage({
    super.key,
    required this.score,
    required this.questions,
    required this.tourMode,
  });

  @override
  Widget build(BuildContext context) {
    final int quizzResult = ((questions.length / score) * 100).round();

    return Scaffold(
      // TODO This color/image must be provided by an API
      backgroundColor: const Color.fromARGB(255, 107, 13, 13),
      appBar: AppBar(
        // TODO This color must be provided by l10n
        title: const Text('Resultado do seu quizz!'),
      ),
      body: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              // TODO This must be provided by an API
              'assets/quizz/dots.svg',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  // TODO This must be provided by an API
                  const Text(
                    'VOCÊ COMPLETOU A ALA VERMELHA!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 150),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            // Middle container with points and correct awnsers.
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    // TODO This color/image must be provided by an API
                                    color:
                                        const Color.fromARGB(247, 126, 69, 69),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: const BoxConstraints(
                                    minHeight: 200,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        // TODO -> Change the points to an IMAGE. Provided by API
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
                                ),
                                // Crystals image on background
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/quizz/crystals.png',
                                      height: 120,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            // Row with Share Icon and continue button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Share icon
                                ElevatedButton(
                                  // TODO -> Share by what? Twitter? Share the points and image?
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                        color: mainGray,
                                      ),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.share_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                // Continue button
                                ElevatedButton(
                                  // TODO Going back to the page waiting for some beacon
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TourView(mode: tourMode),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                        color: mainGray,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Continuar',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
