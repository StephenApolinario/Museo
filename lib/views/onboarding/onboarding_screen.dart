import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isOnboardingCompleted(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final bool? isCompleted = snapshot.data;
            if (isCompleted == false) {
              return const OnBoardingScreenShow();
            } else {
              return const MyHomePage();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

class OnBoardingScreenShow extends StatefulWidget {
  const OnBoardingScreenShow({super.key});

  @override
  State<OnBoardingScreenShow> createState() => OnBoardingScreenShowState();
}

class OnBoardingScreenShowState extends State<OnBoardingScreenShow> {
  late PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(
      () {
        if (_pageController.page == data.length - 1) {
          markOnboardingAsComplted(isCompleted: true);
        } else {
          markOnboardingAsComplted(isCompleted: false);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: data.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnBoardContent(
                    title: data[index].title,
                    description: data[index].description,
                    image: data[index].image,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    data.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainBlue,
                    ),
                    onPressed: () {
                      if (_pageIndex == data.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(),
                          ),
                        );
                      }
                      _pageController.nextPage(
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                    child: _pageIndex == data.length - 1
                        ? Text(
                            context.loc.continue_message,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> isOnboardingCompleted() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_completed') ?? false;
}

Future<void> markOnboardingAsComplted({
  required bool isCompleted,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('onboarding_completed', isCompleted);
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive ? mainBlue : mainBlue.withOpacity(0.4),
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
      ),
    );
  }
}

class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnBoard> data = [
  OnBoard(
    title: "Seja bem vindo!",
    description:
        "Esse aplicativo foi desenvolvido especialmente pensando em acessibilidade. A inclusão na visita do museu foi convertida para esse aplicativo áudio guia.",
    image: "assets/mascots/tuba.png",
  ),
  OnBoard(
    title: "Sobre o aplicativo",
    description:
        "Aqui se encontra uma visita guiada por áudios em cada vitrine do museu, ou seja, automaticamente quando você for passando pelas vitrines, o áudio e determina assunto vai mudar, gerando uma facilidade de manusear o aplicativo. \n\n Continue com seu fone de ouvido que estamos apenas começando!",
    image: "assets/mascots/whale.png",
  ),
];

class OnBoardContent extends StatelessWidget {
  const OnBoardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 350,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.justify,
        ),
        const Spacer(),
      ],
    );
  }
}
