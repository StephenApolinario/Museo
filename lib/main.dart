import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/constants/routes.dart';
import 'package:museo/constants/urls.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/utilities/dialogs/start_dialog.dart';
import 'package:museo/views/about/application_view.dart';
import 'package:museo/views/about/movi_view.dart';
import 'package:museo/views/favorite/favorite_view.dart';
import 'package:museo/views/onboarding/onboarding_screen.dart';
import 'package:museo/views/ride/ride_select_view.dart';
import 'package:museo/views/search_view.dart';
import 'package:museo/views/store/souvenirs_view.dart';
import 'package:museo/views/store/store_view.dart';
import 'package:museo/views/map_view.dart';
import 'package:museo/views/user/login_view.dart';
import 'package:museo/views/user/profile_view.dart';
import 'package:museo/views/sections_view.dart';
import 'package:museo/utilities/menu/menu.dart' as menu;
import 'package:url_launcher/url_launcher.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      home: const OnBoardingScreen(),
      // home: const RideSelectView(),
      routes: {
        aboutMovi: (context) => const MoviView(),
        aboutApplication: (context) => const ApplicationView(),
        search: (context) => const SearchView(),
        sections: (context) => const SectionsView(),
        map: (context) => const MapView(),
        store: (context) => const StoreView(),
        souvernirs: (context) => const SouvenirsView(),
        userProfile: (context) => const ProfileView(),
        login: (context) => const LoginView(),
        favorites: (context) => const FavoriteView(),
        rideSelect: (context) => const RideSelectView(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MOVI'),
        actions: [
          IconButton(
            onPressed: () async {
              final Uri url = Uri.parse(moviHome);
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
            // icon: const Icon(Icons.access_alarm), //Logo Movi Here
            icon: Image.asset("assets/logos/movi.png"),
          ),
        ],
      ),
      drawer: const menu.NavigationDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "Vamos iniciar" [X]
              Text(
                context.loc.start_title,
                style: const TextStyle(
                  color: mainBlue,
                  fontSize: 28,
                ),
              ),
              // Start text [X]
              const SizedBox(height: 10),
              Text(
                context.loc.start_text,
                textAlign: TextAlign.justify,
              ),
              // Start Button [X]
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                        color: mainGray,
                      ),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                    backgroundColor: Colors.white,
                    foregroundColor: mainBlue,
                  ),
                  onPressed: () async {
                    final shouldLogin = await showStartDialog(context);
                    if (context.mounted) {
                      if (shouldLogin) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        );
                      } else if (shouldLogin == false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RideSelectView()),
                        );
                      }
                    }
                  },
                  child: Text(
                    context.loc.start_button,
                    style: const TextStyle(
                      color: mainGray,
                    ),
                  ),
                ),
              ),
              // "Pesquise"
              const SizedBox(height: 30),
              Text(
                context.loc.search_title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 28,
                ),
              ),
              // Search text [X]
              const SizedBox(height: 10),
              Text(
                context.loc.search_text,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
              // Search field [X]
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  hintText: context.loc.search_hint,
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onChanged: (value) {},
              ),
              // MOVI PIC? [X]
              const SizedBox(height: 30),
              Image.asset("assets/movi.png"),
            ],
          ),
        ),
      ),
    );
  }
}
