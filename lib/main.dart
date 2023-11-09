import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/constants/routes.dart';
import 'package:museo/constants/urls.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/gen/assets.gen.dart';
import 'package:museo/providers/register/registerig_fields.dart';
import 'package:museo/providers/store/shopping_ticket_cart.dart';
import 'package:museo/providers/tour/tour_piece.dart';
import 'package:museo/providers/update/updating_fields.dart';
import 'package:museo/providers/user/user.dart';
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
import 'package:museo/views/user/forget_password.dart';
import 'package:museo/views/user/forget_password_update.dart';
import 'package:museo/views/user/login_view.dart';
import 'package:museo/views/user/profile/profile_view.dart';
import 'package:museo/views/sections_view.dart';
import 'package:museo/utilities/menu/menu.dart' as menu;
import 'package:museo/views/user/profile/quizzes_emblems_view.dart';
import 'package:museo/views/user/profile/update_informations.dart';
import 'package:museo/views/user/profile/update_password_view.dart';
import 'package:museo/views/user/registering/registering_view.dart';
import 'package:museo/views/wifi_off_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: '.env');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShoppingTicketCart()),
        ChangeNotifierProvider(create: (_) => RegisteringFields()),
        ChangeNotifierProvider(create: (_) => UpdatingFields()),
        ChangeNotifierProvider(create: (_) => SpeakAboutTourPiece()),
        ChangeNotifierProvider(create: (_) => User()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      title: 'Flutter',
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
      home: _connectionStatus != ConnectivityResult.none
          ? const OnBoardingScreen()
          : WifiOffView(
              status: _connectionStatus,
            ),
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
        userForgetPassword: (context) => const ForgetPasswordView(),
        quizzEmblems: (context) => const QuizzesEmblemListView(),
        userGetNewPassword: (context) => const UserGetNewPassword(),
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
                    final userProvider =
                        Provider.of<User>(context, listen: false);

                    final navigator = Navigator.of(context);
                    if (!userProvider.logged) {
                      final shouldLogin = await showStartDialog(context);
                      if (shouldLogin) {
                        navigator.push(
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        );
                      } else if (shouldLogin == false) {
                        navigator.push(
                          MaterialPageRoute(
                            builder: (context) => const TourSelectView(),
                          ),
                        );
                      }
                    } else {
                      navigator.push(
                        MaterialPageRoute(
                          builder: (context) => const TourSelectView(),
                        ),
                      );
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
