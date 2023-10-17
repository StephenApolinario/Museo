import 'dart:io';

import 'package:flutter/material.dart';
import 'package:museo/models/emblems/emblems.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

class QuizzesEmblemListView extends StatefulWidget {
  const QuizzesEmblemListView({
    super.key,
  });

  @override
  State<QuizzesEmblemListView> createState() => _QuizzesEmblemListViewState();
}

class _QuizzesEmblemListViewState extends State<QuizzesEmblemListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO -> MUST be provided by L10N
        title: const Text('Emblems'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //TODO -> This shoul be emblems from API.
            fakeUserEmblemsData.isEmpty
                ? const Expanded(
                    child: Center(
                      // TODO -> MUST be provided by L10N
                      child: Text('Você ainda não nenhum emblema!'),
                    ),
                  )
                //TODO -> This shoul be emblems from API.
                : buildEmblemsList(emblems: fakeUserEmblemsData),
          ],
        ),
      ),
    );
  }

  buildEmblemsList({required List<Emblem> emblems}) {
    return GridView.builder(
      //TODO -> This must be emblems from API.
      itemCount: emblems.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) => emblemsListView(
        emblem: emblems[index],
        context: context,
      ),
    );
  }

  emblemsListView({
    required Emblem emblem,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // TODO -> New page with details?
        },
        child: Container(
          decoration: BoxDecoration(
            color: emblem.quiz.color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  emblemImageAndShare(emblem: emblem),
                  emblemDetails(emblem: emblem),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emblemImageAndShare({required Emblem emblem}) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    emblem.imagePath,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  padding: const EdgeInsets.only(left: 40, bottom: 40),
                  onPressed: () async => shareEmblem(emblem: emblem),
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget emblemDetails({required Emblem emblem}) {
    return Column(
      children: [
        Text(
          emblem.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          emblem.quiz.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

shareEmblem({required Emblem emblem}) async {
  final url = Uri.parse(emblem.imagePath);
  final response = await http.get(url);
  final bytes = response.bodyBytes;

  final temp = await getTemporaryDirectory();
  final path = '${temp.path}/image.jpg';
  File(path).writeAsBytes(bytes);

  await Share.shareFiles(
    [path],
  );
}
