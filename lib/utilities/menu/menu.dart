import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart' as custom_color;
import 'package:museo/constants/routes.dart';
import 'package:museo/constants/urls.dart';
import 'package:museo/utilities/menu/menu_items.dart';
import 'package:museo/views/user/login_view.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: custom_color.mainBlue,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Material(
              color: custom_color.mainBlue,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(userProfile);
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: 24 + MediaQuery.of(context).padding.top,
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 52,
                        backgroundImage: NetworkImage(
                            'https://media.istockphoto.com/id/1223671392/vector/default-profile-picture-avatar-photo-placeholder-vector-illustration.jpg?s=612x612&w=0&k=20&c=s0aTdmT5aU6b8ot7VKm11DeID6NctRCpB755rA1BIP0='),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                          );
                        },
                        child: const Text(
                          'Entrar ou registrar-se',
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Esqueceu sua senha?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Menu items
            Wrap(
              runSpacing: 7,
              children: [
                // Menu Items
                menuItem(
                  context: context,
                  icon: Icons.house_outlined,
                  title: 'INÍCIO',
                  route: home,
                ),
                menuItem(
                  context: context,
                  icon: Icons.search,
                  title: 'PESQUISE',
                  route: search,
                ),
                menuItem(
                  context: context,
                  icon: Icons.search,
                  title: 'ALAS',
                  route: wings,
                ),
                menuItem(
                  context: context,
                  icon: Icons.map,
                  title: 'MAPA',
                  route: map,
                ),
                menuItem(
                  context: context,
                  icon: Icons.store,
                  title: 'LOJINHA',
                  route: souvernirs,
                ),
                menuItem(
                  context: context,
                  icon: Icons.airplane_ticket,
                  title: 'INGRESSO E CUPONS',
                  route: store,
                ),
                menuItem(
                  context: context,
                  icon: Icons.museum,
                  title: 'SOBRE O MOVI',
                  route: aboutMovi,
                ),
                menuItem(
                  context: context,
                  icon: Icons.info,
                  title: 'SOBRE O APLICATIVO',
                  route: aboutApplication,
                ),
                // Logos on bottom
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Movi Logo
                    Container(
                      width: 70,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () async {
                          final Uri url = Uri.parse(moviHome);
                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        // icon: const Icon(Icons.access_alarm), //Logo Movi Here
                        icon: Image.asset(
                          "assets/logos/movi.png",
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                    // Univali Logo
                    Container(
                      width: 70,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () async {
                          final Uri url = Uri.parse(univaliHome);
                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        // icon: const Icon(Icons.access_alarm), //Logo Movi Here
                        icon: Image.asset(
                          "assets/logos/univali.png",
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
