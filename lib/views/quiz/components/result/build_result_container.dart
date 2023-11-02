import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/quiz.dart';
import 'package:museo/services/user_service.dart';

class BuildResultContainer extends StatelessWidget {
  const BuildResultContainer({
    super.key,
    required this.quiz,
  });

  final NewQuiz quiz;

  @override
  Widget build(BuildContext context) {
    final emblem = UserService().getEmblemFromQuiz(context, quiz.id);
    // print(quiz.id);
    // return const Text('ss');
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // TODO This color/image must be provided by an API ?
        color: const Color.fromARGB(247, 126, 69, 69),
        borderRadius: BorderRadius.circular(6),
      ),
      constraints: const BoxConstraints(
        minHeight: 250,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${context.loc.emblem_acchieved} ${emblem['title'].toLowerCase()}!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Image(
              image: NetworkImage(emblem['image']),
              height: 150,
              width: 150,
            ),
            Text(
              '${context.loc.quiz_performance_obtained} ${((quiz.score / quiz.questions.length) * 100).round()}%',
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
