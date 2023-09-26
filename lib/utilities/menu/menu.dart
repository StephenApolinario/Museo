import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:museo/constants/colors.dart' as custom_color;
import 'package:museo/constants/routes.dart';
import 'package:museo/constants/urls.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/gen/assets.gen.dart';
import 'package:museo/utilities/menu/menu_items.dart';
import 'package:museo/views/user/login_view.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: custom_color.mainBlue,
      child: Column(
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
                      child: Text(
                        context.loc.login_or_register,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        context.loc.forget_password,
                        style: const TextStyle(
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
            children: [
              menuItem(
                context: context,
                icon: Icons.house_outlined,
                title: context.loc.home,
                route: home,
              ),
              menuItem(
                context: context,
                icon: Icons.favorite,
                title: context.loc.favorite,
                route: favorites,
              ),
              menuItem(
                context: context,
                icon: Icons.search,
                title: context.loc.search,
                route: search,
              ),
              menuItem(
                context: context,
                icon: Icons.segment,
                title: context.loc.sections,
                route: sections,
              ),
              menuItem(
                context: context,
                icon: Icons.map,
                // TODO -> Title retrived by context.loc
                title: 'LOCALIZAÇÃO',
                onTapAction: () {
                  return openMapsSheet(context);
                },
              ),
              menuItem(
                context: context,
                icon: Icons.store,
                title: context.loc.souvenirs,
                route: souvernirs,
              ),
              menuItem(
                context: context,
                icon: Icons.airplane_ticket,
                title: context.loc.store,
                route: store,
              ),
              menuItem(
                context: context,
                icon: Icons.museum,
                title: context.loc.about_movi,
                route: aboutMovi,
              ),
              menuItem(
                context: context,
                icon: Icons.info,
                title: context.loc.about_application,
                route: aboutApplication,
              ),
            ],
          ),
          // Logos on bottom
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
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
                      Assets.logos.movi.path,
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
                    icon: Image.asset(
                      Assets.logos.univali.path,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

openMapsSheet(context) async {
  try {
    final coords = Coords(
      -26.754003,
      -48.687816,
    );
    const title = 'Museu Oceanográfico Univali';
    final availableMaps = await MapLauncher.installedMaps;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                for (var map in availableMaps)
                  ListTile(
                    onTap: () => map.showMarker(
                      coords: coords,
                      title: title,
                      description:
                          'Museu universitário com grande variedade de vida marinha e ênfase na fauna local.',
                    ),
                    title: Text(map.mapName),
                    leading: SvgPicture.asset(
                      map.icon,
                      height: 30.0,
                      width: 30.0,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  } catch (e) {
    rethrow;
  }
}
