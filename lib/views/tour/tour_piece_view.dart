import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/helpers/color_from_api.dart';
import 'package:museo/models/museum_piece.dart';
import 'package:museo/models/tour_mode.dart';
import 'package:museo/providers/tour/tour_piece.dart';
import 'package:museo/providers/user/user.dart';
import 'package:museo/services/user_service.dart';
import 'package:provider/provider.dart';

enum TtsState { playing, stopped, paused, continued }

class Speed {
  Velocity name;
  double velocity;

  Speed({
    required this.name,
    required this.velocity,
  });
}

enum Velocity {
  fast,
  normal,
  slow,
}

Speed fast = Speed(
  name: Velocity.fast,
  velocity: 0.8,
);
Speed normal = Speed(
  name: Velocity.normal,
  velocity: 0.5,
);
Speed slow = Speed(
  name: Velocity.slow,
  velocity: 0.3,
);

class TourPieceView extends StatefulWidget {
  final TourMode tourMode;
  final MuseumPiece tourPiece;

  const TourPieceView({
    super.key,
    required this.tourMode,
    required this.tourPiece,
  });

  @override
  State<TourPieceView> createState() => _TourPieceViewState();
}

class _TourPieceViewState extends State<TourPieceView> {
  late User userProvider;

  late SpeakAboutTourPiece speakAboutTourPiece;

  // TTS
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  Speed speed = normal;
  bool isCurrentLanguageInstalled = false;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  @override
  void initState() {
    super.initState();
    initTts();
    speakAboutTourPiece =
        Provider.of<SpeakAboutTourPiece>(context, listen: false);
    speakAboutTourPiece.updateTempPiece(tourPiece: widget.tourPiece);
    userProvider = Provider.of<User>(context, listen: false);
    speakHandler();
  }

  initTts() {
    flutterTts = FlutterTts();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {
        setState(() {});
      });
    }

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
        speakAboutTourPiece.tempQueue.removeAt(0);
        if (speakAboutTourPiece.tempQueue.isNotEmpty) {
          speakPhrases();
        }
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  Future speakHandler() async {
    if (speakAboutTourPiece.tempQueue.isEmpty) {
      speakAboutTourPiece.tempQueue.addAll(speakAboutTourPiece.originalQueue);
    }

    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(speed.velocity);
    await flutterTts.setPitch(pitch);

    speakPhrases();
  }

  Future speakPhrases() async {
    if (speakAboutTourPiece.tempQueue.isNotEmpty) {
      String text = speakAboutTourPiece.tempQueue.first;
      await flutterTts.speak(text);
    }
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {}
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {}
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    if (speakAboutTourPiece.tempPiece != widget.tourPiece) {
      speakAboutTourPiece.updateTempPiece(tourPiece: widget.tourPiece);
      speakHandler();
    }

    // return const MyApp();
    return Scaffold(
      appBar: AppBar(
        title: Text('${context.loc.route_title} ${widget.tourMode.title}'),
        actions: [
          userProvider.logged
              ? IconButton(
                  onPressed: () async {
                    final addFavorite = await UserService()
                        .addFavorite(context, widget.tourPiece.id);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              addFavorite == 'user-already-have-favorite'
                                  ? context.loc.favorite_already_added
                                  : context.loc.favorite_added),
                          backgroundColor:
                              addFavorite == 'user-already-have-favorite'
                                  ? Colors.red.shade300
                                  : Colors.green.shade300,
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: mainBlue,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: Column(
        children: [
          // Image - Title - Subtitle
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
              left: 16,
              right: 16,
            ),
            child: TourImageWithTitleAndSubtitle(
              title: widget.tourPiece.title,
              subtitle: widget.tourPiece.subtitle,
              image: widget.tourPiece.image,
            ),
          ),
          // Blue Container with Description and Play/Speed
          verticallyTextAndIcons(
            description: widget.tourPiece.description,
            color: widget.tourPiece.color,
          ),
        ],
      ),
    );
  }

  verticallyTextAndIcons({
    required String description,
    required String color,
  }) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorFromApi(color: color),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  playAndPauseButton(),
                  controlSpeedButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton playAndPauseButton() {
    return IconButton(
      onPressed: () {
        if (isPlaying || isContinued) {
          _pause();
        } else {
          speakHandler();
        }
      },
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      icon: isPlaying || isContinued
          ? const Icon(Icons.pause)
          : const Icon(Icons.play_arrow),
      color: Colors.white,
      iconSize: 38,
    );
  }

  IconButton controlSpeedButton() {
    return IconButton(
      onPressed: () {
        changeSpeed();
      },
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.speed_rounded),
      color: speed == normal
          ? Colors.white
          : speed == slow
              ? Colors.orange
              : Colors.red,
      iconSize: 30,
    );
  }

  void changeSpeed() {
    setState(() {
      if (speed == fast) {
        speed = normal;
      } else if (speed == normal) {
        speed = slow;
      } else {
        speed = fast;
      }
    });
    _pause();
    speakHandler();
  }
}

class TourImageWithTitleAndSubtitle extends StatelessWidget {
  final String image, title, subtitle;

  const TourImageWithTitleAndSubtitle({
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
          child: Image(
            image: NetworkImage(image),
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
