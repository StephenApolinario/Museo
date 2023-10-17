import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/constants/routes.dart';
import 'package:museo/constants/urls.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/gen/assets.gen.dart';
import 'package:museo/providers/favorites/favorites_tours.dart';
import 'package:museo/providers/register/registerig_fields.dart';
import 'package:museo/providers/store/shopping_ticket_cart.dart';
import 'package:museo/providers/tour/tourPiece.dart';
import 'package:museo/providers/update/updating_fields.dart';
import 'package:museo/utilities/dialogs/start_dialog.dart';
import 'package:museo/views/about/application_view.dart';
import 'package:museo/views/about/movi_view.dart';
import 'package:museo/views/user/favorite/favorite_tour_list_view.dart';
import 'package:museo/views/onboarding/onboarding_screen_view.dart';
import 'package:museo/views/store/checkout/checkout_view.dart';
import 'package:museo/views/tour/tour_select_view.dart';
import 'package:museo/views/search_view.dart';
import 'package:museo/views/store/souvenirs/souvenirs_store_view.dart';
import 'package:museo/views/store/tickets/tickets_store_view.dart';
import 'package:museo/views/user/login_view.dart';
import 'package:museo/views/user/profile/profile_view.dart';
import 'package:museo/views/sections_view.dart';
import 'package:museo/utilities/menu/menu.dart' as menu;
import 'package:museo/views/user/profile/quizzes_emblems_view.dart';
import 'package:museo/views/user/profile/update_informations.dart';
import 'package:museo/views/user/profile/update_password_view.dart';
import 'package:museo/views/user/registering/registering_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShoppingTicketCart()),
        ChangeNotifierProvider(create: (_) => RegisteringFields()),
        ChangeNotifierProvider(create: (_) => UpdatingFields()),
        ChangeNotifierProvider(create: (_) => FavoritesTours()),
        ChangeNotifierProvider(create: (_) => SpeakAboutTourPiece()),
      ],
      child: const MyApp(),
    ),
  );
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
      routes: {
        aboutMovi: (context) => const MoviView(),
        aboutApplication: (context) => const ApplicationView(),
        search: (context) => const SearchView(),
        sections: (context) => const SectionsView(),
        ticketsStore: (context) => const StoreView(),
        souvernirsStore: (context) => const SouvenirsStoreView(),
        userProfile: (context) => const ProfileView(),
        login: (context) => const LoginView(),
        register: (context) => const RegisteringView(),
        favorites: (context) => const FavoriteTourListView(),
        tourSelect: (context) => const TourSelectView(),
        checkout: (context) => const CheckoutView(),
        userUpdatePassword: (context) => const UpdatePasswordView(),
        userUpdateInformation: (context) => const UpdateInformationView(),
        quizzEmblems: (context) => const QuizzesEmblemListView(),
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
            icon: Image.asset(Assets.logos.movi.path),
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
              // 'Vamos iniciar' [X]
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
                            builder: (context) => const TourSelectView(),
                          ),
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
              // 'Search title'
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
              Image.asset('assets/movi.png'),
            ],
          ),
        ),
      ),
    );
  }
}
