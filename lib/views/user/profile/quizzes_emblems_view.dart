import 'dart:io';

import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/emblems.dart';
import 'package:museo/providers/user/user.dart';
import 'package:museo/services/emblem_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
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
    final userProvider = Provider.of<User>(context, listen: true);

    final List<dynamic> emblems = userProvider.loggedUser.emblems;

    List<Emblem> emblemList = emblems.map((item) {
      return Emblem(
        color: item['color'],
        title: item['title'],
        image: item['image'],
        maxPoints: item['maxPoints'],
        minPoints: item['minPoints'],
        quiz: item['quiz'],
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.emblems),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            emblems.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(context.loc.no_emblems),
                    ),
                  )
                // : const Text('Tem emblema'),
                : buildEmblemsList(emblems: emblemList),
          ],
        ),
      ),
    );
  }

  buildEmblemsList({required List<Emblem> emblems}) {
    return GridView.builder(
      itemCount: emblems.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) => emblemsListView(
        emblem: emblems[index],
        context: context,
      ),
    );
  }

  Widget emblemsListView({
    required Emblem emblem,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // TODO:  New page with details?
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(int.parse('0xFF${emblem.color}')),
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
                    emblem.image,
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
    return FutureBuilder(
      future: EmblemService().getEmblemQuizTitle(context, emblem.quiz),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  emblem.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  snapshot.data,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

shareEmblem({required Emblem emblem}) async {
  final url = Uri.parse(emblem.image);
  final response = await http.get(url);
  final bytes = response.bodyBytes;

  final temp = await getTemporaryDirectory();
  final path = '${temp.path}/image.jpg';
  File(path).writeAsBytes(bytes);

  await Share.shareFiles(
    [path],
  );
}
